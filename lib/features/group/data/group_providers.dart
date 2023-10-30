import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/group_list.dart';

//Provider that gives access to the total groups database.
final groupsDBProvider = StateProvider<GroupList>((ref) { return GroupList(allGroups); });

final groupsIDProvider = StateProvider<int>((ref) { return GroupList(allGroups).groupLength(); });
