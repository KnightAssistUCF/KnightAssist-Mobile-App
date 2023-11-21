import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'KnightAssist',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.grey,
          fontFamily: 'League Spartan',
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 0, 108, 81),
              foregroundColor: Colors.white,
              elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 91, 78, 119),
                  foregroundColor: Colors.white)),),
    );
  }
}
