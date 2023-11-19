import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../group/presentation/form-fields/field_padding.dart';

/// A text field to change User Display Names.
class DisplayNameField extends StatelessWidget {
  const DisplayNameField({super.key, required this.fieldKey, this.currName});

  final String? currName;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Display Name:';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currName,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "Ron Johnson"',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
