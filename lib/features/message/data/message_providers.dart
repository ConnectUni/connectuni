import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/message.dart';
import 'message_database.dart';

part 'message_providers.g.dart';

@riverpod
MessageDatabase messageDatabase(MessageDatabaseRef ref) {
  return MessageDatabase(ref);
}

@riverpod
Stream<List<Message>> messages(MessagesRef ref) {
  final database = ref.watch(messageDatabaseProvider);
  return database.watchMessages();
}
