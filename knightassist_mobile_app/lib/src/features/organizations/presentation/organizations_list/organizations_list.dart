import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list/organizations_card.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list/organizations_search_state_provider.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class OrganizationsList extends ConsumerWidget {
  const OrganizationsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationsListValue =
        ref.watch(organizationsSearchResultsProvider);
    final authRepository = ref.watch(authRepositoryProvider);
    bool isOrg = authRepository.currentUser?.role == 'organization';
    return AsyncValueWidget<List<Organization>>(
      value: organizationsListValue,
      data: (organizations) => organizations.isEmpty
          ? Center(
              child: Text(
                'No organizations found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: organizations.length,
              itemBuilder: (_, index) {
                final organization = organizations[index];
                return OrganizationCard(
                  organization: organization,
                  onPressed: () => context.goNamed(AppRoute.organization.name,
                      pathParameters: {'id': organization.id}),
                  isOrg: isOrg,
                );
              },
            ),
    );
  }
}
