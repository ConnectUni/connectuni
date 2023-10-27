import 'package:connectuni/model/group.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:connectuni/utils/global_variables.dart';
import '../components/group_chat_widget.dart';
import '../model/group_list.dart';

class SearchGroupsScreen extends StatefulWidget {
  const SearchGroupsScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_groups';
  final PageController pageController;

  @override
  State<SearchGroupsScreen> createState() => _SearchGroupsScreenState();
}

class _SearchGroupsScreenState extends State<SearchGroupsScreen> {
  final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  List<String> selectedFilters = [];
  List<Group> groups = TempGroupsDB.getAllGroups();
  List<Group> showSearchedGroup(String query) {
    final suggestions = TempGroupsDB
        .getAllGroups()
        .where((group) {
          if(selectedFilters.isNotEmpty) {
            return group.groupName.toLowerCase().contains(query.toLowerCase()) && group.interests.any((interest) => selectedFilters.contains(interest));
          } else {
            return group.groupName.toLowerCase().contains(query.toLowerCase());
          }
    }).toList();
    setState(() {
      groups = suggestions;
    });

    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
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
                showSearchedGroup(controller.text);
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (item) {
                  setState(() {
                    selectedFilters.remove(item);
                    showSearchedGroup(controller.text);
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
              onChanged: showSearchedGroup,
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return GroupChatWidget(id: groups[index].groupID);
                },
              )
          ),
        ],
      ),
    );
  }
}
