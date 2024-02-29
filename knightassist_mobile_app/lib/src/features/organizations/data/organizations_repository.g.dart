// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$organizationsRepositoryHash() =>
    r'c1c56c3b11a2dd3cb5bbb2404b1827429f138ebe';

/// See also [organizationsRepository].
@ProviderFor(organizationsRepository)
final organizationsRepositoryProvider =
    AutoDisposeProvider<OrganizationsRepository>.internal(
  organizationsRepository,
  name: r'organizationsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrganizationsRepositoryRef
    = AutoDisposeProviderRef<OrganizationsRepository>;
String _$organizationsListStreamHash() =>
    r'834f12b3c6f3aa57c2b1b1612565c4dbfe6f39c0';

/// See also [organizationsListStream].
@ProviderFor(organizationsListStream)
final organizationsListStreamProvider =
    AutoDisposeStreamProvider<List<Organization>>.internal(
  organizationsListStream,
  name: r'organizationsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrganizationsListStreamRef
    = AutoDisposeStreamProviderRef<List<Organization>>;
String _$organizationsListFutureHash() =>
    r'2d45f3dc741e4b1893fbcc949ea2f9d82e8bf478';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [organizationsListFuture].
@ProviderFor(organizationsListFuture)
const organizationsListFutureProvider = OrganizationsListFutureFamily();

/// See also [organizationsListFuture].
class OrganizationsListFutureFamily
    extends Family<AsyncValue<List<Organization>>> {
  /// See also [organizationsListFuture].
  const OrganizationsListFutureFamily();

  /// See also [organizationsListFuture].
  OrganizationsListFutureProvider call(
    String id,
  ) {
    return OrganizationsListFutureProvider(
      id,
    );
  }

  @override
  OrganizationsListFutureProvider getProviderOverride(
    covariant OrganizationsListFutureProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'organizationsListFutureProvider';
}

/// See also [organizationsListFuture].
class OrganizationsListFutureProvider
    extends AutoDisposeFutureProvider<List<Organization>> {
  /// See also [organizationsListFuture].
  OrganizationsListFutureProvider(
    String id,
  ) : this._internal(
          (ref) => organizationsListFuture(
            ref as OrganizationsListFutureRef,
            id,
          ),
          from: organizationsListFutureProvider,
          name: r'organizationsListFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organizationsListFutureHash,
          dependencies: OrganizationsListFutureFamily._dependencies,
          allTransitiveDependencies:
              OrganizationsListFutureFamily._allTransitiveDependencies,
          id: id,
        );

  OrganizationsListFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<List<Organization>> Function(OrganizationsListFutureRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationsListFutureProvider._internal(
        (ref) => create(ref as OrganizationsListFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Organization>> createElement() {
    return _OrganizationsListFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationsListFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrganizationsListFutureRef
    on AutoDisposeFutureProviderRef<List<Organization>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OrganizationsListFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Organization>>
    with OrganizationsListFutureRef {
  _OrganizationsListFutureProviderElement(super.provider);

  @override
  String get id => (origin as OrganizationsListFutureProvider).id;
}

String _$organizationHash() => r'8bd301c7f376c8416f55baaec9b01e2d56e3b17f';

/// See also [organization].
@ProviderFor(organization)
const organizationProvider = OrganizationFamily();

/// See also [organization].
class OrganizationFamily extends Family<AsyncValue<Organization?>> {
  /// See also [organization].
  const OrganizationFamily();

  /// See also [organization].
  OrganizationProvider call(
    String id,
  ) {
    return OrganizationProvider(
      id,
    );
  }

  @override
  OrganizationProvider getProviderOverride(
    covariant OrganizationProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'organizationProvider';
}

/// See also [organization].
class OrganizationProvider extends AutoDisposeStreamProvider<Organization?> {
  /// See also [organization].
  OrganizationProvider(
    String id,
  ) : this._internal(
          (ref) => organization(
            ref as OrganizationRef,
            id,
          ),
          from: organizationProvider,
          name: r'organizationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organizationHash,
          dependencies: OrganizationFamily._dependencies,
          allTransitiveDependencies:
              OrganizationFamily._allTransitiveDependencies,
          id: id,
        );

  OrganizationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Organization?> Function(OrganizationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationProvider._internal(
        (ref) => create(ref as OrganizationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Organization?> createElement() {
    return _OrganizationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrganizationRef on AutoDisposeStreamProviderRef<Organization?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OrganizationProviderElement
    extends AutoDisposeStreamProviderElement<Organization?>
    with OrganizationRef {
  _OrganizationProviderElement(super.provider);

  @override
  String get id => (origin as OrganizationProvider).id;
}

String _$organizationsListSearchHash() =>
    r'bce1a3577cbf72a42c12c31398b09112056278e8';

/// See also [organizationsListSearch].
@ProviderFor(organizationsListSearch)
const organizationsListSearchProvider = OrganizationsListSearchFamily();

/// See also [organizationsListSearch].
class OrganizationsListSearchFamily
    extends Family<AsyncValue<List<Organization>>> {
  /// See also [organizationsListSearch].
  const OrganizationsListSearchFamily();

  /// See also [organizationsListSearch].
  OrganizationsListSearchProvider call(
    String query,
  ) {
    return OrganizationsListSearchProvider(
      query,
    );
  }

  @override
  OrganizationsListSearchProvider getProviderOverride(
    covariant OrganizationsListSearchProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'organizationsListSearchProvider';
}

/// See also [organizationsListSearch].
class OrganizationsListSearchProvider
    extends AutoDisposeFutureProvider<List<Organization>> {
  /// See also [organizationsListSearch].
  OrganizationsListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => organizationsListSearch(
            ref as OrganizationsListSearchRef,
            query,
          ),
          from: organizationsListSearchProvider,
          name: r'organizationsListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organizationsListSearchHash,
          dependencies: OrganizationsListSearchFamily._dependencies,
          allTransitiveDependencies:
              OrganizationsListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  OrganizationsListSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Organization>> Function(OrganizationsListSearchRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationsListSearchProvider._internal(
        (ref) => create(ref as OrganizationsListSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Organization>> createElement() {
    return _OrganizationsListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationsListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrganizationsListSearchRef
    on AutoDisposeFutureProviderRef<List<Organization>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _OrganizationsListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<Organization>>
    with OrganizationsListSearchRef {
  _OrganizationsListSearchProviderElement(super.provider);

  @override
  String get query => (origin as OrganizationsListSearchProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
