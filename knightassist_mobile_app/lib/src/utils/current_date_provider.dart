import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_date_provider.g.dart';

@riverpod
DateTime Function() currentDateBuilder(CurrentDateBuilderRef ref) {
  return () => DateTime.now();
}
