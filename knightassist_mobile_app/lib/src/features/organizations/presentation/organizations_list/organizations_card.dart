import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

class OrganizationCard extends ConsumerWidget {
  const OrganizationCard(
      {super.key, required this.organization, this.onPressed});

  final Organization organization;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const organizationCardKey = Key('organization-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        key: organizationCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          // TODO: Replace empty container with org card info
          child: Container(),
        ),
      ),
    );
  }
}
