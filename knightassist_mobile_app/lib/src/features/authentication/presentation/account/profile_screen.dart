import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:editable_image/editable_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
File? _profilePicFile;

 @override
  void initState() {
    super.initState();
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
              onPressed: () { }, tooltip: 'View notifications', icon: const Icon(Icons.notifications_outlined,
              color: Colors.white, semanticLabel: 'Notifications',),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap:  () {
                context.pushNamed(AppRoute.profileScreen.name);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Image(
                    image:
                        AssetImage('assets/profile pictures/icon_paintbrush.png'),
                    height: 20),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: h,
        child: ListView(
          children: [
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Image(
                        image:
                            AssetImage('assets/profile pictures/icon_paintbrush.png'),
                        height: 100),
              ),
            ),
            const ResponsiveScrollableCard(child: Text('Name')),*/
            EditableImage(
                // Define the method that will run on
                // the change process of the image.
                onChange: _directUpdateImage,

                // Define the source of the image.
                image: _profilePicFile != null
                    ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                    : const Image(image: AssetImage('assets/profile pictures/icon_paintbrush.png')),

                // Define the size of EditableImage.
                size: 150,

                // Define the Theme of image picker.
                imagePickerTheme: ThemeData(
                  // Define the default brightness and colors.
                  primaryColor: Colors.yellow,
                  shadowColor: Colors.deepOrange,
                  colorScheme:
                      const ColorScheme.light(background: Colors.indigo),
                  iconTheme: const IconThemeData(color: Colors.red),

                  // Define the default font family.
                  fontFamily: 'Papyrus',
                ),

                // Define the border of the image if needed.
                imageBorder: Border.all(color: Colors.lime, width: 2),

                // Define the border of the icon if needed.
                editIconBorder: Border.all(color: Colors.purple, width: 2),
              ),
               const Spacer(flex: 2),
              _buildTextField(labelText: 'Username'),
              const Spacer(),
              _buildTextField(labelText: 'Full Name'),
              const Spacer(),
              _buildTextField(labelText: 'Email'),
              const Spacer(),
              _buildTextField(labelText: 'Password', obscureText: true),
              const Spacer(flex: 2),
              _buildTextButton(),
          ],
        )
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                context.pushNamed(AppRoute.homeScreen.name);
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
              title: const Text('Settings'),
              onTap: () {
                context.pushNamed(AppRoute.account.name);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                context.pushNamed(AppRoute.emailConfirmed.name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

TextField _buildTextField({String labelText = '', bool obscureText = false}) {
    return TextField(
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

  TextButton _buildTextButton() {
    return TextButton(
      onPressed: () => {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20),
        ),
        side:
            MaterialStateProperty.all(const BorderSide(color: Colors.black54)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }