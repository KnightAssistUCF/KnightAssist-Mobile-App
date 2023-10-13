import 'package:knightassist_mobile_app/src/app.dart';
import 'package:knightassist_mobile_app/src/exceptions/async_error_logger.dart';
import 'package:knightassist_mobile_app/src/exceptions/error_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  final container = ProviderContainer(observers: [AsyncErrorLogger()]);

  final errorLogger = container.read(errorLoggerProvider);

  registerErrorHandlers(errorLogger);

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
