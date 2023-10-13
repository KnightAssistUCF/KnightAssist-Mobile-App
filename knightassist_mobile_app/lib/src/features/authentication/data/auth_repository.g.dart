// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'd3ae5e3a1038da1ebf66dc733301302def31bce0';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$authStateChangesHash() => r'70d96078e41cd44270b2118f16bcbed842f33064';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = StreamProvider<AppUser?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = StreamProviderRef<AppUser?>;
String _$idTokenChangesHash() => r'e6058ad0b90d6e10b628af4b3dbd180a67b7146e';

/// See also [idTokenChanges].
@ProviderFor(idTokenChanges)
final idTokenChangesProvider = StreamProvider<AppUser?>.internal(
  idTokenChanges,
  name: r'idTokenChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$idTokenChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IdTokenChangesRef = StreamProviderRef<AppUser?>;
String _$isCurrentUserAdminHash() =>
    r'7a9469c94639721af05bb3fe4c7c3d9c3aec66a4';

/// See also [isCurrentUserAdmin].
@ProviderFor(isCurrentUserAdmin)
final isCurrentUserAdminProvider = FutureProvider<bool>.internal(
  isCurrentUserAdmin,
  name: r'isCurrentUserAdminProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isCurrentUserAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsCurrentUserAdminRef = FutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
