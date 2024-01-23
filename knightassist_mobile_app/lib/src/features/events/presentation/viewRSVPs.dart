import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

class viewRSVPsScreen extends StatefulWidget {
  final Event event;
  const viewRSVPsScreen({super.key, required this.event});

  @override
  State<viewRSVPsScreen> createState() => _viewRSVPsScreenState();
}

class _viewRSVPsScreenState extends State<viewRSVPsScreen> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late final Event event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event RSVPs',
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
      body: Container(
          height: h,
          child: Column(children: [
            _topSection(w),
            Flexible(
              child: event.registeredVolunteers.isEmpty
                  ? const Center(
                      child: Text(
                        "There are no volunteers who RSVPed for this event.",
                        style: optionStyle,
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: event.registeredVolunteers.length,
                      itemBuilder: (context, index) => VolunteerCard(
                        event: event,
                        volunteer: event.registeredVolunteers.elementAt(index),
                      ),
                    ),
            ),
          ])),
    );
  }
}

_topSection(double width) {
  return Container(
      //height: 200,
      width: width,
      color: const Color.fromARGB(255, 0, 108, 81),
      child: const Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: SearchBar(
                    hintText: 'Search Event RSVPs',
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class VolunteerCard extends StatelessWidget {
  final Event event;
  final String volunteer;

  const VolunteerCard(
      {super.key, required this.event, required this.volunteer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    final difference = event.endTime.difference(event.startTime).inHours;

    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black26,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              elevation: 5,
              child: InkWell(
                onTap: () => context.pushNamed("historydetail",
                    extra:
                        event), // TODO : determine if orgs can edit student hours
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                            image: AssetImage(event.picLink), height: 75)),
                    title: Text(
                      volunteer,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${difference.toString()} hours",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    trailing: Text(
                      "RSVPed: ${DateFormat('yyyy-MM-dd').format(event.date)}",
                      style: const TextStyle(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
