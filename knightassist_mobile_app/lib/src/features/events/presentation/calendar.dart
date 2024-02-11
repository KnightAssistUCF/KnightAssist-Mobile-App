import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:table_calendar/table_calendar.dart';

List<Event> events = [];

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool tapped = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = isOrg
      ? <Widget>[
          const EventsListScreen(),
          const UpdateScreenTab(),
          const HomeScreenTab(),
          const FeedbackListScreenTab(),
        ]
      : <Widget>[
          const EventsListScreen(),
          const HomeScreenTab(),
          QRCodeScanner(),
        ];

  late AnimationController _controller;
  bool _pressed = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      tapped = true; // can't return to event history screen from navbar
      _selectedIndex = index;
    });
  }

  static const List<String> icons = ["Create Announcement", "Create Event"];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authRepository = ref.watch(authRepositoryProvider);
        final user = authRepository.currentUser;
        isOrg = user?.role == 'organization';
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);
        final eventsRepository = ref.watch(eventsRepositoryProvider);
        if (isOrg) {
          eventsRepository
              .fetchEventsByOrg(user!.id)
              .then((value) => setState(() {
                    events = value;
                  }));
        } else {
          eventsRepository
              .fetchEventsByStudent(user!.id)
              .then((value) => setState(() {
                    events = value;
                  }));
        }

        return Scaffold(
          floatingActionButton: isOrg
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(icons.length, (int index) {
                    Widget child = Container(
                      height: 100.0,
                      width: 300.0,
                      alignment: FractionalOffset.topCenter,
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: _controller,
                          curve: Interval(0.0, 1.0 - index / icons.length / 2.0,
                              curve: Curves.easeOut),
                        ),
                        child: ElevatedButton(
                          child: SizedBox(
                            height: 70,
                            width: 200,
                            child: Center(
                              child: Text(
                                icons[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          //),
                          onPressed: () {
                            if (index == 0) {
                              context
                                  .pushNamed(AppRoute.createAnnouncement.name);
                            } else {
                              context.pushNamed(AppRoute.createEvent.name);
                            }
                          },
                        ),
                      ),
                    );
                    return child;
                  }).toList()
                    ..add(
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _pressed = !_pressed;
                          });
                          if (_controller.isDismissed) {
                            _controller.forward();
                          } else {
                            _controller.reverse();
                          }
                        },
                        tooltip: 'Create an event or announcement',
                        shape: const CircleBorder(side: BorderSide(width: 1.0)),
                        elevation: 2.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment(0.8, 1),
                              colors: <Color>[
                                Color.fromARGB(255, 91, 78, 119),
                                Color.fromARGB(255, 211, 195, 232)
                              ],
                              tileMode: TileMode.mirror,
                            ),
                          ),
                          child: Icon(
                            _pressed == true
                                ? Icons.keyboard_arrow_up_sharp
                                : Icons.add,
                            color: Colors.white,
                            size: 54,
                          ),
                        ),
                      ),
                    ),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          /*appBar: AppBar(
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
      ),*/
          body: tapped
              ? _widgetOptions.elementAt(_selectedIndex)
              : Calendar(), //Calendar(),
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
                isOrg
                    ? ListTile(
                        title: const Text('Feedback'),
                        onTap: () {
                          context.pushNamed(AppRoute.feedbacklist.name);
                        },
                      )
                    : ListTile(
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
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.black, width: 2.0))),
            child: BottomNavigationBar(
              items: [
                isOrg
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.edit_calendar_sharp), label: "Events")
                    : BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "Explore"),
                isOrg
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.campaign), label: "Announcements")
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: "Home"),
                isOrg
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: "Home")
                    : BottomNavigationBarItem(
                        icon: Icon(Icons.camera_alt_outlined),
                        label: "QR Scan"),
                if (isOrg)
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.reviews), label: "Feedback"),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color.fromARGB(255, 29, 16, 57),
              unselectedItemColor: Colors.black,
              selectedFontSize: 16.0,
              unselectedFontSize: 14.0,
              onTap: _onItemTapped,
            ),
          ),
        );
      },
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

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
      if (isSameDay(e.startTime, day)) {
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
      appBar: AppBar(
        title: const Text(
          'Calendar View',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
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
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.fromMillisecondsSinceEpoch(1641031200000),
            lastDay: DateTime.fromMillisecondsSinceEpoch(1767063659000),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(fontWeight: FontWeight.w200),
                weekendTextStyle: TextStyle(
                    color: Color(0xFF5A5A5A), fontWeight: FontWeight.w200),
                outsideTextStyle: TextStyle(
                    color: Color(0xFFAEAEAE), fontWeight: FontWeight.w200),
                todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 160, 151, 181),
                    shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 91, 78, 119),
                    shape: BoxShape.circle)),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
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
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return value.length == 0
                    ? Center(
                        child:
                            Text("You have no events scheduled on this day."),
                      )
                    : ListView.builder(
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
                              onTap: () {
                                print(
                                    'event name: ${value[index].name}, event ID: ${value[index].id}');
                                context.pushNamed("event",
                                    extra: value.elementAt(index));
                              },
                              title: Text(
                                value[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              subtitle: Text(
                                value[index].sponsoringOrganization,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              trailing: Text(
                                  "${DateFormat.jmv().format(value[index].startTime)} - ${DateFormat.jmv().format(value[index].endTime)}"),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image(
                                      image: AssetImage(
                                          value[index].profilePicPath),
                                      height: 50,
                                      width: 50)),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
