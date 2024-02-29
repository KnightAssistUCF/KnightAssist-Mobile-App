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
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/feedback.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
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

    final organizationsRepository = ref.read(organizationsRepositoryProvider);
    organizationsRepository.fetchOrganizationsList();
    final authRepository = ref.read(authRepositoryProvider);
    final imagesRepository = ref.watch(imagesRepositoryProvider);
    final user = authRepository.currentUser;
    Organization? userOrg = organizationsRepository.getOrganization(user!.id);

    Widget getAppbarProfileImage() {
      return FutureBuilder(
          future: imagesRepository.retrieveImage('2', user!.id),
          builder: (context, snapshot) {
            final String imageUrl = snapshot.data ?? 'No initial data';
            final String state = snapshot.connectionState.toString();
            return ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image(
                  semanticLabel: 'Profile picture',
                  image: NetworkImage(imageUrl),
                  height: 20),
            );
          });
    }

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
                context.pushNamed("organization", extra: userOrg);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: getAppbarProfileImage(),
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

  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _nameController = TextEditingController();

  String get name => _nameController.text;

  var _submitted = false;

  _OrganizationTopState();

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
    width = widget.width;
    _nameController.text = organization.name;
  }

  @override
  void dispose() {
    _node.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Organization organization = this.organization;
    final double width = this.width;

    return Consumer(
      builder: (context, ref, child) {
        final authRepository = ref.watch(authRepositoryProvider);
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);
        final imagesRepository = ref.watch(imagesRepositoryProvider);
        final eventsRepository = ref.watch(eventsRepositoryProvider);
        eventsRepository.fetchEventsList();
        final user = authRepository.currentUser;
        Organization? org;

        org = organizationsRepository.getOrganization(user!.id);

        Widget getOrgBackgroundImage() {
          return FutureBuilder(
              future: imagesRepository.retrieveImage('4', org!.id),
              builder: (context, snapshot) {
                final String imageUrl = snapshot.data ?? 'No initial data';
                final String state = snapshot.connectionState.toString();
                return Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                );
              });
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                getOrgBackgroundImage(),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    //initialValue: organization.name,
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
      },
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

  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _descriptionController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _twitterController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _websiteController = TextEditingController();

  String get description => _descriptionController.text;
  String get instagram => _instagramController.text;
  String get facebook => _facebookController.text;
  String get twitter => _twitterController.text;
  String get linkedin => _linkedinController.text;
  String get email => _emailController.text;
  String get phone => _phoneController.text;
  String get location => _locationController.text;
  String get website => _websiteController.text;

  var _submitted = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    organization = widget.organization;
    if (organization.description != null) {
      _descriptionController.text = organization.description!;
    }
    if (organization.contact!.socialMedia?.instagram != null) {
      _instagramController.text = organization.contact!.socialMedia!.instagram!;
    }
    if (organization.contact!.socialMedia?.facebook != null) {
      _facebookController.text = organization.contact!.socialMedia!.facebook!;
    }
    if (organization.contact!.socialMedia?.twitter != null) {
      _twitterController.text = organization.contact!.socialMedia!.twitter!;
    }
    if (organization.contact!.socialMedia?.linkedin != null) {
      _linkedinController.text = organization.contact!.socialMedia!.linkedin!;
    }
    if (organization.email != null) {
      _emailController.text = organization.email!;
    }
    if (organization.contact?.phone != null) {
      _phoneController.text = organization.contact!.phone!;
    }
    if (organization.location != null) {
      _locationController.text = organization.location!;
    }
    if (organization.contact?.website != null) {
      _websiteController.text = organization.contact!.website!;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _node.dispose();
    _descriptionController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _twitterController.dispose();
    _linkedinController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);
        final authRepository = ref.watch(authRepositoryProvider);
        final user = authRepository.currentUser;

        organizationsRepository.fetchOrganizationsList();

        final org = organizationsRepository.getOrganization(user!.id);

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
                                  controller: _descriptionController,
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  //initialValue: organization.description,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: false,
                                      hintText:
                                          'Your Organization Description'),
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
                                                .contact
                                                ?.socialMedia
                                                ?.instagram ??
                                            '');
                                        if (!await launchUrl(url)) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.instagram)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        controller: _instagramController,
                                        //initialValue: organization
                                        //       .contact?.socialMedia?.instagram ??
                                        //  '',
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
                                                .contact
                                                ?.socialMedia
                                                ?.facebook ??
                                            '');
                                        if (!await launchUrl(url)) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.facebook)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        controller: _facebookController,
                                        //initialValue: organization
                                        //       .contact?.socialMedia?.facebook ??
                                        //   '',
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
                                                .contact
                                                ?.socialMedia!
                                                .twitter ??
                                            '');
                                        if (!await launchUrl(url)) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.xTwitter)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        controller: _twitterController,
                                        //initialValue: organization
                                        //       .contact?.socialMedia?.twitter ??
                                        //   '',
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
                                                .contact
                                                ?.socialMedia
                                                ?.linkedin ??
                                            '');
                                        if (!await launchUrl(url)) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.linkedinIn)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        controller: _linkedinController,
                                        //initialValue: organization
                                        //       .contact?.socialMedia?.linkedin ??
                                        //   '',
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
                                          controller: _emailController,
                                          //initialValue: organization.contact?.email,
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
                                          controller: _phoneController,
                                          //initialValue: organization.contact?.phone,
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
                                      controller: _locationController,
                                      //initialValue: organization.location,
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
                                      final Uri url = Uri.parse(
                                          organization.contact?.website ?? '');
                                      if (!await launchUrl(url)) {
                                        throw Exception(
                                            'Could not launch $url');
                                      }
                                    },
                                    icon: const Icon(Icons.computer)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _websiteController,
                                    //initialValue: organization.contact?.website,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Website URL (Optional)',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("Working Hours per Week"),
                          Text("Monday:"),
                          SelectTime(day: "monday", end: false, org: org!),
                          Text("-"),
                          SelectTime(day: "monday", end: true, org: org),
                          Text("Tuesday:"),
                          SelectTime(day: "tuesday", end: false, org: org),
                          Text("-"),
                          SelectTime(day: "tuesday", end: true, org: org),
                          Text("Wednesday:"),
                          SelectTime(day: "wednesday", end: false, org: org),
                          Text("-"),
                          SelectTime(day: "wednesday", end: true, org: org),
                          Text("Thursday:"),
                          SelectTime(day: "thursday", end: false, org: org),
                          Text("-"),
                          SelectTime(day: "thursday", end: true, org: org),
                          Text("Friday:"),
                          SelectTime(day: "friday", end: false, org: org),
                          Text("-"),
                          SelectTime(day: "friday", end: true, org: org),
                          Text("Saturday:"),
                          SelectTime(day: "saturday", end: false, org: org),
                          Text("-"),
                          SelectTime(day: "saturday", end: true, org: org),
                          Text("Sunday:"),
                          SelectTime(day: "sunday", end: false, org: org),
                          Text("-"),
                          SelectTime(day: "sunday", end: true, org: org),
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
                    onPressed: () {
                      List<String> updateIDs = [];
                      List<String> eventIDs = [];

                      for (Announcement a in org!.announcements) {
                        updateIDs.add(a.id);
                      }

                      for (Event e in org!.eventsArray) {
                        eventIDs.add(e.id);
                      }

                      if (email != '') {
                        org.contact?.email = email;
                      }
                      if (phone != '') {
                        org.contact?.phone = phone;
                      }
                      if (website != '') {
                        org.contact?.website = website;
                      }
                      if (email != '') {
                        org.contact?.email = email;
                      }

                      organizationsRepository.editOrganization(
                          user.id,
                          org?.password ?? '',
                          org?.name ?? '',
                          email,
                          description,
                          org?.logoUrl ?? '',
                          org?.favorites ?? [],
                          org?.favorites ?? [],
                          updateIDs,
                          org?.calendarLink,
                          org?.contact,
                          org?.isActive,
                          org?.eventHappeningNow,
                          org?.backgroundUrl,
                          eventIDs,
                          org?.location,
                          org?.categoryTags,
                          org.workingHoursPerWeek);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
    return Consumer(
      builder: (context, ref, child) {
        final authRepository = ref.watch(authRepositoryProvider);
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);
        final user = authRepository.currentUser;
        final org = organizationsRepository.getOrganization(user!.id);
        final imagesRepository = ref.watch(imagesRepositoryProvider);

        Widget getEditableProfileImage() {
          return FutureBuilder(
              future: imagesRepository.retrieveImage('2', user.id),
              builder: (context, snapshot) {
                final String imageUrl = snapshot.data ?? 'No initial data';
                final String state = snapshot.connectionState.toString();
                return EditableImage(
                  onChange: _directUpdateImage,
                  image: _organizationPicFile != null
                      ? Image.file(_organizationPicFile!, fit: BoxFit.cover)
                      : Image(image: NetworkImage(imageUrl)),
                  size: 150,
                  imagePickerTheme: ThemeData(
                    primaryColor: Colors.yellow,
                    shadowColor: Colors.deepOrange,
                    colorScheme:
                        const ColorScheme.light(background: Colors.indigo),
                    iconTheme: const IconThemeData(color: Colors.red),
                    fontFamily: 'Papyrus',
                  ),
                  imageBorder: Border.all(color: Colors.lime, width: 2),
                  editIconBorder: Border.all(color: Colors.purple, width: 2),
                );
              });
        }

        return getEditableProfileImage();
      },
    );
  }
}

