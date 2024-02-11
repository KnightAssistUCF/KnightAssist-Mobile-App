import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:editable_image/editable_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profilePicFile;

  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get firstName => _firstNameController.text;
  String get lastName => _lastNameController.text;
  String get email => _emailController.text;
  String get password => _passwordController.text;

  var _submitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _profilePicFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (context, ref, child) {
        final authRepository = ref.watch(authRepositoryProvider);
        final studentsRepository = ref.watch(studentsRepositoryProvider);
        final user = authRepository.currentUser;
        studentsRepository.fetchStudent(user!.id);
        final student = studentsRepository.getStudent();
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            automaticallyImplyLeading: true,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EditableImage(
                  onChange: _directUpdateImage,
                  image: _profilePicFile != null
                      ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                      : const Image(
                          image: AssetImage(
                              'assets/profile pictures/icon_paintbrush.png')),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTextField(
                    labelText: 'First Name', controller: _firstNameController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTextField(
                    labelText: 'Last Name', controller: _lastNameController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTextField(
                    labelText: 'Email', controller: _emailController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTextField(
                    labelText: 'Password',
                    obscureText: true,
                    controller: _passwordController),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => {
                      studentsRepository.editStudent(
                          student!.id,
                          password,
                          firstName,
                          lastName,
                          email,
                          student.profilePicPath,
                          student.totalVolunteerHours,
                          student.semesterVolunteerHourGoal,
                          student.categoryTags)
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          /*drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                context.pushNamed(AppRoute.homeScreen.name);
              },
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                context.pushNamed(AppRoute.calendar.name);
              },
            ),
            ListTile(
              title: const Text('Organizations'),
              onTap: () {
                context.pushNamed(AppRoute.organizations.name);
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                context.pushNamed(AppRoute.events.name);
              },
            ),
            ListTile(
              title: const Text('Announcements'),
              onTap: () {
                context.pushNamed(AppRoute.updates.name);
              },
            ),
              ListTile(
              title: const Text('QR Scan'),
              onTap: () {
                context.pushNamed(AppRoute.qrScanner.name);
              },
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                context.pushNamed(AppRoute.eventHistory.name);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                context.pushNamed(AppRoute.account.name);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                context.pushNamed(AppRoute.emailConfirm.name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),*/
        );
      },
    );
  }
}

TextField _buildTextField(
    {String labelText = '',
    bool obscureText = false,
    TextEditingController? controller}) {
  return TextField(
    controller: controller,
    cursorColor: Colors.black54,
    cursorWidth: 1,
    obscureText: obscureText,
    obscuringCharacter: '●',
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 18,
      ),
      fillColor: Colors.red,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black54,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black54,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    ),
  );
}

ElevatedButton _buildElevatedButton() {
  return ElevatedButton(
    onPressed: () => {},
    //style: ButtonStyle(
    //padding: MaterialStateProperty.all(
    //const EdgeInsets.symmetric(vertical: 20),
    //),
    //side: MaterialStateProperty.all(const BorderSide(color: Colors.black54)),
    //backgroundColor: MaterialStateProperty.all(Colors.transparent),
    //),
    child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ),
  );
}
