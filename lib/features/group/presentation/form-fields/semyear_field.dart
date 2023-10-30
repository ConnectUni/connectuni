import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to support defining new or revised garden names.
class SemYearField extends StatelessWidget {
  const SemYearField({super.key, required this.fieldKey, this.currSemYear});

  final String? currSemYear;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldSemYear = 'Semester & Year';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldSemYear,
        key: fieldKey,
        initialValue: currSemYear,
        decoration: InputDecoration(
          labelText: fieldSemYear,
          hintText: 'Example: "Fall 2024"',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
