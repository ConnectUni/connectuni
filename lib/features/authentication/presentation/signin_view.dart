import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/presentation/home.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import 'decorations.dart';
import 'forgot_password_view.dart';
import 'verify_email_view.dart';

/// Builds the page containing fields to enter a username and password, plus buttons.
class SignInView extends ConsumerWidget {
  const SignInView({Key? key}) : super(key: key);

  static const routeName = '/signin';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersDB = ref.watch(userDBProvider);
    return SignInScreen(
      actions: [
        ForgotPasswordAction((context, email) {
          Navigator.pushNamed(
            context,
            ForgotPasswordView.routeName,
            arguments: {'email': email},
          );
        }),
        AuthStateChangeAction<SignedIn>((context, state) {
          if (!state.user!.emailVerified) {
            Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else {
            String email = state.user!.email!;
            User exists = usersDB.getUserByEmail(email)!;
            if (exists == null) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            } else {
              ref.read(currentUserProvider.state).state = exists.uid;
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            }
          }
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          if (!state.credential.user!.emailVerified) {
            Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else {
            String email = state.credential.user!.email!;
            User exists = usersDB.getUserByEmail(email)!;
            if (exists == null) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            } else {
              ref.read(currentUserProvider.state).state = exists.uid;
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            }
          }
        }),
        AuthStateChangeAction<CredentialLinked>((context, state) {
          if (!state.user.emailVerified) {
            Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else {
            String email = state.user.email!;
            User exists = usersDB.getUserByEmail(email)!;
            if (exists == null) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            } else {
              ref.read(currentUserProvider.state).state = exists.uid;
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            }
          }
        }),
      ],
      styles: const {
        EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
      },
      headerBuilder: headerImage('assets/images/Logo.png'),
      sideBuilder: sideImage('assets/images/Logo.png'),
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            action == AuthAction.signIn
                ? 'Welcome to ConnectUni! Please sign in.'
                : 'Welcome to ConnectUni! Please create an account.',
          ),
        );
      },
      footerBuilder: (context, action) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              action == AuthAction.signIn
                  ? 'By signing in, you agree to our terms and conditions.'
                  : 'By registering, you agree to our terms and conditions.',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
