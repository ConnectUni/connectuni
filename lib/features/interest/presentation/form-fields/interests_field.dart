import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../group/presentation/form-fields/field_padding.dart';
import '../../data/interests.dart';

/// A text field to support defining new or revised garden names.
class InterestsField extends ConsumerWidget {
  const InterestsField({super.key, required this.fieldKey, required this.currInterests});

  final List<String> currInterests;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> interestsDB = ref.watch(interestsProvider);
    String fieldName = 'Group Image (Optional)';
    return FieldPadding(
      child: FormBuilderCheckboxGroup(
        name: fieldName,
        key: fieldKey,
        initialValue: currInterests,
        options: interestsDB
            .map((interest) => FormBuilderFieldOption(value: interest))
            .toList(),
      ),
    );
  }
}
