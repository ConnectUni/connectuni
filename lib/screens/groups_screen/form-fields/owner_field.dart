import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to support defining new or revised garden names.
class OwnerField extends StatelessWidget {
  const OwnerField({super.key, required this.fieldKey, this.currOwner});

  final String? currOwner;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Owner';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currOwner,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "Professor Adams"',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
