import 'package:connectuni/features/event/presentation/edit_event_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import '../../all_data_provider.dart';
import '../../cu_error.dart';
import '../../cu_loading.dart';
import '../../user/domain/user.dart';
import '../../user/presentation/edit_user_controller.dart';
import '../domain/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_event.dart';

class EventInfoScreen extends ConsumerStatefulWidget {
  const EventInfoScreen({Key? key, required this.event}) : super(key: key);

  final SingleEvent? event;
  static const String routeName = '/event_info';

  @override
  ConsumerState<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends ConsumerState<EventInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) => _build(
          context: context,
          users: allData.users,
          event: widget.event!,
          currentUser: allData.currentUser,
          ref: ref,
        ),
        error: (e,st) => CUError(e.toString(), st.toString()),
        loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<User> users,
    required SingleEvent event,
    required User currentUser,
    required WidgetRef ref
  }) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                title: Text(event.eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.asset(
                  event.eventIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  event.eventDescription,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Location: ${event.eventLocation}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Date: ${event.eventDate}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Members going: ${event.userIDs.length}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            if(!event.userIDs.contains(currentUser.uid) && currentUser.groupIDs.contains(event.groupID))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                        'Join Event',
                        style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    event.userIDs.add(currentUser.uid);
                    currentUser.eventIDs.add(event.eventID);
                    ref.read(editEventControllerProvider.notifier).updateEvent(event: event, onSuccess: () {});
                    ref.read(editUserControllerProvider.notifier).updateUser(user: currentUser, onSuccess: () {});
                  },
                ),
              ],
            ),
            if(event.userIDs.contains(currentUser.uid) && currentUser.groupIDs.contains(event.groupID))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: FlexColor.redLightPrimary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                        'Leave Event',
                        style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    event.userIDs.remove(currentUser.uid);
                    currentUser.eventIDs.remove(event.eventID);
                    ref.read(editEventControllerProvider.notifier).updateEvent(event: event, onSuccess: () {});
                    ref.read(editUserControllerProvider.notifier).updateUser(user: currentUser, onSuccess: () {});
                  },
                ),
              ],
            ),
            if(event.userIDs.contains(currentUser.uid) && currentUser.groupIDs.contains(event.groupID))
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonTheme.colorScheme?.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Edit Event',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return EditEvent(id: event.eventID);
                        }));
                        },
                    ),
                  ]
              ),
            if(!currentUser.groupIDs.contains(event.groupID))
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'You must join the group to join the event.',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonTheme.colorScheme?.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Go to Group Page',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
          ],
        ),
      ),
    );
  }
}
