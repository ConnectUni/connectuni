import 'package:connectuni/model/user_list.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/user_card_widget.dart';
import '../model/user.dart';
import '../utils/global_variables.dart';

class SearchPeopleScreen extends ConsumerStatefulWidget {
  const SearchPeopleScreen({Key? key, required this.pageController})
      : super(key: key);

  static const String routeName = '/search_people';
  final PageController pageController;

  @override
  ConsumerState<SearchPeopleScreen> createState() => _SearchPeopleScreenState();
}

class _SearchPeopleScreenState extends ConsumerState<SearchPeopleScreen> {
  final controller = TextEditingController();
  final _interests = interests
      .map((interest) => MultiSelectItem(interest, interest))
      .toList();

  List<String> selectedFilters = [];
  List<User> users = TempUsersDB.getUsers();
  List<User> showSearchedUser(String query) {
    final suggestions = TempUsersDB
        .getUsers()
        .where((user) {
          if(selectedFilters.isNotEmpty) {
            return user.displayName.toLowerCase().contains(query.toLowerCase()) && user.interests.any((interest) => selectedFilters.contains(interest));
          } else {
            return user.displayName.toLowerCase().contains(query.toLowerCase());
          }
    }).toList();
    setState(() {
      users = suggestions;
    });

    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
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
            child: MultiSelectDialogField(
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
              onConfirm: (results) {
                selectedFilters = List<String>.from(results);
                showSearchedUser(controller.text);
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (item) {
                  setState(() {
                    selectedFilters.remove(item);
                    showSearchedUser(controller.text);
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
                ),
              ),
              onChanged: showSearchedUser,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserCardWidget(user: users[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
