import 'package:connectuni/features/all_data_provider.dart';
import 'package:connectuni/features/cu_error.dart';
import 'package:connectuni/features/cu_loading.dart';
import 'package:connectuni/features/event/domain/event_collection.dart';
import 'package:connectuni/features/group/domain/group_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../group/domain/group.dart';
import '../domain/event.dart';
import '../domain/event_list.dart';
import '../data/event_providers.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../group/data/group_providers.dart';
import 'event_info_screen.dart';

class EventCalendar extends ConsumerStatefulWidget {
  const EventCalendar({super.key});

  @override
  ConsumerState createState() => _EventCalendarState();
}

class _EventCalendarState extends ConsumerState<EventCalendar> {
  late final ValueNotifier<List<SingleEvent>> _selectedEvents;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    final AsyncValue<List<SingleEvent>> asyncValue = ref.watch(eventsProvider);
    asyncValue.when(
      data: (events) => _initEvents(events: events),
      error: (e, st) => CUError(e.toString(), st.toString()),
      loading: () => const CULoading());
  }

  void _initEvents({required List<SingleEvent> events}) {
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
        events.where((event) => isSameDay(event.eventDate, _selectedDay!)).toList()
    );
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
            ),
        error: (e, st) => CUError(e.toString(), st.toString()),
        loading: () => const CULoading());
  }

  Widget _build({
    required BuildContext context,
    required List<SingleEvent> events,
    required List<Group> groups,
  }) {
    EventCollection eventCollection = EventCollection(events);
    final items = groups.map((group) => MultiSelectItem(group.groupID, group.groupName)).toList();

    List<SingleEvent> getEventsForDay(DateTime day) {
      return eventCollection
          .getAllEvents()
          .where((event) => isSameDay(event.eventDate, day))
          .toList();
    }

    void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      if (!isSameDay(_selectedDay, selectedDay)) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          _rangeStart = null; // Important to clean those
          _rangeEnd = null;
          _rangeSelectionMode = RangeSelectionMode.toggledOff;
        });

        _selectedEvents.value = getEventsForDay(selectedDay);
      }
    }

    void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
      setState(() {
        _selectedDay = null;
        _focusedDay = focusedDay;
        _rangeStart = start;
        _rangeEnd = end;
        _rangeSelectionMode = RangeSelectionMode.toggledOn;
      });
    }

    Widget buildFilterBar() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiSelectDialogField(
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
          // TODO: Filter groups by results
        },
      ),
    );

    Widget buildCalenderView() => TableCalendar<SingleEvent>(
      firstDay: DateTime.utc(2023, 10, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      eventLoader: getEventsForDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: const CalendarStyle(
        // Use `CalendarStyle` to customize the UI
        outsideDaysVisible: false,
      ),
      onDaySelected: onDaySelected,
      onRangeSelected: onRangeSelected,
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

    List<Widget> selectedEventDetails = [
      const SizedBox(height: 8.0),
      Text(
        "Events for ${_selectedDay?.month}/${_selectedDay?.day}/${_selectedDay?.year}:",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      Expanded(
        child: ValueListenableBuilder<List<SingleEvent>>(
          valueListenable: _selectedEvents,
          builder: (context, value, _) {
            return ListView.builder(
              itemCount: value.length,
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
                                  event: value[index]))
                      )
                    },
                    title: Text(
                        '${value[index].eventName} | ${value[index].eventLocation}'),
                  ),
                );
              },
            );
          },
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Calendar'),
      ),
      body: Column(
        children: [
          buildFilterBar(),
          buildCalenderView(),
          ...selectedEventDetails,
        ],
      ),
    );
  }
}
