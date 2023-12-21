import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class OrganizationScreen extends ConsumerWidget {
  const OrganizationScreen({super.key, required this.organization});
  //final String orgID;
  final Organization organization;

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Description: ${organization.description}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email: ${organization.email}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
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
                                    'View upcoming events',
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
                  image: AssetImage(organization.backgroundUrl),
                ),
              ),
            ),
            const SizedBox(height: 50,),
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
                  IconButton(
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
                      })
                ],
              ),
            )
          ],
        ),
        Positioned(
              top: 150.0,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,   
                                    boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                   ],),
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
          )],
    );
  }
}
