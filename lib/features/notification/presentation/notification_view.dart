import 'package:connectuni/features/notification/domain/notification_collection.dart';
import 'package:connectuni/features/notification/presentation/notification_widget.dart';
import 'package:connectuni/features/user/domain/user.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectuni/features/notification/domain/notification.dart';

import '../../all_data_provider.dart';
import '../../cu_error.dart';
import '../../cu_loading.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) =>
            _build(
              context: context,
              notifications: allData.notifications,
              currentUser: allData.currentUser,
              ref: ref,
            ),
        error: (e, st) => CUError(e.toString(), st.toString()),
        loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<Notification> notifications,
    required User currentUser,
    required WidgetRef ref,
  }) {
    NotificationCollection notifsCollection = NotificationCollection(notifications);
    List<Notification> notifs = notifsCollection.getNotifications(currentUser);

    Widget noNotifications() {
      return const Center(
        child: Text('No notifications'),
      );
    }

    Widget buildNotificationList() {
      return ListView.builder(
        itemCount: notifs.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifs[index];
          return NotificationWidget(notification: notification);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notifs.isEmpty ? noNotifications() : buildNotificationList(),
    );
  }
}
