import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/event.dart';
import '../model/event_list.dart';

class EventCardView extends ConsumerWidget {
  const EventCardView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EventList eventsDB = ref.watch(eventsDBProvider);
    SingleEvent thisEvent = eventsDB.getEventById(id);

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
