
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../all_data_provider.dart';
import '../../cu_error.dart';
import '../../cu_loading.dart';
import '../../group/domain/group.dart';
import '../../group/presentation/form-fields/reset_button.dart';
import '../../group/presentation/form-fields/submit_button.dart';
import '../../user/domain/user.dart';
import '../domain/event.dart';
import '../domain/event_collection.dart';
import 'edit_event_controller.dart';
import 'form-fields/event_form_fields.dart';

class EditEvent extends ConsumerWidget {
  final String id;
  EditEvent({super.key, required this.id});

  static const routeName = '/edit_event';

  final _formKey = GlobalKey<FormBuilderState>();
  final _eventNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _locationFieldKey = GlobalKey<FormBuilderFieldState>();
  final _dateFieldKey = GlobalKey<FormBuilderFieldState>();
  final _iconFieldKey = GlobalKey<FormBuilderFieldState>();
  final _descriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final _groupIDFieldKey = GlobalKey<FormBuilderFieldState>();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) =>
            _build(
                context: context,
                events: allData.events,
                currentUser: allData.currentUser,
                ref: ref,
                groups: allData.groups
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Text(e.toString())
    );
  }

  Widget _build ({
    required BuildContext context,
    required List<SingleEvent> events,
    required List<Group> groups,
    required User currentUser,
    required WidgetRef ref
  }) {
    EventCollection eventCollection = EventCollection(events);
    GroupCollection groupCollection = GroupCollection(groups);
    SingleEvent uneditedEvent = eventCollection.getEvent(id);

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String eventID = id;
      String eventName = _eventNameFieldKey.currentState?.value;
      String location = _locationFieldKey.currentState?.value;
      DateTime date = _dateFieldKey.currentState?.value;
      String icon = _iconFieldKey.currentState?.value ?? '';
      String description = _descriptionFieldKey.currentState?.value ?? '';
      String groupID = _groupIDFieldKey.currentState?.value;
      SingleEvent editedEvent = SingleEvent(
          eventID: eventID,
          eventName: eventName,
          eventLocation: location,
          eventDate: date.toString(),
          eventIcon: icon,
          eventDescription: description,
          groupID: groupID,
          userIDs: uneditedEvent.userIDs,
          interests: uneditedEvent.interests,
      );
      ref.read(editEventControllerProvider.notifier).updateEvent(
        event: editedEvent,
        onSuccess: () {
          Navigator.pop(context);
        },
      );
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    Widget editEventForm() => ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                  children: [
                    EventNameField(fieldKey: _eventNameFieldKey, name: uneditedEvent.eventName),
                    EventLocationField(fieldKey: _locationFieldKey, currLocation: uneditedEvent.eventLocation),
                    EventDateField(fieldKey: _dateFieldKey),
                    EventIconField(fieldKey: _iconFieldKey, ),
                    EventDescriptionField(fieldKey: _descriptionFieldKey, currDescription: uneditedEvent.eventDescription),
                    GroupIDField(fieldKey: _groupIDFieldKey, currGroup: uneditedEvent.groupID, groupNames: groupCollection.getAllGroupNames()),
                  ]
              ),
            ),
            Row(
                children: [
                  SubmitButton(onSubmit: onSubmit),
                  ResetButton(onReset: onReset),
                ]
            )
          ],
        ),
      ],
    );

    AsyncValue asyncUpdate = ref.watch(editEventControllerProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Event'),
        ),
        body: asyncUpdate.when(
            data: (_) => editEventForm(),
            error: (e, st) => CUError(e.toString(), st.toString()),
            loading: () => const CULoading()));
  }
}