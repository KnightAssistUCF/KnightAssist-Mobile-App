import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrganizationScreen extends ConsumerWidget {
  const OrganizationScreen({super.key, required this.orgID});
  final String orgID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization'),
      ),
      body: const Center(child: Text("PLACEHOLDER")),
    );
  }
}
