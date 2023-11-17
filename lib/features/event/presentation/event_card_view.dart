import 'package:flutter/material.dart';
import '../domain/event.dart';

class EventCardView extends StatelessWidget {
  const EventCardView({Key? key, required this.event}) : super(key: key);

  final SingleEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            ListTile(
                title: Text(
              event.eventName,
              style: Theme.of(context).textTheme.titleLarge,
            )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 2.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${event.eventLocation} | ${event.eventDate}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 2.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  event.eventDescription,
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
