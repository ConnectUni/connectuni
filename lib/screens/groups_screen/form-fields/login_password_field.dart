import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../model/user_list.dart';
import 'field_padding.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField(
      {super.key,
      required this.fieldKey,
      this.getPassword,
      required this.userList,
      this.email});

  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  final ValueGetter<String?>? getPassword;
  final ValueGetter<String?>? email;
  final UserList userList;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Password';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: "Enter your password",
        ),
        validator: (input) {
          if (input!.isEmpty) {
            return 'This field is required';
          }
          // Use the callback to get the email value
          String? inputEmail = email?.call();
          if (input != userList.getPassword(inputEmail!)) {
            return "Password is incorrect";
          }
          return null; // return null if validation passes
        },
        obscureText: true,
      ),
    );
  }
}
