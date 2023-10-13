import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    debugPrint('$error, $stackTrace');
  }

  void logAppException(AppException exception) {
    debugPrint('$exception');
  }
}

@riverpod
ErrorLogger errorLogger(ErrorLoggerRef ref) {
  return ErrorLogger();
}
