import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../features/home/domain/global_variables.dart';

class EventNameField extends StatelessWidget {
  const EventNameField({Key? key, required this.fieldKey}) : super(key: key);
  final GlobalKey<FormBuilderFieldState> fieldKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'name',
      key: fieldKey,
      decoration: const InputDecoration(
        labelText: 'Event Name',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
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
    return FormBuilderTextField(
      name: desc,
      key: fieldKey,
      initialValue: currDescription,
      decoration: InputDecoration(
        labelText: desc,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
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
    return FormBuilderTextField(
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
    );
  }
}

class InterestsField extends StatefulWidget {
  const InterestsField(
      {super.key, required this.fieldKey, this.selectedInterests});

  final List<String>? selectedInterests;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  State<InterestsField> createState() => _InterestsFieldState();
}

class _InterestsFieldState extends State<InterestsField> {
  @override
  Widget build(BuildContext context) {
    String fieldName = 'Interests';
    return FormBuilderTextField(
      name: fieldName,
      key: widget.fieldKey,
      initialValue: widget.selectedInterests?.join(','),
      decoration: InputDecoration(
        labelText: fieldName,
        hintText: 'Example: computer science, animation, music',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
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
    return FormBuilderTextField(
      name: fieldName,
      key: fieldKey,
      initialValue: currLocation,
      decoration: InputDecoration(
        labelText: fieldName,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }
}

class EventDateField extends StatelessWidget {
  const EventDateField({super.key, required this.fieldKey, this.currDate});

  final DateTime? currDate;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Date';
    return FormBuilderDateTimePicker(
      name: fieldName,
      key: fieldKey,
      initialValue: currDate,
      inputType: InputType.date,
      decoration: InputDecoration(
        labelText: fieldName,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }
}

class GroupIDField extends StatelessWidget {
  const GroupIDField({super.key, required this.fieldKey, this.currGroupID});

  final String? currGroupID;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Group ID';
    return FormBuilderTextField(
      name: fieldName,
      key: fieldKey,
      initialValue: currGroupID,
      decoration: InputDecoration(
        labelText: fieldName,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }
}

class UsersField extends StatelessWidget {
  const UsersField({super.key, required this.fieldKey, this.currUsers});

  final String? currUsers;
  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Users';
    return FormBuilderTextField(
      name: fieldName,
      key: fieldKey,
      initialValue: currUsers,
      decoration: InputDecoration(
        labelText: fieldName,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }
}
