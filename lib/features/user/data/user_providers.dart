import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/firestore/firestore_providers.dart';
import '../domain/user.dart';
import 'user_database.dart';

part 'user_providers.g.dart';

@riverpod
UserDatabase userDatabase(UserDatabaseRef ref) {
  return UserDatabase(ref);
}

@riverpod
Stream<List<User>> users(UsersRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return database.watchUsers();
}

@riverpod
String currentUserID(CurrentUserIDRef ref) {
  final FirebaseAuth instance = ref.watch(firebaseAuthProvider);
  return instance.currentUser!.email!;
}

@riverpod
Future<User> currentUser(CurrentUserRef ref) async {
  final String currentUserId = ref.watch(currentUserIDProvider);
  final database = ref.watch(userDatabaseProvider);
  return await database.fetchUser(currentUserId);
}

@riverpod
class FilteredUsers extends _$FilteredUsers {
  bool mounted = true;
  List<User> users = [];
  List<User> recents = [];
  List<User> results = [];
  List<String> filters = [];
  String query = '';

  @override
  FutureOr<List<User>> build() async {
    ref.onDispose(() => mounted = false);
    users = await ref.watch(usersProvider.future);
    return users;
  }

  void filterQuery(String input) {
    state = const AsyncLoading();
    query = input;
    if (query.isEmpty && filters.isEmpty) {
      results = recents;
    } else {
      results = users.where((user) => user.displayName
          .toLowerCase()
          .contains(query.toLowerCase()) && user.interests
          .any((interests) => filters.contains(interests)))
          .toList();
    }
    if (mounted) {
      state = AsyncData(results);
    }
  }

  void updateFilters(List<String> filters) {
    state = const AsyncLoading();
    this.filters = filters;
    if (query.isEmpty && filters.isEmpty) {
      results = recents;
    } else {
      results = users.where((user) => user.displayName
          .toLowerCase()
          .contains(query.toLowerCase()) && user.interests
          .any((interests) => filters.contains(interests)))
          .toList();
    }
    if (mounted) {
      state = AsyncData(results);
    }
  }

  void addRecent(User user) {
    state = const AsyncLoading();
    if (recents.contains(user)) {
      recents.insert(0, user);
    } else {
      recents.add(user);
    }
    if (recents.length > 5) {
      recents.removeLast();
    }
    if (mounted) {
      state = AsyncData(recents);
    }
  }

  void removeRecent(User user) {
    state = const AsyncLoading();
    recents.remove(user);
    if (mounted) {
      state = AsyncData(recents);
    }
  }

  void clearRecents() {
    state = const AsyncLoading();
    recents.clear();
    if (mounted) {
      state = AsyncData(recents);
    }
  }
}
