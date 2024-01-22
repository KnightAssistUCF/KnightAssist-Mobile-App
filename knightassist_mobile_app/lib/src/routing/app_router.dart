import 'dart:html';

import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/postverify.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/profile_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/semester_goal.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/tag_selection.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/register/register_emailconfirm_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/register/register_organization_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/register/register_student_screen.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/feedback.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_detail.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/bottombar.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/calendar.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/create_event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/create_feedback.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/edit_event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_history_detail.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_history_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/postScan.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/create_update.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/edit_update.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organization_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_detail.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/routing/go_router_refresh_stream.dart';
import 'package:knightassist_mobile_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  events,
  event,
  organizations,
  organization,
  account,
  signIn,
  registerStudent,
  registerOrg,
  emailConfirm,
  homeScreen,
  profileScreen,
  eventHistory,
  historyDetail,
  updates,
  semesterGoal,
  tagSelection,
  qrScanner,
  calendar,
  feedbacklist,
  postVerify,
  postScan,
  createEvent,
  createFeedback,
  createUpdate,
  editEvent,
  editUpdate
}

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
          //if (path == '/account') {
          //return '/';
          //}
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) =>
                const EventsListScreen(), // TEMP, change this to whatever screen you want to test (will need to rerun)
            routes: [
              GoRoute(
                  path: 'events',
                  name: AppRoute.events.name,
                  builder: (context, state) {
                    return const EventsListScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'event',
                        name: 'event',
                        builder: (context, state) {
                          Event ev = state.extra as Event;
                          //final eventID = state.pathParameters['id']!;
                          return EventScreen(event: ev);
                        })
                  ]),
              GoRoute(
                  path: 'organizations',
                  name: AppRoute.organizations.name,
                  builder: (context, state) {
                    return const OrganizationsListScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'organization',
                        name: 'organization',
                        builder: (context, state) {
                          Organization org = state.extra as Organization;
                          //final orgID = state.pathParameters['id']!;
                          return OrganizationScreen(organization: org);
                        })
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
                      fullscreenDialog: true, child: SignInScreen())),
              GoRoute(
                  path: 'registerStudent',
                  name: AppRoute.registerStudent.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: RegisterStudentScreen())),
              GoRoute(
                  path: 'registerOrg',
                  name: AppRoute.registerOrg.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true,
                      child: RegisterOrganizationScreen())),
              GoRoute(
                  path: 'emailConfirm',
                  name: AppRoute.emailConfirm.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: ConfirmScreen())),
              GoRoute(
                  path: 'homeScreen',
                  name: AppRoute.homeScreen.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: HomeScreen())),
              GoRoute(
                  path: 'profileScreen',
                  name: AppRoute.profileScreen.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: ProfileScreen())),
              GoRoute(
                  path: 'eventHistory',
                  name: AppRoute.eventHistory.name,
                  builder: (context, state) {
                    return const EventHistoryScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'historydetail',
                        name: 'historydetail',
                        builder: (context, state) {
                          Event ev = state.extra as Event;
                          //final eventID = state.pathParameters['id']!;
                          return HistoryDetailScreen(event: ev);
                        })
                  ]),
              GoRoute(
                  path: 'updates',
                  name: AppRoute.updates.name,
                  builder: (context, state) {
                    return const UpdateScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'updatedetail',
                        name: 'updatedetail',
                        builder: (context, state) {
                          Update u = state.extra as Update;
                          //final updateID = state.pathParameters['id']!;
                          return UpdateDetailScreen(update: u);
                        })
                  ]),
              GoRoute(
                  path: 'semesterGoal',
                  name: AppRoute.semesterGoal.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: SemesterGoal())),
              GoRoute(
                  path: 'tagSelection',
                  name: AppRoute.tagSelection.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: TagSelection())),
              GoRoute(
                  path: 'qrScanner',
                  name: AppRoute.qrScanner.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: QRScanner())),
              GoRoute(
                  path: 'calendar',
                  name: AppRoute.calendar.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: CalendarView())),
              GoRoute(
                  path: 'feedbacklist',
                  name: AppRoute.feedbacklist.name,
                  builder: (context, state) {
                    return const FeedbackListScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'feedbackdetail',
                        name: 'feedbackdetail',
                        builder: (context, state) {
                          EventFeedback e = state.extra as EventFeedback;
                          //final feedbackID = state.pathParameters['id']!;
                          return FeedbackDetailScreen(
                            feedback: e,
                          );
                        })
                  ]),
              GoRoute(
                  path: 'postverify',
                  name: AppRoute.postVerify.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: PostVerify())),
              GoRoute(
                  path: 'postscan',
                  name: 'postscan',
                  builder: (context, state) {
                    Event ev = state.extra as Event;
                    //final eventID = state.pathParameters['id']!;
                    return PostScan(event: ev);
                  }),
              GoRoute(
                  path: 'createevent',
                  name: AppRoute.createEvent.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: CreateEvent())),
              GoRoute(
                  path: 'createfeedback',
                  name: 'createfeedback',
                  builder: (context, state) {
                    Event e = state.extra as Event;
                    //final eventID = state.pathParameters['id']!;
                    return CreateFeedback(event: e);
                  }),
              GoRoute(
                  path: 'createupdate',
                  name: AppRoute.createUpdate.name,
                  pageBuilder: (context, state) => const MaterialPage(
                      fullscreenDialog: true, child: CreateUpdate())),
              GoRoute(
                  path: 'editevent',
                  name: 'editevent',
                  builder: (context, state) {
                    Event e = state.extra as Event;
                    //final eventID = state.pathParameters['id']!;
                    return EditEvent(event: e);
                  }),
              GoRoute(
                  path: 'editupdate',
                  name: 'editupdate',
                  builder: (context, state) {
                    Update u = state.extra as Update;
                    //final updateID = state.pathParameters['id']!;
                    return EditUpdate(update: u);
                  }),
            ])
      ],
      errorBuilder: (context, state) => const NotFoundScreen());
}
