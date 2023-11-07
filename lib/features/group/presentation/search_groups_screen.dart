import 'package:connectuni/features/group/domain/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:connectuni/features/home/domain/global_variables.dart';
import '../data/group_providers.dart';
import 'group_info_widget.dart';
import 'add_group.dart';

class SearchGroupsScreen extends ConsumerStatefulWidget {
  const SearchGroupsScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_groups';
  final PageController pageController;

  @override
  ConsumerState<SearchGroupsScreen> createState() => _SearchGroupsScreenState();
}

class _SearchGroupsScreenState extends ConsumerState<SearchGroupsScreen> {
  final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    final List<Group>? filteredGroupList = ref.watch(filteredGroups);
    final bool isSearchbarFilled = ref.watch(isSearchFilledProvider);

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
                suffixIcon: isSearchbarFilled ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    ref.read(searchQueryProvider.notifier).update((state) => "");
                  }
                ) : null,
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
            padding: const EdgeInsets.all(8.0),
            child:
                Column(
                  children: [
                    const Text(
                      "Can't find what you're looking for? Create a new group!"
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
