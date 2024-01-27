import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/custom_image.dart';
import 'package:knightassist_mobile_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organization_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key, required this.organizationID});
  final String organizationID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Organizations'),
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
    bool isOrg = true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /*Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: CustomImage(imageUrl: organization.logoUrl),
          ),
        ),
        const SizedBox(height: Sizes.p16),*/
        //Card(
        //child: Padding(
        Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Text(organization.name,
              //style: Theme.of(context).textTheme.titleLarge),
              //gapH8,
              //Text(organization.description ?? ''),
              OrganizationTop(
                  organization: organization,
                  width: MediaQuery.sizeOf(context).width),
              SizedBox(
                  height: 320, child: TabBarOrg(organization: organization)),
              isOrg
                  ? Padding(
                      // shows edit button for org viewing their own profile
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          onPressed: () => context.pushNamed("editorgprofile",
                              extra: organization),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    )
            ],
          ),
        ),
        //)
      ],
    );
  }
}

class OrganizationTop extends StatefulWidget {
  final Organization organization;
  final double width;

  const OrganizationTop(
      {super.key, required this.organization, required this.width});

  @override
  _OrganizationTopState createState() => _OrganizationTopState();
}

class _OrganizationTopState extends State<OrganizationTop> {
  bool _isFavoriteOrg = false;
  late final Organization organization;
  late final double width;

  _OrganizationTopState();

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
    width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    final Organization organization = this.organization;
    final double width = this.width;
    bool isOrg =
        true; // true if an organization is viewing the page (removes favorite icon)

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(organization.backgroundUrl == ''
                      ? 'assets/orgdefaultbackground.png'
                      : organization.backgroundUrl),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Text(
                    organization.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 25),
                  ),
                  isOrg
                      ? SizedBox(
                          height: 0,
                        )
                      : IconButton(
                          iconSize: 30.0,
                          padding:
                              const EdgeInsets.only(left: 4, right: 4, top: 0),
                          icon: _isFavoriteOrg == true
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_outline),
                          color: Colors.pink,
                          onPressed: () {
                            setState(() {
                              _isFavoriteOrg = !_isFavoriteOrg;
                            });
                          })
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 150.0,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(48),
                child: Image(
                    semanticLabel: 'Organization profile picture',
                    image: AssetImage(organization.logoUrl),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TabBarOrg extends StatefulWidget {
  final Organization organization;

  const TabBarOrg({super.key, required this.organization});

  @override
  State<TabBarOrg> createState() => _TabBarOrgState();
}

class _TabBarOrgState extends State<TabBarOrg> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final Organization organization;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    organization = widget.organization;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Text("About")),
                Tab(icon: Text("Contact")),
                Tab(icon: Text("Ratings")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          organization.description ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          organization.contact?.socialMedia?.instagram == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contact?.socialMedia?.instagram ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.instagram)),
                          organization.contact?.socialMedia?.facebook == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contact?.socialMedia?.facebook ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.facebook)),
                          organization.contact?.socialMedia?.twitter == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contact?.socialMedia?.twitter ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.xTwitter)),
                          organization.contact?.socialMedia?.linkedin == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contact?.socialMedia?.linkedin ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.linkedin))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'mailto:${organization.contact?.email}?subject=Hello from KnightAssist&body=I am interested in volunteering with your organization!	');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Wrap(children: [
                              const Icon(Icons.email_outlined),
                              Text(
                                organization.contact?.email ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'tel:${organization.contact?.phone}');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Wrap(children: [
                              const Icon(Icons.phone_rounded),
                              Text(
                                organization.contact?.phone ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Wrap(children: [
                            const SizedBox(width: 5),
                            const Icon(Icons.location_on),
                            Text(
                              organization.location ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ]),
                        ),
                      ),
                      organization.contact?.website == ''
                          ? const SizedBox(height: 0)
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(
                                        organization.contact?.website ?? '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  child: Wrap(children: [
                                    const Icon(Icons.computer),
                                    Text(
                                      organization.contact?.website ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                    ],
                  ),
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '4.3',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: 4.3,
                        ignoreGestures: true,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating:
                            true, // displays half ratings for org averages
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          // feedback.rating = rating;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${OrgFeedback.length} Total Reviews',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 240,
                        width: 100,
                        child: ListView.builder(
                          // TODO: use retrieveAllFeedback api here
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: OrgFeedback.length,
                          itemBuilder: (context, index) => FeedbackCard(
                              feedback: OrgFeedback.elementAt(index)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
