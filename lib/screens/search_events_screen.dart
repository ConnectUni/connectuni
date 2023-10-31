import 'package:connectuni/components/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../model/event.dart';
import '../model/event_list.dart';
import '../utils/global_variables.dart';

class SearchEventsScreen extends ConsumerStatefulWidget {
  const SearchEventsScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_events';
  final PageController pageController;

  @override
  ConsumerState<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

class _SearchEventsScreenState extends ConsumerState<SearchEventsScreen> {
  final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  List<String> selectedFilters = [];
  List<SingleEvent> events = [];
  List<SingleEvent> showSearchedEvent(String query) {
    final suggestions = ref.watch(eventsDBProvider).getAllEvents().where((event) {
      if(selectedFilters.isNotEmpty) {
        return event.eventName.toLowerCase().contains(query.toLowerCase()) && event.interests.any((interest) => selectedFilters.contains(interest));
      } else {
        return event.eventName.toLowerCase().contains(query.toLowerCase());
      }
    }).toList();
    setState(() {
      events = suggestions;
    });

    return suggestions;
  }

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
              widget.pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_search,
              semanticLabel: 'Search for people',
            ),
            onPressed: () {
              widget.pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiSelectDialogField(
              items: _interests,
              title: const Text("Interests"),
              selectedColor: Colors.blue,
              selectedItemsTextStyle: const TextStyle(color: Colors.black),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.filter_alt,
                color: Colors.blue,
              ),
              buttonText: Text(
                "Filter by:",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 16,
                ),
              ),
              listType: MultiSelectListType.CHIP,
              onConfirm: (results) {
                selectedFilters = List<String>.from(results);
                showSearchedEvent(controller.text);
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (item) {
                  setState(() {
                    selectedFilters.remove(item);
                    showSearchedEvent(controller.text);
                  });
                  return selectedFilters;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.blue),
                  )
              ),
              onChanged: showSearchedEvent,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventCardWidget(eventId: events[index].eventID);
              },
            ),
          ),
        ],
      ),
    );
  }
}
