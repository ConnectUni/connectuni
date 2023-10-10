import 'package:flutter/material.dart';

import'package:connectuni/model/group.dart';

class GroupCardView extends StatelessWidget {
  const GroupCardView({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    Group thisGrouping = groupsDB.getGroupByName(name);
    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                  title: Text(thisGrouping.groupName,
                      style: Theme.of(context).textTheme.titleLarge)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${thisGrouping.semYear} | ${thisGrouping.professor}"),
                )
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${thisGrouping.userIds.length} people"),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${thisGrouping.newMessages} new messages"
                  )
                  )
              ),
              const SizedBox(height: 10)
            ],
          )),
    );
  }
}
