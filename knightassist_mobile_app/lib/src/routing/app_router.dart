import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:knightassist_mobile_app/src/routing/go_router_refresh_stream.dart';
import 'package:knightassist_mobile_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute { home, event, account, signIn }

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: false,
      redirect: (context, state) {
        final isLoggedIn = authRepository.currentUser != null;
        final path = state.uri.path;
        if (isLoggedIn) {
          if (path == '/signIn') {
            return '/';
          }
        } else {
          if (path == '/account') {
            return '/';
          }
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                  path: 'event/:id',
                  name: AppRoute.event.name,
                  builder: (context, state) {
                    final eventId = state.pathParameters['id']!;
                    return EventScreen(eventId: eventId);
                  },
                  routes: [
                    GoRoute(
                        path: 'eventRegister',
                        name: AppRoute.eventRegister.name,
                        pageBuilder: (context, state) {
                          final eventId = state.pathParameters['id']!;
                          return MaterialPage(
                              fullscreenDialog: true,
                              child: eventRegisterScreen(eventId: eventId));
                        }),
                  ]),
              GoRoute(
                  path: 'account',
                  name: AppRoute.account.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: AccountScreen())),
              GoRoute(
                  path: 'signIn',
                  name: AppRoute.signIn.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: SignInScreen()))
            ])
      ],
      errorBuilder: (context, state) => const NotFoundScreen());
}
