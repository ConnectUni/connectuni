import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/message.dart';

/// Provides access to the Firestore database storing [Message] documents.
class MessageDatabase {
  MessageDatabase(this.ref);

  final ProviderRef<MessageDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Message>> watchMessages() => _service.watchCollection(
      path: FirestorePath.messages(),
      builder: (data, documentId) => Message.fromJson(data!));

  Stream<Message> watchMessage(String messageId) => _service.watchDocument(
      path: FirestorePath.message(messageId),
      builder: (data, documentId) => Message.fromJson(data!));

  Future<List<Message>> fetchMessages() => _service.fetchCollection(
      path: FirestorePath.messages(),
      builder: (data, documentId) => Message.fromJson(data!));

  Future<Message> fetchMessage(String messageId) => _service.fetchDocument(
      path: FirestorePath.message(messageId),
      builder: (data, documentId) => Message.fromJson(data!));

  Future<void> setMessage(Message message) => _service.setData(
      path: FirestorePath.message(message.messageId), data: message.toJson());

  Future<void> setMessageDelayed(Message message) => Future.delayed(
      const Duration(milliseconds: 2000),
      () => _service.setData(
          path: FirestorePath.message(message.messageId), data: message.toJson()));

  Future<void> setMessageError(Message message) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());
}
