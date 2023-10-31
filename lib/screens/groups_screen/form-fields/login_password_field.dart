import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key, required this.fieldKey});

  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String? passwordError;
    String fieldName = 'Password';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: "Enter your password",
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        obscureText: true,
      ),
    );
  }
}
