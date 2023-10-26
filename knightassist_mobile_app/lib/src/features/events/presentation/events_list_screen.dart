import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Shifts'),
      ),
      body: ListView(
        children: const <Widget>[
          EventCard(),
          EventCard(),
        ],
      ),
    );
    //const Center(child: Text("PLACEHOLDER")),
  }
}

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    return Card(
      color: theme.colorScheme.primary,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListTile(
          title: const Text('event date', style: style),
          subtitle: const Text('event org',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
          trailing: const Text('event time', style: style),
          textColor: Colors.white,
          selectedColor: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
