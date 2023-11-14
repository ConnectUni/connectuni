import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../group/presentation/form-fields/field_padding.dart';

/// A text field to change Status Names.
class StatusField extends StatelessWidget {
  const StatusField({super.key, required this.fieldKey, this.currStatus});

  final String? currStatus;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Status:';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currStatus,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "Doing good today!"',
        ),
      ),
    );
  }
}
