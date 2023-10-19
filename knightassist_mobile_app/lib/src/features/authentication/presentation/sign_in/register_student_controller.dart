import 'dart:async';

import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_student_controller.g.dart';

@riverpod
class RegisterStudentController extends _$RegisterStudentController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> submit(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => _authenticate(email, password, firstName, lastName));
    return state.hasError == false;
  }

  Future<void> _authenticate(
      String email, String password, String firstName, String lastName) {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.createStudentUser(
        email, password, firstName, lastName);
  }
}
