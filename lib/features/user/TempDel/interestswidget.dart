import 'package:flutter/material.dart';
import 'package:connectuni/features/home/domain/global_variables.dart';
import '../domain/user.dart';

class InterestsSelector extends StatefulWidget {
  const InterestsSelector({super.key});

  @override
  State<InterestsSelector> createState() => _InterestsSelectorState();
}

class _InterestsSelectorState extends State<InterestsSelector> {
  List<String> selectedInterests = []; // This list represents currentUser.interests
  late User currentUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: interests.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                title: Text(interests[index]),
                value: selectedInterests.contains(interests[index]),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedInterests.add(interests[index]);
                    } else {
                      selectedInterests.remove(interests[index]);
                    }
                  });
                  currentUser.interests = selectedInterests;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}