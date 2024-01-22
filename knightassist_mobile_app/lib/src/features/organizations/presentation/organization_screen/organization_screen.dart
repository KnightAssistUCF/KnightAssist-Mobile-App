import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/custom_image.dart';
import 'package:knightassist_mobile_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key, required this.organizationID});
  final String organizationID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("temp")),
      body: Consumer(
        builder: (context, ref, _) {
          final organizationValue =
              ref.watch(organizationProvider(organizationID));
          return AsyncValueWidget<Organization?>(
            value: organizationValue,
            data: (organization) => organization == null
                ? const EmptyPlaceholderWidget(
                    message: 'Organization not found',
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: OrganizationDetails(organization: organization),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class OrganizationDetails extends ConsumerWidget {
  const OrganizationDetails({super.key, required this.organization});
  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: CustomImage(imageUrl: organization.logoUrl),
          ),
        ),
        const SizedBox(height: Sizes.p16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(organization.name,
                    style: Theme.of(context).textTheme.titleLarge),
                gapH8,
                Text(organization.description ?? ''),
                // TODO: Finish organization screen UI
              ],
            ),
          ),
        )
      ],
    );
  }
}
