import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../model/group.dart';

/**
 * Implements a Calendar that is able to display events and their details.
 */

class EventCalendar extends StatefulWidget {
  const EventCalendar({
    super.key,
  });

  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  final _items = groupsDB.getAllGroups().map((gName) => MultiSelectItem(gName, gName.groupName)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Events Calendar'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiSelectDialogField(
              items: _items,
              title: const Text("Viewing events for group:"),
              selectedColor: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.filter,
                color: Colors.blue,
              ),
              buttonText: Text(
                "Filter by:",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 16,
                ),
              ),
              onConfirm: (results) {
                // TODO: Filter groups by results
              },
            ),
          ),
        ],
      ),
    ); //Scaffold
  } //build
} //HomePage
