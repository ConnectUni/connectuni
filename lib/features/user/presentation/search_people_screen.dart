import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../interest/data/interests.dart';
import '../data/user_providers.dart';
import 'user_card_widget.dart';
import '../domain/user.dart';

class SearchPeopleScreen extends ConsumerStatefulWidget {
  const SearchPeopleScreen({
    super.key,
    required this.pageController
  });

  static const String routeName = '/search_people';
  final PageController pageController;

  @override
  ConsumerState<SearchPeopleScreen> createState() => _SearchPeopleScreenState();
}

class _SearchPeopleScreenState extends ConsumerState<SearchPeopleScreen> {
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  final controller = TextEditingController();
  List<String> selectedFilters = [];
  List<User> recentSearches = [];

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<User>> asyncFilteredUsers = ref.watch(filteredUsersProvider);
    return asyncFilteredUsers.when(
      data: (userList) =>
          _build(
            context: context,
            list: userList,
            ref: ref,
          ),
      loading: () => const CULoading(),
      error: (e, st) => CUError(e.toString(),  st.toString()));
  }

  Widget _build({
    required BuildContext context,
    required List<User> list,
    required WidgetRef ref,
  }) {
    final isRecentsEmpty = ref.watch(filteredUsersProvider.notifier).recents.isEmpty;
    bool isSearchbarFilled() {
      return controller.text.isNotEmpty;
    }

    /// This displays the appbar.
    AppBar buildAppBar() {
      return AppBar(
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
      );
    }

    /// This displays the filter bar.
    Widget buildFilterBar() {
      return Padding(
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
            ref.read(filteredUsersProvider.notifier).updateFilters(selectedFilters);
          },
          onSelectionChanged: (results) { // This updates the selected filters on selection change
            selectedFilters = List<String>.from(results);
            ref.read(filteredUsersProvider.notifier).updateFilters(selectedFilters);
          },
          chipDisplay: MultiSelectChipDisplay(
            onTap: (item) { // This removes the selected filter on tap
              selectedFilters.remove(item);
              selectedFilters = List<String>.from(selectedFilters);
              ref.read(filteredUsersProvider.notifier).updateFilters(selectedFilters);
              return selectedFilters;
            },
          ),
          isDismissible: false,
        ),
      );
    }

    /// This displays the search bar.
    Widget buildSearchBar() {
      return Padding(
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
            suffixIcon: isSearchbarFilled() ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  ref.read(filteredUsersProvider.notifier).filterQuery('');
                }
            ) : null,
          ),
          onChanged: (value) { // This updates the page based on the search query
            ref.read(filteredUsersProvider.notifier).filterQuery(value);
          },
        ),
      );
    }

    /// This displays the search content.
    List<Widget> showContent = [
      if (!isSearchbarFilled() && !isRecentsEmpty) ...[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                  children: [
                    const Text('Recent Searches'),
                    const Spacer(),
                    if (!isRecentsEmpty) ...[
                      InkWell(
                        child: const Text('Clear Recents', style: TextStyle(color: Colors.blue)),
                        onTap: () {
                          ref.read(filteredUsersProvider.notifier).clearRecents();
                        },
                      ),
                    ]
                  ]
              ),
              const Divider(),
            ],
          ),
        ),
      ],
      SearchView(users: list)
    ];

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildFilterBar(),
          buildSearchBar(),
          ...showContent,
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
