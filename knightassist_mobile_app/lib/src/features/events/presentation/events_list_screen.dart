import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            Stack(
              children: [
                _topSection(),
              ],
            ),
            const EventCard(),
            const EventCard(),
          ],
        ),
      ),
    );
  }
}

_topSection() {
  return Container(
      height: 150,
      color: const Color.fromARGB(255, 0, 108, 81),
      child: const Stack(
        children: [],
      ));
}

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    return Card(
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
        child: ListTile(
          title: const Text('event date', style: style),
          subtitle: const Text('event org',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
          trailing: const Text('event time', style: style),
          textColor: Colors.black,
          selectedColor: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
