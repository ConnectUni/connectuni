import 'package:connectuni/features/event/presentation/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../data/event_providers.dart';
import '../domain/event.dart';
import '../../home/domain/global_variables.dart';

class SearchEventsScreen extends ConsumerStatefulWidget {
  const SearchEventsScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_events';
  final PageController pageController;

  @override
  ConsumerState<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

final selectedFiltersProvider = StateProvider<List<String>?>((ref) => []);

final filteredEvents = Provider<List<SingleEvent>>((ref) {
  final filters = ref.watch(selectedFiltersProvider);
  final events = ref.watch(eventsDBProvider).getAllEvents();

  if (filters!.isNotEmpty) {
    return events.where((event) => event.interests.any((interest) => filters.contains(interest))).toList();
  } else {
    return events;
  }
});


class _SearchEventsScreenState extends ConsumerState<SearchEventsScreen> {
  final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    final List<SingleEvent> filteredEventList = ref.watch(filteredEvents);

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
                ref.read(selectedFiltersProvider.notifier).update((state) => selectedFilters);
                //showSearchedEvent(controller.text);
              },
              onSelectionChanged: (results) {
                selectedFilters = List<String>.from(results);
                ref.read(selectedFiltersProvider.notifier).update((state) => selectedFilters);
                //showSearchedEvent(controller.text);
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (item) {
                  selectedFilters.remove(item);
                  selectedFilters = List<String>.from(selectedFilters);
                  ref.read(selectedFiltersProvider.notifier).update((state) => selectedFilters);
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
              //onChanged: showSearchedEvent,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEventList.length,
              itemBuilder: (context, index) {
                return EventCardWidget(eventId: filteredEventList[index].eventID);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createevent');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
