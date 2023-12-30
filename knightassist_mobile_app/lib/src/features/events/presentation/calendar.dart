import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:table_calendar/table_calendar.dart';

List<Event> events = [
  Event(
      id: '1',
      name: 'concert',
      description: 'really cool music, need someone to serve food',
      location: 'addition financial arena',
      date: DateTime.fromMillisecondsSinceEpoch(1699875173000),
      sponsoringOrganization: 'Organization X is really long !!!!! !!!!! !!!!! !!!!!',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/profile pictures/icon_leaf.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1699875173000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1699875173099),
      eventTags: ['music', 'food'],
      semester: 'Fall 2023',
      maxAttendees: 1000,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1700968029),
      updatedAt: DateTime.now()),
  Event(
      id: '2',
      name: 'study session',
      description: 'cs1, need someone to bring water',
      location: 'ucf library',
      date: DateTime.fromMillisecondsSinceEpoch(1698433137000),
      sponsoringOrganization: 'Organization Y',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/example.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1698433137000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1698433137099),
      eventTags: ['education', 'technology'],
      semester: 'Fall 2023',
      maxAttendees: 30,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1700968029),
      updatedAt: DateTime.now()),
  Event(
      id: '3',
      name: 'movie night',
      description: 'need someone to collect tickets',
      location: 'pegasus ballroom',
      date: DateTime.fromMillisecondsSinceEpoch(1695774773000),
      sponsoringOrganization: 'Organization Z',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/profile pictures/icon_planet.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1695774773000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1695774773099),
      eventTags: ['movie', 'education', 'food'],
      semester: 'Fall 2023',
      maxAttendees: 400,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1700968029),
      updatedAt: DateTime.now()),
    Event(
      id: '5',
      name: 'movie night with long desc and title hahahaha hahaha wegJKHgekljbdgKLJBgdkbg;JKBglkjbasdg',
      description: 'Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum ',
      location: 'pegasus ballroom',
      date: DateTime.fromMillisecondsSinceEpoch(1734218796000),
      sponsoringOrganization: 'Organization Z',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/profile pictures/icon_cookie.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1734218796000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1734219036000),
      eventTags: ['movie', 'education', 'food'],
      semester: 'Fall 2023',
      maxAttendees: 400,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1702596396),
      updatedAt: DateTime.now()),
];

class CalendarView extends ConsumerWidget {
  const CalendarView({super.key});

   @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar View', style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              tooltip: 'View notifications',
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                semanticLabel: 'Notifications',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.profileScreen.name);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: const Image(
                      semanticLabel: 'Profile picture',
                      image: AssetImage(
                          'assets/profile pictures/icon_paintbrush.png'),
                      height: 20),
                ),
              ),
            ),
          )
        ],
      ),
      body: Calendar(),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                context.pushNamed(AppRoute.homeScreen.name);
              },
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                context.pushNamed(AppRoute.calendar.name);
              },
            ),
            ListTile(
              title: const Text('Organizations'),
              onTap: () {
                context.pushNamed(AppRoute.organizations.name);
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                context.pushNamed(AppRoute.events.name);
              },
            ),
            ListTile(
              title: const Text('Announcements'),
              onTap: () {
                context.pushNamed(AppRoute.updates.name);
              },
            ),
             ListTile(
              title: const Text('QR Scan'),
              onTap: () {
                context.pushNamed(AppRoute.qrScanner.name);
              },
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                context.pushNamed(AppRoute.eventHistory.name);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                context.pushNamed(AppRoute.account.name);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                context.pushNamed(AppRoute.emailConfirm.name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  } 
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
CalendarFormat _calendarFormat = CalendarFormat.month;
DateTime _focusedDay = DateTime.now();
DateTime? _selectedDay;
RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
DateTime? _rangeStart;
DateTime? _rangeEnd;


late final ValueNotifier<List<Event>> _selectedEvents;

@override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> eventsForDay = [];
    for (Event e in events) {
      if (e.date.isBefore(day)) {
        eventsForDay.add(e);
      }
    }
    return eventsForDay;
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<Event>(focusedDay: _focusedDay, firstDay: DateTime.fromMillisecondsSinceEpoch(1641031200000), lastDay: DateTime.fromMillisecondsSinceEpoch(1767063659000), // currently set to 1 yr before and after 12/29/23
          calendarFormat: _calendarFormat,
          rangeSelectionMode: _rangeSelectionMode,
           eventLoader: _getEventsForDay,
           selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },),
            Expanded(
            child: ValueListenableBuilder<List<Event>>(
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
                        onTap: () {print('event name: ${value[index].name}, event ID: ${value[index].id}');
                        context.pushNamed("event", extra: value[index]); },
                        title: Text('${value[index].name}'),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

}
