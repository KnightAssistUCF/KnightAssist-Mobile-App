import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key, required this.event});
  //final String eventID;
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
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
      body: Container(
        height: h,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: const Image(
                        image: AssetImage('assets/example.png'), height: 50)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    event.sponsoringOrganization,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const OrganizationFav(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class OrganizationFav extends StatefulWidget {
  //final Organization organization;

  const OrganizationFav({super.key});

  @override
  _OrganizationFavState createState() => _OrganizationFavState();
}

class _OrganizationFavState extends State<OrganizationFav> {
  bool _isFavoriteOrg = false;
  //late final Organization organization;

  _OrganizationFavState();

  @override
  void initState() {
    super.initState();
    //organization = widget.organization;
  }

  @override
  Widget build(BuildContext context) {
    //final Organization organization = this.organization;

    return IconButton(
        iconSize: 30.0,
        padding: const EdgeInsets.only(left: 4, right: 4, top: 0),
        icon: _isFavoriteOrg == true
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_outline),
        color: Colors.pink,
        onPressed: () {
          setState(() {
            _isFavoriteOrg = !_isFavoriteOrg;
          });
        });
  }
}
