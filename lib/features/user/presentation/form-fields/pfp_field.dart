import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../group/presentation/form-fields/field_padding.dart';

/// A text field to change Profile Picture Names.
class PfpField extends StatelessWidget {
  const PfpField({super.key, required this.fieldKey, this.currpfp});

  final String? currpfp;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Profile Picture:';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currpfp,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "dogpic.jpg"',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
