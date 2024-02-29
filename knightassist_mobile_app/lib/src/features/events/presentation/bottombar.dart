import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';

class BottomNavigationBarClass extends StatefulWidget {
  const BottomNavigationBarClass({super.key});

  @override
  State<BottomNavigationBarClass> createState() =>
      _BottomNavigationBarClassState();
}

class _BottomNavigationBarClassState extends State<BottomNavigationBarClass> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = isOrg
      ? <Widget>[
          const EventListScreen(),
          const UpdateScreenTab(),
          const HomeScreenTab(),
          const FeedbackListScreenTab(),
        ]
      : <Widget>[
          const EventListScreen(),
          const HomeScreenTab(),
          QRCodeScanner(),
        ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black, width: 2.0))),
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
                    icon: Icon(Icons.camera_alt_outlined), label: "QR Scan"),
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
  }
}
