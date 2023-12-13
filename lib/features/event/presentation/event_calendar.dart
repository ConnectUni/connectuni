import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/event/domain/event_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../group/domain/group.dart';
import '../data/event_providers.dart';
import '../domain/event.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'create_event.dart';
import 'event_info_screen.dart';

class EventCalendar extends ConsumerStatefulWidget {
  static const routeName = '/events_calendar';
  const EventCalendar({super.key});

  @override
  ConsumerState createState() => _EventCalendarState();
}

class _EventCalendarState extends ConsumerState<EventCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String> filters = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AllData> asyncValue = ref.watch(allDataProvider);
    return asyncValue.when(
        data: (allData) =>
            _build(
              context: context,
              events: allData.events,
              groups: allData.groups,
              ref: ref,
            ),
        error: (e, st) => CUError(e.toString(), st.toString()),
        loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<SingleEvent> events,
    required List<Group> groups,
    required WidgetRef ref,
  }) {
    final AsyncValue<List<SingleEvent>> asyncSelectedEvents = ref.watch(selectedEventsProvider);
    final AsyncValue<List<SingleEvent>> asyncFilteredSelectedEvents = ref.watch(filteredSelectedEventsProvider);
    final items = groups.map((group) => MultiSelectItem(group.groupID, group.groupName)).toList();

    void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      if(!isSameDay(_selectedDay, selectedDay)) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      }
      ref.read(selectedEventsProvider.notifier).onDaySelected(selectedDay, focusedDay);
    }

    Widget buildFilterBar() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiSelectBottomSheetField(
        items: items,
        title: const Text("Viewing events for group:"),
        selectedColor: Colors.blue,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        buttonIcon: const Icon(
          Icons.filter,
          color: Colors.blue,
        ),
        buttonText: Text(
          "Filter events by:",
          style: TextStyle(
            color: Colors.blue[800],
            fontSize: 16,
          ),
        ),
        onConfirm: (results) {
          filters = List<String>.from(results);
          ref.read(filteredSelectedEventsProvider.notifier).updateFilters(filters);
        },
        onSelectionChanged: (results) {
          filters = List<String>.from(results);
          ref.read(filteredSelectedEventsProvider.notifier).updateFilters(filters);
        },
        chipDisplay: MultiSelectChipDisplay(
          onTap: (item) {
            filters.remove(item);
            filters = List<String>.from(filters);
            ref.read(filteredSelectedEventsProvider.notifier).updateFilters(filters);
            return filters;
          },
        ),
        isDismissible: false,
      ),
    );

    Widget calenderView(List<SingleEvent> filteredEvents) => TableCalendar<SingleEvent>(
      firstDay: DateTime.utc(2023, 10, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      calendarFormat: _calendarFormat,
      eventLoader: (day) {
        return filteredEvents.where((event) => isSameDay(DateTime.tryParse(event.eventDate), day)).toList();
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: const CalendarStyle(
        // Use `CalendarStyle` to customize the UI
        outsideDaysVisible: false,
      ),
      onDaySelected: onDaySelected,
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );

    List<Widget> selectedEventDetails(List<SingleEvent> selectedEvents) {
      return [
        const SizedBox(height: 8.0),
        Text(
          "Events for ${_selectedDay?.month}/${_selectedDay?.day}/${_selectedDay?.year}:",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        selectedEvents.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Text(
                        "There are no events for this day.",
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return CreateEvent();
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(FlexColor.deepBlueLightSecondary),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('Add an Event'),
                      )
                    ]
                )
            )
        : Expanded(
          child: ListView.builder(
            itemCount: selectedEvents.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  //TODO: Implement onTap to send user to event page
                  onTap: () => {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => EventInfoScreen(
                                event: selectedEvents[index]))
                    )
                  },
                  title: Text(
                      '${selectedEvents[index].eventName} | ${selectedEvents[index].eventLocation}'),
                ),
              );
            },
          ),
        ),
      ];
    }

    List<Widget> buildEventDetails() => asyncSelectedEvents.when(
      data: (selectedEvents) => selectedEventDetails(selectedEvents),
      error: (e, st) => [CUError(e.toString(), st.toString())],
      loading: () => [const CULoading()]);

    List<Widget> buildCalendarView() => asyncFilteredSelectedEvents.when(
        data: (filteredEvents) {
          return [
            calenderView(filteredEvents),
            ...buildEventDetails(),
          ];
        },
        error: (e, st) => [CUError(e.toString(), st.toString())],
        loading: () => [const CULoading()]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Calendar'),
      ),
      body: Column(
        children: [
          buildFilterBar(),
          ...buildCalendarView(),
        ],
      ),
    );
  }
}
