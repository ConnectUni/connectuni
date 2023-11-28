import 'package:flutter/material.dart';
import 'package:connectuni/features/group/domain/group.dart';

class GroupCardView extends StatelessWidget {
  const GroupCardView({Key? key, required this.group}) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                  title: Text(group.groupName,
                      style: Theme.of(context).textTheme.titleLarge)),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text("${group.semYear} | ${group.professor}"),
                  )),
              if(group.userIDs.length > 1 || group.userIDs.isEmpty)
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${group.userIDs.length} members"),

                  )),
              if(group.userIDs.length == 1)
                Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,

                      child:
                      Text("${group.userIDs.length} member"),
                    )),
              if (group.newMessages.length > 1 || group.newMessages.isEmpty)
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${group.newMessages.length} new messages"))),
              if (group.newMessages.length == 1)
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${group.newMessages.length} new messages"))),
              const SizedBox(height: 10)
            ],
          )),
    );
  }
}
