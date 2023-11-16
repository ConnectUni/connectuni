import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/event.dart';

/// Provides access to the Firestore database storing [Event] documents.
class EventDatabase {
  EventDatabase(this.ref);

  final ProviderRef<EventDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<SingleEvent>> watchEvents() => _service.watchCollection(
      path: FirestorePath.events(),
      builder: (data, documentId) => SingleEvent.fromJson(data!));

  Stream<SingleEvent> watchEvent(String eventId) => _service.watchDocument(
      path: FirestorePath.event(eventId),
      builder: (data, documentId) => SingleEvent.fromJson(data!));

  Future<List<SingleEvent>> fetchEvents() => _service.fetchCollection(
      path: FirestorePath.events(),
      builder: (data, documentId) => SingleEvent.fromJson(data!));

  Future<SingleEvent> fetchEvent(String eventId) => _service.fetchDocument(
      path: FirestorePath.event(eventId),
      builder: (data, documentId) => SingleEvent.fromJson(data!));

  Future<void> setEvent(SingleEvent event) => _service.setData(
      path: FirestorePath.event(event.eventID), data: event.toJson());

  Future<void> setEventDelayed(SingleEvent event) => Future.delayed(
      const Duration(milliseconds: 2000),
      () => _service.setData(
          path: FirestorePath.event(event.eventID), data: event.toJson()));

  Future<void> setEventError(SingleEvent event) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());

  Future<void> deleteEvent(SingleEvent event) =>
      _service.deleteData(path: FirestorePath.event(event.eventID));
}
