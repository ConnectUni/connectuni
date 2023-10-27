import 'package:connectuni/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/event_form_fields.dart';
import '../model/event.dart';
import '../model/event_list.dart';


class CreateEvent extends ConsumerWidget {
  CreateEvent({Key? key}) : super(key: key);

  static const routeName = '/addEventView';
  final _formKey = GlobalKey<FormBuilderState>();
  final _eventNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _locationFieldKey = GlobalKey<FormBuilderFieldState>();
  final _dateFieldKey = GlobalKey<FormBuilderFieldState>();
  final _iconFieldKey = GlobalKey<FormBuilderFieldState>();
  final _descriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final _groupIDFieldKey = GlobalKey<FormBuilderFieldState>();
  final _usersFieldKey = GlobalKey<FormBuilderFieldState>();
  final _interestsFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EventList eventDB = ref.watch(eventsDBProvider);

    void onSubmit() {
      bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;
      int id = eventDB.allEvents.length + 1;
      String getEventID() {
        if (id < 10) {
          return "group-00$id";
        } else if (id < 100) {
          return "group-0$id";
        } else {
          return "group-$id";
        }
      }
      String name = _eventNameFieldKey.currentState?.value;
      String location = _locationFieldKey.currentState?.value;
      DateTime date = _dateFieldKey.currentState?.value;
      String icon = _iconFieldKey.currentState?.value;
      String description = _descriptionFieldKey.currentState?.value;
      String groupID = _groupIDFieldKey.currentState?.value;
      List<String> userIDs = (_usersFieldKey.currentState?.value ?? '').split(','); // assuming comma-separated
      List<String> interests = (_interestsFieldKey.currentState?.value ?? '').split(','); // assuming comma-separated

      // Create a new event
      eventDB.addEvent(
        SingleEvent(
          eventID: getEventID(),
          eventName: name,
          eventIcon: icon,
          eventLocation: location,
          eventDescription: description,
          eventDate: date,
          groupID: groupID,
          userIDs: userIDs,
          interests: interests,
        )
      );
      ref.refresh(eventsDBProvider);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
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
                      InterestsField(fieldKey: _interestsFieldKey),
                      GroupIDField(fieldKey: _groupIDFieldKey),
                      UsersField(fieldKey: _usersFieldKey),
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