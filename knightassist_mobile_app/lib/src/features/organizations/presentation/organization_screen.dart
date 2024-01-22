import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/feedback.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:url_launcher/url_launcher.dart';

List<EventFeedback> OrgFeedback = [
  EventFeedback(
      student: '1',
      event: '1',
      studentName: 'Johnson Doe',
      eventName: 'concert',
      rating: 1,
      feedbackText: 'it was bad',
      wasReadByUser: false,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '2',
      event: '2',
      studentName: 'foo',
      eventName: 'study session',
      rating: 2,
      feedbackText:
          'Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum',
      wasReadByUser: true,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '3',
      event: '2',
      studentName: 'Test User',
      eventName: 'movie night',
      rating: 3,
      feedbackText: 'idk',
      wasReadByUser: true,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '4',
      event: '2',
      studentName: 'Student',
      eventName: 'concert',
      rating: 4,
      feedbackText: 'test',
      wasReadByUser: false,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '5',
      event: '3',
      studentName: '',
      eventName: 'study session',
      rating: 5,
      feedbackText: 'epic',
      wasReadByUser: true,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now())
];

class OrganizationScreen extends ConsumerWidget {
  OrganizationScreen({super.key, required this.organization});
  //final String orgID;
  final Organization organization;

  bool curOrg =
      true; // true if the organization who's profile it is is viewing it (shows edit button)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
      body: ListView(
          scrollDirection: Axis.vertical,
          //height: h,
          children: <Widget>[
            Column(
              children: [
                OrganizationTop(width: w, organization: organization),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 340,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(AppRoute.events.name);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 91, 78, 119))),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Wrap(
                                children: [
                                  Text(
                                    'View All Events',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 320,
                        child: TabBarOrg(organization: organization)),
                    curOrg
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
                                onPressed: () => context
                                    .pushNamed(AppRoute.profileScreen.name),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          )
                  ],
                ),
              ],
            )
          ]),
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
                          organization.description,
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
                          organization.contact.socialMedia.instagram == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.instagram);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.instagram)),
                          organization.contact.socialMedia.facebook == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.facebook);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.facebook)),
                          organization.contact.socialMedia.twitter == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.twitter);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.xTwitter)),
                          organization.contact.socialMedia.linkedIn == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.linkedIn);
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
                                  'mailto:${organization.contact.email}?subject=Hello from KnightAssist&body=I am interested in volunteering with your organization!	');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Wrap(children: [
                              const Icon(Icons.email_outlined),
                              Text(
                                organization.contact.email,
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
                                  'tel:${organization.contact.phone}');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Wrap(children: [
                              const Icon(Icons.phone_rounded),
                              Text(
                                organization.contact.phone,
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
                              organization.location,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ]),
                        ),
                      ),
                      organization.contact.website == ''
                          ? const SizedBox(height: 0)
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () async {
                                    final Uri url =
                                        Uri.parse(organization.contact.website);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  child: Wrap(children: [
                                    const Icon(Icons.computer),
                                    Text(
                                      organization.contact.website,
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

class FeedbackCard extends StatelessWidget {
  final EventFeedback feedback;

  const FeedbackCard({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    return ResponsiveCenter(
      maxContentWidth: 220,
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                onTap: () =>
                    context.pushNamed("feedbackdetail", extra: feedback),
                child: Padding(
                  padding: const EdgeInsets.all(0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[ 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            feedback.eventName,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        OverflowBar(
                          children: [ Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: const Image(
                                image: AssetImage(
                                    'assets/profile pictures/icon_paintbrush.png'),
                                height:
                                    50)),
                          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                                        feedback.studentName,
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                                                        textAlign: TextAlign.start,
                                                      ),
                            ),
                    ]), // will be profile picture of student who left the feedback
                        RatingBar.builder(
                          initialRating: feedback.rating,
                          itemSize: 20.0,
                          ignoreGestures: true,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                            feedback.rating = rating;
                          },
                        ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        feedback.feedbackText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(feedback.timeSubmitted),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ] ),
                ),
              ),
            )),
      ),
    );
  }
}
