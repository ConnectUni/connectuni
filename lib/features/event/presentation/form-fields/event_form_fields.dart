import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../group/presentation/form-fields/field_padding.dart';


class EventNameField extends StatelessWidget{
  const EventNameField({Key? key, required this.fieldKey}) : super(key: key);
  final GlobalKey<FormBuilderFieldState> fieldKey;

  @override
  Widget build(BuildContext context) {
    return FieldPadding(
        child: FormBuilderTextField(
          name: 'name',
          key: fieldKey,
          decoration: const InputDecoration(
            labelText: 'Event Name',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
    );
  }
}

class EventDescriptionField extends StatelessWidget {
  const EventDescriptionField(
      {super.key, required this.fieldKey, this.currDescription});

  final String? currDescription;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String desc = 'Description';
    return FieldPadding(
        child: FormBuilderTextField(
          name: desc,
          key: fieldKey,
          initialValue: currDescription,
          decoration: InputDecoration(
            labelText: desc,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
    );
  }
}

class EventIconField extends StatelessWidget {
  const EventIconField({super.key, required this.fieldKey, this.currPhoto});

  final String? currPhoto;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Photo';
    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        initialValue: currPhoto,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Example: event.jpg',
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}


class EventLocationField extends StatelessWidget {
  const EventLocationField(
      {super.key, required this.fieldKey, this.currLocation});

  final String? currLocation;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Location';
    return FieldPadding (
        child: FormBuilderTextField(
          name: fieldName,
          key: fieldKey,
          initialValue: currLocation,
          decoration: InputDecoration(
            labelText: fieldName,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
    );
  }
}

class EventDateField extends StatelessWidget {
  const EventDateField(
      {super.key, required this.fieldKey, this.currDate});

  final DateTime? currDate;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Date';
    return FieldPadding(
      child: FormBuilderDateTimePicker(
        name: fieldName,
        key: fieldKey,
        initialValue: currDate,
        inputType: InputType.both,
        decoration: InputDecoration(
          labelText: fieldName,
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}

class GroupIDField extends StatelessWidget {
  const GroupIDField(
      {super.key,
        required this.fieldKey,
        required this.groupNames,
        this.currGroup});

  final String? currGroup;
  final List<String> groupNames;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
  fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Group';
    return FieldPadding(
      child: FormBuilderDropdown<String>(
        name: fieldName,
        initialValue: currGroup,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
        ),
        validator:
        FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: groupNames
            .map((name) => DropdownMenuItem(
          alignment: AlignmentDirectional.centerStart,
          value: name,
          child: Text(name),
        ))
            .toList(),
        valueTransformer: (val) => val?.toString(),
      ),
    );
  }
}