import 'package:flutter/material.dart';
import '../domain/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventInfoScreen extends ConsumerWidget {
  const EventInfoScreen({Key? key, required this.event}) : super(key: key);

  final SingleEvent event;
  static const String routeName = '/event_info';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                title: Text(event.eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.asset(
                  event.eventIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  event.eventDescription,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Location: ${event.eventLocation}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Date: ${event.eventDate}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Members going: ${event.userIDs.length}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Add event to user');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Join Event',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
