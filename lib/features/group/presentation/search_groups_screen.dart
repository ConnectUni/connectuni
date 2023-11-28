import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/group/domain/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../cu_error.dart';
import '../data/group_providers.dart';
import 'add_group.dart';
import 'group_info_widget.dart';

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

  List<String> selectedFilters = [];

  // ADD INTERESTS HERE
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
      loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<String> interests,
    required WidgetRef ref
  }) {
    final AsyncValue<List<Group>> asyncFilteredGroups = ref.watch(filteredGroupsProvider);

    final _interests = interests
        .map((interest) => MultiSelectItem<String>(interest, interest))
        .toList();

    bool isSearchbarFilled() {
      return controller.text.isNotEmpty;
    }

    /// This displays the appbar.
    AppBar buildAppBar() => AppBar(
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
          ref.read(filteredGroupsProvider.notifier).updateFilters(selectedFilters);
        },
        onSelectionChanged: (results) { // This updates the selected filters on selection change
          selectedFilters = List<String>.from(results);
          ref.read(filteredGroupsProvider.notifier).updateFilters(selectedFilters);
        } ,
        chipDisplay: MultiSelectChipDisplay( // This removes the selected filter on tap
          onTap: (item) { // This removes the selected filter on tap
            selectedFilters.remove(item);
            selectedFilters = List<String>.from(selectedFilters);
            ref.read(filteredGroupsProvider.notifier).updateFilters(selectedFilters);
            return selectedFilters;
          },
        ),
        isDismissible: false,
      ),
    );

    /// This displays the search bar.
    buildSearchBar() => Padding(
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
                  ref.read(filteredGroupsProvider.notifier).filterQuery('');
                }
            ) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.blue),
            )
        ),
        onChanged: (value) { // This updates the page based on the search query
          ref.read(filteredGroupsProvider.notifier).filterQuery(value);
        },
      ),
    );

    /// This displays the content of the page.
    Widget showContent(groups) => Expanded(
        child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return GroupInfoWidget(group: groups[index]);
          },
        )
    );

    Widget buildContent() => asyncFilteredGroups.when(
      data: (groups) => showContent(groups),
      error: (e, st) => CUError(e.toString(),  st.toString()),
      loading: () => const CULoading(),
    );

    /// This displays the add new group button.
    Widget buildAddNewGroupButton() => Padding( // TODO: Fix overflow
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
    );

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildFilterBar(),
          buildSearchBar(),
          buildContent(),
          buildAddNewGroupButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_group');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
