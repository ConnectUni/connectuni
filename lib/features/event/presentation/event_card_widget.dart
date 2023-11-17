import 'package:connectuni/features/event/domain/event.dart';
import 'package:connectuni/features/event/presentation/event_card_view.dart';
import 'package:connectuni/features/event/presentation/event_info_screen.dart';
import 'package:flutter/cupertino.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({Key? key, required this.event}) : super(key: key);

  final SingleEvent event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => EventInfoScreen(event: event)
          )
        );
      },
      child: EventCardView(event: event),
    );
  }
}
