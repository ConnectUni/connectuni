import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'field_padding.dart';

/// A text field to support defining new or revised garden names.
class GroupImageField extends StatelessWidget {
  const GroupImageField({super.key, required this.fieldKey, this.currImage});

  final String? currImage;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Group Image (Optional)';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currImage,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: "group-00X.png"',
        ),
      ),
    );
  }
}
