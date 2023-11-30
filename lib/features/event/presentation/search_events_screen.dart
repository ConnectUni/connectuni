import 'package:connectuni/features/event/presentation/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../all_data_provider.dart';
import '../../cu_error.dart';
import '../../cu_loading.dart';
import '../data/event_providers.dart';
import '../domain/event.dart';

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
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
      data: (allData) =>
          _build(
            context: context,
            interests: allData.interests,
            ref: ref,
          ),
      error: (e, st) => CUError(e.toString(),  st.toString()),
      loading: () => const CULoading(),
    );
  }

  Widget _build({
    required BuildContext context,
    required List<String> interests,
    required WidgetRef ref
  }) {
    final AsyncValue<List<SingleEvent>> asyncFilteredEvents = ref.watch(filteredEventsProvider);

    final _interests = interests
        .map((interest) => MultiSelectItem<String>(interest, interest))
        .toList();

    bool isSearchbarFilled() {
      return controller.text.isNotEmpty;
    }

    /// This displays the appbar.
    AppBar buildAppbar() => AppBar(
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
    );

    /// This displays the filter bar.
    Widget buildFilterBar() => Padding(
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
          ref.watch(filteredEventsProvider.notifier).updateFilters(selectedFilters);
        },
        onSelectionChanged: (results) { // This updates the selected filters on selection change
          selectedFilters = List<String>.from(results);
          ref.watch(filteredEventsProvider.notifier).updateFilters(selectedFilters);
        },
        chipDisplay: MultiSelectChipDisplay(
          onTap: (item) { // This removes the selected filter on tap
            selectedFilters.remove(item);
            selectedFilters = List<String>.from(selectedFilters);
            ref.watch(filteredEventsProvider.notifier).updateFilters(selectedFilters);
            return selectedFilters;
          },
        ),
        isDismissible: false,
      ),
    );

    /// This displays the search bar.
    Widget buildSearchBar() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: isSearchbarFilled() ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  ref.watch(filteredEventsProvider.notifier).filterQuery('');
                }
            ) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.blue),
            )
        ),
        onChanged: (value) { // This updates the page based on the search query
          ref.watch(filteredEventsProvider.notifier).filterQuery(value);
        },
      ),
    );

    /// This displays the list of events.
    Widget showContent(List<SingleEvent> filteredEvents) => Expanded(
      child: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          return EventCardWidget(event: filteredEvents[index]);
        },
      ),
    );

    Widget buildContent() => asyncFilteredEvents.when(
      data: (filteredEvents) => showContent(filteredEvents),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading(),
    );

    return Scaffold(
      appBar: buildAppbar(),
      body: Column(
        children: [
          buildFilterBar(),
          buildSearchBar(),
          buildContent(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_event');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
