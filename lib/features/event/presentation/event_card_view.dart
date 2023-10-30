import 'package:flutter/material.dart';
import '../domain/event.dart';
import '../domain/event_list.dart';

class EventCardView extends StatelessWidget {
  const EventCardView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    SingleEvent thisEvent = TempEventsDB.getEventById(id);

    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            ListTile(
                title: Text(
              thisEvent.eventName,
              style: Theme.of(context).textTheme.titleLarge,
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 2.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${thisEvent.eventLocation} | ${thisEvent.eventDate}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 2.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  thisEvent.eventDescription,
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
