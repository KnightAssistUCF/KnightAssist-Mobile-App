import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/custom_text_button.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../data/events_repository.dart';
import '../domain/event.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    EventsListScreen(),
    HomeScreenTab(),
    QRCodeScanner(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),*/
      body: _widgetOptions.elementAt(_selectedIndex), // QRCodeScanner();
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined), label: "QR Scan")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 91, 78, 119),
        onTap: _onItemTapped,
      ),
    );
  }
}

class QRCodeScanner extends ConsumerStatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends ConsumerState<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventsRepository = ref.watch(eventsRepositoryProvider);

    Widget buildCheckInOutButton(Barcode result) {
      String text = 'Check In';
      if (result.code!.substring(result.code!.length - 3) == 'out') {
        text = 'Check Out';
      }
      return FutureBuilder(
        future: eventsRepository.fetchEventsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final event;
              if (text == 'Check Out') {
                event = eventsRepository.getEvent(
                    result.code!.substring(0, result.code!.length - 3));
              } else {
                event = eventsRepository.getEvent(result.code!);
              }
              return CustomTextButton(
                text: text,
                onPressed: () =>
                    context.pushNamed(AppRoute.postScan.name, extra: event),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? buildCheckInOutButton(result!)
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
