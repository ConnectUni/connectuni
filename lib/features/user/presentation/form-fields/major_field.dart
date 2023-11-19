import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../group/presentation/form-fields/field_padding.dart';

/// A text field to change Major Names.
class MajorField extends StatelessWidget {
  const MajorField({super.key, required this.fieldKey, this.currMajor});

  final String? currMajor;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Major:';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currMajor,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "Liberal Arts"',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
