import 'package:flutter/material.dart';

import '../model/event_db.dart';

class EventInfoScreen extends StatelessWidget {
  const EventInfoScreen({Key? key, required this.id}) : super(key: key);

  final String id;
  static const String routeName = '/event_info';

  @override
  Widget build(BuildContext context) {
    Event thisEvent = eventsDB.getEventById(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(thisEvent.eventName,
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
