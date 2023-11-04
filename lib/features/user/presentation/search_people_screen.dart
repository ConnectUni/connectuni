import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_providers.dart';
import 'user_card_widget.dart';
import '../domain/user.dart';
import '../../home/domain/global_variables.dart';

class SearchPeopleScreen extends ConsumerStatefulWidget {
  const SearchPeopleScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_people';
  final PageController pageController;

  @override
  ConsumerState<SearchPeopleScreen> createState() => _SearchPeopleScreenState();
}

class _SearchPeopleScreenState extends ConsumerState<SearchPeopleScreen> {
  // final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  final controller = TextEditingController();
  List<String> selectedFilters = [];
  List<User> recentSearches = [];

  @override
  Widget build(BuildContext context) {
    final List<User>? filteredUserList = ref.watch(filteredUsers);
    final bool isSearchbarFilled = ref.watch(isSearchFilledProvider);
    final List<User>? recentSearches = ref.watch(recentSearchesProvider);
    var users = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for People'),
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
              Icons.celebration,
              semanticLabel: 'Search for events',
            ),
            onPressed: () {
              widget.pageController.animateToPage(2,
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
              title: const Text("People"),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    ref.read(searchQueryProvider.notifier).update((state) => "");
                  },
                )
              ),
              onChanged: (value) { // This updates the page based on the search query
                ref.read(searchQueryProvider.notifier).update((state) => value);
              },
            ),
          ),
          if (isSearchbarFilled) ...[
            SearchView(users: filteredUserList!)
          ] else ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                      children: [
                        const Text('Recent Searches'),
                        const Spacer(),
                        if (recentSearches!.isNotEmpty) ...[
                          InkWell(
                            child: const Text('Clear Recents', style: TextStyle(color: Colors.blue)),
                            onTap: () {
                              ref.read(recentSearchesProvider.notifier).clear();
                            },
                          ),
                        ]
                      ]
                  ),
                  const Divider(),
                ],
              ),
            ),
            SearchView(users: recentSearches!)
          ]
        ],
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key, required this.users}) : super(key: key);
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCardWidget(onSearchPage: true, user: users[index]);
        },
      ),
    );
  }
}
