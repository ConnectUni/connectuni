import 'package:connectuni/features/event/presentation/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../interest/data/interests.dart';
import '../data/event_providers.dart';
import '../domain/event.dart';
import '../../home/domain/global_variables.dart';
import '../domain/event_list.dart';

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

  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    final List<SingleEvent>? filteredEventList = ref.watch(filteredEvents);
    final bool isSearchbarFilled = ref.watch(isSearchFilledProvider);
    final EventList eventsDB = ref.watch(eventsDBProvider);
    final List<String> interestsDB = ref.watch(interestsProvider);

    final _interests = interestsDB
        .map((interest) => MultiSelectItem(interest, interest))
        .toList();

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
            child: MultiSelectBottomSheetField(
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
              onConfirm: (results) { // This updates the selected filters on confirm
                selectedFilters = List<String>.from(results);
                ref.read(selectedFiltersProvider.notifier).update((state) => selectedFilters);
              },
              onSelectionChanged: (results) { // This updates the selected filters on selection change
                selectedFilters = List<String>.from(results);
                ref.read(selectedFiltersProvider.notifier).update((state) => selectedFilters);
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (item) { // This removes the selected filter on tap
                  selectedFilters.remove(item);
                  selectedFilters = List<String>.from(selectedFilters);
                  ref.read(selectedFiltersProvider.notifier).update((state) => selectedFilters);
                  return selectedFilters;
                },
              ),
              isDismissible: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: isSearchbarFilled ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      ref.read(searchQueryProvider.notifier).update((state) => state = "");
                    }
                  ) : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.blue),
                  )
              ),
              onChanged: (value) { // This updates the page based on the search query
                ref.read(searchQueryProvider.notifier).update((state) => state = value);
                //showSearchedEvent(value);
              },
            ),
          ),
          if(eventsDB.getAllEvents().isEmpty)
            const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text(
                        "There are no events yet!",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Consider making one!",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                )
            ),
          if(eventsDB.getAllEvents().isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: filteredEventList?.length,
              itemBuilder: (context, index) {
                return EventCardWidget(eventId: filteredEventList![index].eventID);
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
