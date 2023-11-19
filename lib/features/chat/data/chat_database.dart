import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/chat.dart';

/// Provides access to the Firestore database storing [Chat] documents.
class ChatDatabase {
  ChatDatabase(this.ref);

  final ProviderRef<ChatDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Chat>> watchChats() => _service.watchCollection(
      path: FirestorePath.chats(),
      builder: (data, documentId) => Chat.fromJson(data!));

  Stream<Chat> watchChat(String chatId) => _service.watchDocument(
      path: FirestorePath.chat(chatId),
      builder: (data, documentId) => Chat.fromJson(data!));

  Future<List<Chat>> fetchChats() => _service.fetchCollection(
      path: FirestorePath.chats(),
      builder: (data, documentId) => Chat.fromJson(data!));

  Future<Chat> fetchChat(String chatId) => _service.fetchDocument(
      path: FirestorePath.chat(chatId),
      builder: (data, documentId) => Chat.fromJson(data!));

  Future<void> setChat(Chat chat) => _service.setData(
      path: FirestorePath.chat(chat.chatID), data: chat.toJson());

  Future<void> setChatDelayed(Chat chat) => Future.delayed(
      const Duration(milliseconds: 2000),
      () => _service.setData(
          path: FirestorePath.chat(chat.chatID), data: chat.toJson()));

  Future<void> setChatError(Chat chat) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());

  Future<void> deleteChat(Chat chat) =>
      _service.deleteData(path: FirestorePath.chat(chat.chatID));
}
