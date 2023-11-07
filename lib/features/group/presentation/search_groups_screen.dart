import 'package:connectuni/features/group/domain/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:connectuni/features/home/domain/global_variables.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../data/group_providers.dart';
import 'group_info_widget.dart';
import '../domain/group_list.dart';
import 'add_group.dart';

class SearchGroupsScreen extends ConsumerStatefulWidget {
  const SearchGroupsScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_groups';
  final PageController pageController;

  @override
  ConsumerState<SearchGroupsScreen> createState() => _SearchGroupsScreenState();
}

/*
 * These are the state providers that will be used to check the selected
 * interests and the search query.
 */
final selectedFiltersProvider = StateProvider<List<String>?>((ref) => []);
final searchQueryProvider = StateProvider<String?>((ref) => "");

/*
 * This provider will be used to find the groups that the current user is not
 * a part of.
 */
final notUsersGroupsProvider = Provider<List<Group>?>((ref) {
  final groupsDB = ref.watch(groupsDBProvider);
  final usersDB = ref.watch(userDBProvider);
  final User currentUser = usersDB.getUserByID(ref.read(currentUserProvider));
  final notGroups = groupsDB
      .getAllGroups()
      .where((group) => !currentUser.groupIDs.contains(group.groupID))
      .toList();

  return notGroups;
});

/*
 * This provider will be used to filter the groups based on the selected
 * interests and the search query from the providers above.
 */
final filteredGroups = Provider<List<Group>?>((ref) {
  final filters = ref.watch(selectedFiltersProvider);
  final groups = ref.watch(groupsDBProvider).getAllGroups();
  final query = ref.watch(searchQueryProvider);
  final suggestions = groups.where((group) {
    if(filters!.isNotEmpty) {
      return group.groupName.toLowerCase().contains(query!.toLowerCase()) && group.interests.any((interest) => filters.contains(interest));
    } else {
      return group.groupName.toLowerCase().contains(query!.toLowerCase());
    }
  }).toList();

  return suggestions;
});

class _SearchGroupsScreenState extends ConsumerState<SearchGroupsScreen> {
  final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    final List<Group>? filteredGroupList = ref.watch(filteredGroups);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for Groups'),
        actions: <Widget>[
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
              } ,
              chipDisplay: MultiSelectChipDisplay( // This removes the selected filter on tap
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
                )
              ),
              onChanged: (value) { // This updates the page based on the search query
                ref.read(searchQueryProvider.notifier).update((state) => value);
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: filteredGroupList?.length,
                itemBuilder: (context, index) {
                  return GroupInfoWidget(id: filteredGroupList![index].groupID);
                },
              )
          ),
          Padding( // TODO: Fix overflow
            padding: EdgeInsets.all(8.0),
            child:
                Column(
                  children: [
                    const Text(
                      "Can't find what you're looking for? Create a new group!"
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                        title: const Center(
                            child: Text("Add a Group.",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        textColor: Colors.white,
                        tileColor: Colors.black54,
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return AddGroup();
                          }));
                        }
                      ),
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
