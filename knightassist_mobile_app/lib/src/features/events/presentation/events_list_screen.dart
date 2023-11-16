import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      //appBar: AppBar(
      //title: const Text('Volunteer Shifts'),
      //),
      body: Container(
        height: h,
        child: Column(
          children: [
            _topSection(),
            /*Stack(
              children: [
                _topSection(),
                const Column(
                  children: [
                    SafeArea(
                      child: Text(
                        'Volunteer Shift Events',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SearchBar(
                        hintText: 'Search Events',
                      ),
                    ),
                  ],
                ),
              ],
            ),*/
            Flexible(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: const <Widget>[
                  EventCard(),
                  EventCard(),
                  EventCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

_topSection() {
  return Container(
      //height: 200,
      color: const Color.fromARGB(255, 0, 108, 81),
      child: const Stack(
        children: [
          Column(
            children: [
              SafeArea(
                          child: Text(
                            'Volunteer Shift Events',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SearchBar(
                        hintText: 'Search Events',
                      ),
                    ),],
            
          ),
        ],
      ));
}

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    OverflowBar(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: const Image(
                                image: AssetImage('assets/example.png'),
                                height: 100)),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Event Title',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                                textAlign: TextAlign.justify,
                              ),
                              Text(
                                'Time/Date',
                                style: TextStyle(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              Text(
                                'Location',
                                style: TextStyle(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              OverflowBar(
                                children: [
                                  ClipRRect(
                                      child: Image(
                                          image:
                                              AssetImage('assets/example.png'),
                                          height: 20)),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Hosting Organization',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        OverflowBar(
                          spacing: 8,
                          overflowAlignment: OverflowBarAlignment.end,
                          children: [
                            Align(
                              alignment: const Alignment(1, 0.6),
                              child: FilledButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 91, 78, 119))),
                                child: const Text('RSVP'),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
