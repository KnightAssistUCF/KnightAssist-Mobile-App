import 'dart:async';

import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_organization_controller.g.dart';

@riverpod
class RegisterOrganizationController extends _$RegisterOrganizationController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> submit(
      {required String email,
      required String password,
      required String name}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(email, password, name));
    return state.hasError == false;
  }

  Future<void> _authenticate(String email, String password, String name) {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.createOrganization(email, password, name);
  }
}
