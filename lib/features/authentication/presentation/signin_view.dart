import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/user/domain/user_collection.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../all_data_provider.dart';
import '../../home/presentation/home.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../../user/presentation/add_user.dart';
import 'decorations.dart';
import 'forgot_password_view.dart';
import 'verify_email_view.dart';

/// Builds the page containing fields to enter a username and password, plus buttons.
class SignInView extends ConsumerWidget {
  const SignInView({Key? key}) : super(key: key);

  static const routeName = '/signin';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) => _build(
          context: context,
          users: allData.users,
          currentUser: allData.currentUser,
          ref: ref),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required User currentUser,
    required WidgetRef ref
  }) {
    UserCollection userCollection = UserCollection(users);

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
          } else if (userCollection.getUserByEmail(state.user!.email!) == null) {
            Navigator.pushReplacementNamed(context, AddUser.routeName);
          } else {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          }
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          if (!state.credential.user!.emailVerified) {
            Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, AddUser.routeName);
          }
        }),
        AuthStateChangeAction<CredentialLinked>((context, state) {
          if (!state.user.emailVerified) {
            Navigator.pushNamed(context, VerifyEmailView.routeName);
          } else if (userCollection.getUserByEmail(state.user!.email!) == null) {
            Navigator.pushReplacementNamed(context, AddUser.routeName);
          } else {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
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
