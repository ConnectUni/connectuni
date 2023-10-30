import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({super.key, required this.fieldKey});

  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Email';

    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Ex: "john@foo.com',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
