import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to support defining new or revised garden names.
class GroupNameField extends StatelessWidget {
  const GroupNameField({super.key, required this.fieldKey, this.currName});

  final String? currName;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Group Name';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currName,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "JPN 102"',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
