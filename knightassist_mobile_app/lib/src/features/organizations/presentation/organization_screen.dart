import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

class OrganizationScreen extends ConsumerWidget {
  const OrganizationScreen(
      {super.key, required this.orgID, required this.organization});
  final String orgID;
  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization'),
      ),
      body: Center(child: Text(organization.name)),
    );
  }
}
