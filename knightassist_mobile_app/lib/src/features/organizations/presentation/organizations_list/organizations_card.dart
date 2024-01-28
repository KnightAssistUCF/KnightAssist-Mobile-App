import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

class OrganizationCard extends StatefulWidget {
  final Organization organization;
  final VoidCallback? onPressed;
  final bool isOrg;

  const OrganizationCard(
      {super.key,
      required this.organization,
      required this.onPressed,
      required this.isOrg});

  @override
  _OrganizationCardState createState() => _OrganizationCardState();
}

class _OrganizationCardState extends State<OrganizationCard> {
  bool _isFavoriteOrg = false;
  late final Organization organization;
  late final VoidCallback? onPressed;
  late final bool isOrg;

  _OrganizationCardState();

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
    onPressed = widget.onPressed;
    isOrg = widget.isOrg;
  }

  @override
  Widget build(BuildContext context) {
    // * Keys for testing using find.byKey()
    const organizationCardKey = Key('organization-card');

    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    final Organization organization = this.organization;
    final bool isOrg = this.isOrg;
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                key: organizationCardKey,
                //onTap: onPressed,
                onTap: () =>
                    context.pushNamed("organization", extra: organization),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20.0),
                                    right: Radius.circular(20.0)),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      organization.backgroundUrl == ''
                                          ? 'assets/orgdefaultbackground.png'
                                          : organization.backgroundUrl),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              child: Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image(
                                    image: AssetImage(organization.logoUrl),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          ListTile(
                              /*leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image(
                                    image: AssetImage(organization.logoUrl),
                                    height: 300)),*/
                              title: Text(
                                organization.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(
                                organization.description ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                              trailing: isOrg
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : IconButton(
                                      iconSize: 30.0,
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4, top: 0),
                                      icon: _isFavoriteOrg == true
                                          ? const Icon(Icons.favorite)
                                          : const Icon(Icons.favorite_outline),
                                      color: Colors.pink,
                                      onPressed: () {
                                        setState(() {
                                          _isFavoriteOrg = !_isFavoriteOrg;
                                        });
                                      })),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
