import 'package:connectuni/features/user/domain/user_list.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../group/data/group_providers.dart';
import '../data/user_providers.dart';
import 'user_card_widget.dart';
import '../domain/user.dart';
import '../../home/domain/global_variables.dart';
import '../../group/domain/group_list.dart';

class SearchPeopleScreen extends ConsumerStatefulWidget {
  const SearchPeopleScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_people';
  final PageController pageController;

  @override
  ConsumerState<SearchPeopleScreen> createState() => _SearchPeopleScreenState();
}

/*
 * These are the state providers that will be used to check the selected
 * interests and the search query.
 */
final selectedFiltersProvider = StateProvider<List<String>?>((ref) => []);
final searchQueryProvider = StateProvider<String?>((ref) => "");

/*
 * This provider will be used to find the users that are not friends with the
 * current user
 */
final notUsersFriendsProvider = Provider<List<User>?>((ref) {
  final usersDB = ref.watch(userDBProvider);
  final User currentUser = usersDB.getUserByID(ref.read(currentUserProvider));
  final notFriends = usersDB
      .getUsers()
      .where((user) => !currentUser.friends.contains(user))
      .toList();

  return notFriends;
});

/*
 * This provider will be used to filter the users based on the selected
 * interests and the search query from the providers above.
 */
final filterUsers = Provider<List<User>?>((ref) {
  final filters = ref.watch(selectedFiltersProvider);
  final users = ref.watch(notUsersFriendsProvider);
  final query = ref.watch(searchQueryProvider);
  final suggestions = users?.where((user) {
    if(filters!.isNotEmpty) {
      return user.displayName.toLowerCase().contains(query!.toLowerCase()) && user.interests.any((interest) => filters!.contains(interest));
    } else {
      return user.displayName.toLowerCase().contains(query!.toLowerCase());
    }
  }).toList();

  return suggestions;
});

class _SearchPeopleScreenState extends ConsumerState<SearchPeopleScreen> {
  final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    final List<User>? filteredUserList = ref.watch(filterUsers);

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
              ),
              onChanged: (value) { // This updates the page based on the search query
                ref.read(searchQueryProvider.notifier).update((state) => value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUserList?.length,
              itemBuilder: (context, index) {
                return UserCardWidget(user: filteredUserList![index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
