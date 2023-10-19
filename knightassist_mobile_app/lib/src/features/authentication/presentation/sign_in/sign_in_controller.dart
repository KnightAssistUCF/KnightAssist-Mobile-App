import 'dart:async';

import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> submit({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(email, password));
    return state.hasError == false;
  }

  Future<void> _authenticate(String email, String password) {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signIn(email, password);
  }
}
