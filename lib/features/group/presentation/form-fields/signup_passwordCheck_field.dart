import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'field_padding.dart';

class SignupPasswordCheckField extends StatelessWidget {
  const SignupPasswordCheckField({
    super.key,
    required this.fieldKey,
    this.getPassword,
  });

  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;
  final ValueGetter<String?>? getPassword;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Re-type your password';
    String? firstPassword = getPassword?.call();
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Must match the above password',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.match(firstPassword!),
        ]),
        obscureText: true,
      ),
    );
  }
}
