import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'field_padding.dart';

class SignupPasswordField extends StatelessWidget {
  const SignupPasswordField({
    super.key,
    required this.fieldKey,
  });

  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

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
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(5),
        ]),
        obscureText: true,
      ),
    );
  }
}
