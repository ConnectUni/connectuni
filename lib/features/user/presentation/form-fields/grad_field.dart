import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../group/presentation/form-fields/field_padding.dart';

/// A text field to change Graduation Year Names.
class GradField extends StatelessWidget {
  const GradField({super.key, required this.fieldKey, this.currGrad});

  final String? currGrad;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Projected Graduation:';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currGrad,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "Spring 2025"',
        ),
      ),
    );
  }
}
