import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user_list.dart';

final userDBProvider = Provider<UserList>((ref) { return UserList(mockUsers); });
final currentUserProvider = StateProvider<String>((ref) => 'user-001');
