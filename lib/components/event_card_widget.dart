import 'package:connectuni/components/event_card_view.dart';
import 'package:connectuni/screens/event_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({Key? key, required this.eventId}) : super(key: key);

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => EventInfoScreen(id: eventId)
          )
        );
      },
      child: EventCardView(id: eventId),
    );
  }
}