class SelectTime extends StatefulWidget {
  String day; // the weekday for selecting office hours
  bool end; // true if this is for tselecting the end time of a weekday
  Organization org;
  SelectTime(
      {Key? key, required this.day, required this.end, required this.org})
      : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late final String day;
  late final bool end;
  late final Organization org;

  @override
  void initState() {
    super.initState();
    day = widget.day;
    end = widget.end;
    org = widget.org;
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay _getInitialTime() {
      if (end) {
        if (day == 'monday') {
          if (org.workingHoursPerWeek.monday != null) {
            if (org.workingHoursPerWeek.monday!.end != null) {
              return TimeOfDay.fromDateTime(
                  org.workingHoursPerWeek.monday!.end!);
            } else
              return TimeOfDay.now();
          } else
            return TimeOfDay.now();
        }
        if (day == 'tuesday') {
          if (org.workingHoursPerWeek.tuesday != null) {
            if (org.workingHoursPerWeek.tuesday!.end != null) {
              return TimeOfDay.fromDateTime(
                  org.workingHoursPerWeek.tuesday!.end!);
            } else
              return TimeOfDay.now();
          } else
            return TimeOfDay.now();
        }
        if (day == 'wednesday') {
          if (org.workingHoursPerWeek.wednesday != null) {
            if (org.workingHoursPerWeek.wednesday!.end != null) {
              return TimeOfDay.fromDateTime(
                  org.workingHoursPerWeek.wednesday!.end!);
            } else
              return TimeOfDay.now();
          } else
            return TimeOfDay.now();
        }
        if (day == 'thursday') {
          if (org.workingHoursPerWeek.thursday != null) {
            if (org.workingHoursPerWeek.thursday!.end != null) {
              return TimeOfDay.fromDateTime(
                  org.workingHoursPerWeek.thursday!.end!);
            } else
              return TimeOfDay.now();
          } else
            return TimeOfDay.now();
        }
        if (day == 'friday') {
          if (org.workingHoursPerWeek.friday != null) {
            if (org.workingHoursPerWeek.friday!.end != null) {
              return TimeOfDay.fromDateTime(
                  org.workingHoursPerWeek.friday!.end!);
            } else
              return TimeOfDay.now();
          } else
            return TimeOfDay.now();
        }
        if (day == 'saturday') {
          if (org.workingHoursPerWeek.saturday != null) {
            if (org.workingHoursPerWeek.saturday!.end != null) {
              return TimeOfDay.fromDateTime(
                  org.workingHoursPerWeek.saturday!.end!);
            } else
              return TimeOfDay.now();
          } else
            return TimeOfDay.now();
        }
        if (day == 'sunday') {
          if (org.workingHoursPerWeek.sunday != null) {
            if (org.workingHoursPerWeek.sunday!.end != null) {
              return TimeOfDay.fromDateTime(
                  org.workingHoursPerWeek.sunday!.end!);
            } else
              return TimeOfDay.now();
          } else
            return TimeOfDay.now();
        }
      } else if (day == 'monday') {
        if (org.workingHoursPerWeek.monday != null) {
          if (org.workingHoursPerWeek.monday!.start != null) {
            return TimeOfDay.fromDateTime(
                org.workingHoursPerWeek.monday!.start!);
          } else
            return TimeOfDay.now();
        } else
          return TimeOfDay.now();
      } else if (day == 'tuesday') {
        if (org.workingHoursPerWeek.tuesday != null) {
          if (org.workingHoursPerWeek.tuesday!.start != null) {
            return TimeOfDay.fromDateTime(
                org.workingHoursPerWeek.tuesday!.start!);
          } else
            return TimeOfDay.now();
        } else
          return TimeOfDay.now();
      } else if (day == 'wednesday') {
        if (org.workingHoursPerWeek.wednesday != null) {
          if (org.workingHoursPerWeek.wednesday!.start != null) {
            return TimeOfDay.fromDateTime(
                org.workingHoursPerWeek.wednesday!.start!);
          } else
            return TimeOfDay.now();
        } else
          return TimeOfDay.now();
      } else if (day == 'thursday') {
        if (org.workingHoursPerWeek.thursday != null) {
          if (org.workingHoursPerWeek.thursday!.start != null) {
            return TimeOfDay.fromDateTime(
                org.workingHoursPerWeek.thursday!.start!);
          } else
            return TimeOfDay.now();
        } else
          return TimeOfDay.now();
      } else if (day == 'friday') {
        if (org.workingHoursPerWeek.friday != null) {
          if (org.workingHoursPerWeek.friday!.start != null) {
            return TimeOfDay.fromDateTime(
                org.workingHoursPerWeek.friday!.start!);
          } else
            return TimeOfDay.now();
        } else
          return TimeOfDay.now();
      } else if (day == 'saturday') {
        if (org.workingHoursPerWeek.saturday != null) {
          if (org.workingHoursPerWeek.saturday!.start != null) {
            return TimeOfDay.fromDateTime(
                org.workingHoursPerWeek.saturday!.start!);
          } else
            return TimeOfDay.now();
        } else
          return TimeOfDay.now();
      } else if (day == 'sunday') {
        if (org.workingHoursPerWeek.sunday != null) {
          if (org.workingHoursPerWeek.sunday!.start != null) {
            return TimeOfDay.fromDateTime(
                org.workingHoursPerWeek.sunday!.start!);
          } else
            return TimeOfDay.now();
        } else
          return TimeOfDay.now();
      }
      return TimeOfDay.now();
    }

    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _getInitialTime());
    if (picked != null && picked != _getInitialTime()) {
      setState(() {
        if (end) {
          if (day == 'monday') {
            if (org.workingHoursPerWeek.monday == null) {
              org.workingHoursPerWeek.monday =
                  WeekDay(end: DateTime(picked.hour, picked.minute));
            }
            org.workingHoursPerWeek.monday!.end =
                DateTime(picked.hour, picked.minute);
          }
          if (day == 'tuesday') {
            if (org.workingHoursPerWeek.tuesday == null) {
              org.workingHoursPerWeek.tuesday =
                  WeekDay(end: DateTime(picked.hour, picked.minute));
            }
            org.workingHoursPerWeek.tuesday!.end =
                DateTime(picked.hour, picked.minute);
          }
          if (day == 'wednesday') {
            if (org.workingHoursPerWeek.wednesday == null) {
              org.workingHoursPerWeek.wednesday =
                  WeekDay(end: DateTime(picked.hour, picked.minute));
            }
            org.workingHoursPerWeek.wednesday!.end =
                DateTime(picked.hour, picked.minute);
          }
          if (day == 'thursday') {
            if (org.workingHoursPerWeek.thursday == null) {
              org.workingHoursPerWeek.thursday =
                  WeekDay(end: DateTime(picked.hour, picked.minute));
            }
            org.workingHoursPerWeek.thursday!.end =
                DateTime(picked.hour, picked.minute);
          }
          if (day == 'friday') {
            if (org.workingHoursPerWeek.friday == null) {
              org.workingHoursPerWeek.friday =
                  WeekDay(end: DateTime(picked.hour, picked.minute));
            }
            org.workingHoursPerWeek.friday!.end =
                DateTime(picked.hour, picked.minute);
          }
          if (day == 'saturday') {
            if (org.workingHoursPerWeek.saturday == null) {
              org.workingHoursPerWeek.saturday =
                  WeekDay(end: DateTime(picked.hour, picked.minute));
            }
            org.workingHoursPerWeek.saturday!.end =
                DateTime(picked.hour, picked.minute);
          }
          if (day == 'sunday') {
            if (org.workingHoursPerWeek.sunday == null) {
              org.workingHoursPerWeek.sunday =
                  WeekDay(end: DateTime(picked.hour, picked.minute));
            }
            org.workingHoursPerWeek.sunday!.end =
                DateTime(picked.hour, picked.minute);
          }
        } else if (day == 'monday') {
          if (org.workingHoursPerWeek.monday == null) {
            org.workingHoursPerWeek.monday =
                WeekDay(start: DateTime(picked.hour, picked.minute));
          }
          org.workingHoursPerWeek.monday!.start =
              DateTime(picked.hour, picked.minute);
        } else if (day == 'tuesday') {
          if (org.workingHoursPerWeek.tuesday == null) {
            org.workingHoursPerWeek.tuesday =
                WeekDay(start: DateTime(picked.hour, picked.minute));
          }
          org.workingHoursPerWeek.tuesday!.start =
              DateTime(picked.hour, picked.minute);
        } else if (day == 'wednesday') {
          if (org.workingHoursPerWeek.wednesday == null) {
            org.workingHoursPerWeek.wednesday =
                WeekDay(start: DateTime(picked.hour, picked.minute));
          }
          org.workingHoursPerWeek.wednesday!.start =
              DateTime(picked.hour, picked.minute);
        } else if (day == 'thursday') {
          if (org.workingHoursPerWeek.thursday == null) {
            org.workingHoursPerWeek.thursday =
                WeekDay(start: DateTime(picked.hour, picked.minute));
          }
          org.workingHoursPerWeek.thursday!.start =
              DateTime(picked.hour, picked.minute);
        } else if (day == 'friday') {
          if (org.workingHoursPerWeek.friday == null) {
            org.workingHoursPerWeek.friday =
                WeekDay(start: DateTime(picked.hour, picked.minute));
          }
          org.workingHoursPerWeek.friday!.start =
              DateTime(picked.hour, picked.minute);
        } else if (day == 'saturday') {
          if (org.workingHoursPerWeek.saturday == null) {
            org.workingHoursPerWeek.saturday =
                WeekDay(start: DateTime(picked.hour, picked.minute));
          }
          org.workingHoursPerWeek.saturday!.start =
              DateTime(picked.hour, picked.minute);
        } else if (day == 'sunday') {
          if (org.workingHoursPerWeek.sunday == null) {
            org.workingHoursPerWeek.sunday =
                WeekDay(start: DateTime(picked.hour, picked.minute));
          }
          org.workingHoursPerWeek.sunday!.start =
              DateTime(picked.hour, picked.minute);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String endText = end ? 'End' : 'Start';

    Text getTimeText() {
      DateTime? orgTime;

      if (day == 'monday') {
        if (end) {
          orgTime = org.workingHoursPerWeek.monday?.end ?? DateTime.now();
        } else {
          orgTime = org.workingHoursPerWeek.monday?.start ?? DateTime.now();
        }
      }
      if (day == 'tuesday') {
        if (end) {
          orgTime = org.workingHoursPerWeek.tuesday?.end ?? DateTime.now();
        } else {
          orgTime = org.workingHoursPerWeek.tuesday?.start ?? DateTime.now();
        }
      }
      if (day == 'wednesday') {
        if (end) {
          orgTime = org.workingHoursPerWeek.wednesday?.end ?? DateTime.now();
        } else {
          orgTime = org.workingHoursPerWeek.wednesday?.start ?? DateTime.now();
        }
      }
      if (day == 'thursday') {
        if (end) {
          orgTime = org.workingHoursPerWeek.thursday?.end ?? DateTime.now();
        } else {
          orgTime = org.workingHoursPerWeek.thursday?.start ?? DateTime.now();
        }
      }
      if (day == 'friday') {
        if (end) {
          orgTime = org.workingHoursPerWeek.friday?.end ?? DateTime.now();
        } else {
          orgTime = org.workingHoursPerWeek.friday?.start ?? DateTime.now();
        }
      }
      if (day == 'saturday') {
        if (end) {
          orgTime = org.workingHoursPerWeek.saturday?.end ?? DateTime.now();
        } else {
          orgTime = org.workingHoursPerWeek.saturday?.start ?? DateTime.now();
        }
      }
      if (day == 'sunday') {
        if (end) {
          orgTime = org.workingHoursPerWeek.sunday?.end ?? DateTime.now();
        } else {
          orgTime = org.workingHoursPerWeek.sunday?.start ?? DateTime.now();
        }
      }

      return Text(
          TimeOfDay.fromDateTime(orgTime ?? DateTime.now()).format(context));
    }

    return Column(
      children: [
        Center(child: getTimeText()),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text('Select $day $endText Time'),
          ),
        ),
      ],
    );
  }
}
