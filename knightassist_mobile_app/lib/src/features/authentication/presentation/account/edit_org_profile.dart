import 'dart:io';

import 'package:editable_image/editable_image.dart';
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

File? _organizationPicFile;

class EditOrganizationProfile extends ConsumerWidget {
  EditOrganizationProfile({super.key, required this.organization});
  //final String orgID;
  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Edit Profile'),
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
                context.pushNamed("organization", extra: organization);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image(
                      semanticLabel: 'Profile picture',
                      image: AssetImage(organization.logoUrl),
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
                SizedBox(
                    height: 320, child: TabBarOrg(organization: organization)),
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
              child: TextFormField(
                initialValue: organization.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Organization Name',
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: 90.0,
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
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: EditProfileImage(
              organization: organization,
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
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Text("About")),
                Tab(icon: Text("Contact")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 240,
                            height: 120,
                            child: TextFormField(
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              initialValue: organization.description,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: false,
                                  hintText: 'Your Organization Description'),
                            )),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Wrap(
                        children: [
                          Wrap(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.instagram);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.instagram)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    initialValue: organization
                                        .contact.socialMedia.instagram,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Instagram URL (Optional)',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.facebook);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.facebook)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    initialValue: organization
                                        .contact.socialMedia.facebook,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Facebook URL (Optional)',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.twitter);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.xTwitter)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    initialValue: organization
                                        .contact.socialMedia.twitter,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Twitter URL (Optional)',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                        .contact.socialMedia.linkedIn);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon: const FaIcon(
                                      FontAwesomeIcons.linkedinIn)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    initialValue: organization
                                        .contact.socialMedia.linkedIn,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'LinkedIn URL (Optional)',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              children: [
                                const Icon(Icons.email_outlined),
                                SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: organization.contact.email,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Organization Email',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              children: [
                                const Icon(Icons.phone_rounded),
                                SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: organization.contact.phone,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Organization Phone (Optional)',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              const Icon(Icons.location_on),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: organization.location,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Organization Address (Optional)',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  final Uri url =
                                      Uri.parse(organization.contact.website);
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                icon: const Icon(Icons.computer)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: organization.contact.website,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Website URL (Optional)',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Delete Profile Image (reverts to default)',
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
            ),*/
            Center(
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileImage extends StatefulWidget {
  Organization organization;
  EditProfileImage({super.key, required this.organization});

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  late final Organization organization;

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
  }

  Future<void> _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _organizationPicFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EditableImage(
      onChange: _directUpdateImage,
      image: _organizationPicFile != null
          ? Image.file(_organizationPicFile!, fit: BoxFit.cover)
          : Image(image: AssetImage(organization.logoUrl)),
      size: 150,
      imagePickerTheme: ThemeData(
        primaryColor: Colors.yellow,
        shadowColor: Colors.deepOrange,
        colorScheme: const ColorScheme.light(background: Colors.indigo),
        iconTheme: const IconThemeData(color: Colors.red),
        fontFamily: 'Papyrus',
      ),
      imageBorder: Border.all(color: Colors.lime, width: 2),
      editIconBorder: Border.all(color: Colors.purple, width: 2),
    );
  }
}
