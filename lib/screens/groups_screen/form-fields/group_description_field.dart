import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to support defining new or revised garden names.
class GroupDescriptionField extends StatelessWidget {
  const GroupDescriptionField({super.key, required this.fieldKey, this.currDesc});

  final String? currDesc;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Group Description (Optional)';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currDesc,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "This group is created to study ..."',
        ),
      ),
    );
  }
}
