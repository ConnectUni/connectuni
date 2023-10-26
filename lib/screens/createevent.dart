import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/group/data/group_providers.dart';
import '../features/group/domain/group_list.dart';

class CreateEvent extends ConsumerWidget {
  const CreateEvent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GroupList tempgroupsdb = ref.watch(groupsDBProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Event'),
        ),
        body: ListView());
  }
}
