import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/event/domain/event_collection.dart';
import 'package:connectuni/features/event/presentation/edit_event_controller.dart';
import 'package:connectuni/features/event/presentation/event_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group/domain/group.dart';
import '../../group/domain/group_collection.dart';
import '../../user/domain/user.dart';
import '../data/event_providers.dart';
import '../domain/event.dart';
import '../domain/event_list.dart';
import 'search_events_screen.dart';
import '../../group/data/group_providers.dart';
import 'form-fields/event_form_fields.dart';



class CreateEvent extends ConsumerWidget {
  CreateEvent({Key? key}) : super(key: key);

  static const routeName = '/create_event';
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
            groups: allData.groups,
            currentUser: allData.currentUser,
            ref: ref,
          ),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<SingleEvent> events,
    required List<Group> groups,
    required User currentUser,
    required WidgetRef ref}) {
    EventCollection eventCollection = EventCollection(events);
    GroupCollection groupCollection = GroupCollection(groups);

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      String name = _eventNameFieldKey.currentState?.value;
      String location = _locationFieldKey.currentState?.value;
      DateTime date = _dateFieldKey.currentState?.value;
      String icon = _iconFieldKey.currentState?.value;
      String description = _descriptionFieldKey.currentState?.value;
      String groupID = _groupIDFieldKey.currentState?.value;

      // Create a new event
      SingleEvent newEvent = SingleEvent(
        eventID: eventCollection.getNewID(),
        eventName: name,
        eventIcon: icon,
        eventLocation: location,
        eventDescription: description,
        eventDate: date,
        groupID: groupID,
        userIDs: [],
        interests: [],
      );
      ref.read(editEventControllerProvider.notifier).updateEvent(
        event: newEvent,
        onSuccess: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EventInfoScreen(event: newEvent),
            ),
          );
        }
      );
    }

    void onReset() {
      _formKey.currentState?.reset();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Event'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      EventNameField(fieldKey: _eventNameFieldKey),
                      EventLocationField(fieldKey: _locationFieldKey),
                      EventDateField(fieldKey: _dateFieldKey),
                      EventIconField(fieldKey: _iconFieldKey),
                      EventDescriptionField(fieldKey: _descriptionFieldKey),
                      GroupIDField(fieldKey: _groupIDFieldKey, groupNames: groupCollection.getAllGroupNames()),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: onSubmit, child: const Text('Submit')),
                    const SizedBox(width: 10),
                    ElevatedButton(onPressed: onReset, child: const Text('Reset')),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
