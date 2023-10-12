import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../model/event_db.dart';
import '../model/event_card_view.dart';

class SearchEventsScreen extends StatefulWidget {
  const SearchEventsScreen({Key? key, required this.pageController}) : super(key: key);

  static const String routeName = '/search_events';
  final PageController pageController;

  @override
  State<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

class _SearchEventsScreenState extends State<SearchEventsScreen> {
  final _items = eventsDB.getAllEvents().map((eName) => MultiSelectItem(eName, eName.eventName)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for Events'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.group,
              semanticLabel: 'Search for groups',
            ),
            onPressed: () {
              widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_search,
              semanticLabel: 'Search for people',
            ),
            onPressed: () {
              widget.pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelectDialogField(
                items: _items,
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
                buttonText: const Text(
                  "Filter by:",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  // TODO: Filter the events list
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    hintText: "Search...",
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        controller.closeView(item);
                      },
                    );
                  });
                },
              ),
            ),
            const Text(
              'Events',
              textAlign: TextAlign.left,
            ),
            ...eventsDB
            .getAllEvents()
            .map((eid) => EventCardView(id: eid.eventId))
          ],
        ),
      ),
    );
  }
}
