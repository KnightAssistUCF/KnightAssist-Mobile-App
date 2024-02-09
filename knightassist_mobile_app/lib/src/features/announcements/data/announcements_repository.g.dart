// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$announcementsRepositoryHash() =>
    r'3df695255d6e6673c29f07951862ed3ef1caa974';

/// See also [announcementsRepository].
@ProviderFor(announcementsRepository)
final announcementsRepositoryProvider =
    AutoDisposeProvider<AnnouncementsRepository>.internal(
  announcementsRepository,
  name: r'announcementsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$announcementsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnnouncementsRepositoryRef
    = AutoDisposeProviderRef<AnnouncementsRepository>;
String _$announcementsListStreamHash() =>
    r'2a4f359ab096af52ad379a9a3e53e48faf86bb63';

/// See also [announcementsListStream].
@ProviderFor(announcementsListStream)
final announcementsListStreamProvider =
    AutoDisposeStreamProvider<List<Announcement>>.internal(
  announcementsListStream,
  name: r'announcementsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$announcementsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnnouncementsListStreamRef
    = AutoDisposeStreamProviderRef<List<Announcement>>;
String _$announcementsListFutureHash() =>
    r'f5004988fa17f9d8adb62682aa62a25e982f17f1';

/// See also [announcementsListFuture].
@ProviderFor(announcementsListFuture)
final announcementsListFutureProvider =
    AutoDisposeFutureProvider<List<Announcement>>.internal(
  announcementsListFuture,
  name: r'announcementsListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$announcementsListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnnouncementsListFutureRef
    = AutoDisposeFutureProviderRef<List<Announcement>>;
String _$announcementHash() => r'0a80951d01283abee1e23b68b838d447b3f659e6';

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

/// See also [announcement].
@ProviderFor(announcement)
const announcementProvider = AnnouncementFamily();

/// See also [announcement].
class AnnouncementFamily extends Family<AsyncValue<Announcement?>> {
  /// See also [announcement].
  const AnnouncementFamily();

  /// See also [announcement].
  AnnouncementProvider call(
    String title,
  ) {
    return AnnouncementProvider(
      title,
    );
  }

  @override
  AnnouncementProvider getProviderOverride(
    covariant AnnouncementProvider provider,
  ) {
    return call(
      provider.title,
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
  String? get name => r'announcementProvider';
}

/// See also [announcement].
class AnnouncementProvider extends AutoDisposeStreamProvider<Announcement?> {
  /// See also [announcement].
  AnnouncementProvider(
    String title,
  ) : this._internal(
          (ref) => announcement(
            ref as AnnouncementRef,
            title,
          ),
          from: announcementProvider,
          name: r'announcementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$announcementHash,
          dependencies: AnnouncementFamily._dependencies,
          allTransitiveDependencies:
              AnnouncementFamily._allTransitiveDependencies,
          title: title,
        );

  AnnouncementProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.title,
  }) : super.internal();

  final String title;

  @override
  Override overrideWith(
    Stream<Announcement?> Function(AnnouncementRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnnouncementProvider._internal(
        (ref) => create(ref as AnnouncementRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        title: title,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Announcement?> createElement() {
    return _AnnouncementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnouncementProvider && other.title == title;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, title.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AnnouncementRef on AutoDisposeStreamProviderRef<Announcement?> {
  /// The parameter `title` of this provider.
  String get title;
}

class _AnnouncementProviderElement
    extends AutoDisposeStreamProviderElement<Announcement?>
    with AnnouncementRef {
  _AnnouncementProviderElement(super.provider);

  @override
  String get title => (origin as AnnouncementProvider).title;
}

String _$announcementsListSearchHash() =>
    r'14f40865c3e2b556de344f09e2b599a935b62d5e';

/// See also [announcementsListSearch].
@ProviderFor(announcementsListSearch)
const announcementsListSearchProvider = AnnouncementsListSearchFamily();

/// See also [announcementsListSearch].
class AnnouncementsListSearchFamily
    extends Family<AsyncValue<List<Announcement>>> {
  /// See also [announcementsListSearch].
  const AnnouncementsListSearchFamily();

  /// See also [announcementsListSearch].
  AnnouncementsListSearchProvider call(
    String query,
  ) {
    return AnnouncementsListSearchProvider(
      query,
    );
  }

  @override
  AnnouncementsListSearchProvider getProviderOverride(
    covariant AnnouncementsListSearchProvider provider,
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
  String? get name => r'announcementsListSearchProvider';
}

/// See also [announcementsListSearch].
class AnnouncementsListSearchProvider
    extends AutoDisposeFutureProvider<List<Announcement>> {
  /// See also [announcementsListSearch].
  AnnouncementsListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => announcementsListSearch(
            ref as AnnouncementsListSearchRef,
            query,
          ),
          from: announcementsListSearchProvider,
          name: r'announcementsListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$announcementsListSearchHash,
          dependencies: AnnouncementsListSearchFamily._dependencies,
          allTransitiveDependencies:
              AnnouncementsListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  AnnouncementsListSearchProvider._internal(
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
    FutureOr<List<Announcement>> Function(AnnouncementsListSearchRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnnouncementsListSearchProvider._internal(
        (ref) => create(ref as AnnouncementsListSearchRef),
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
  AutoDisposeFutureProviderElement<List<Announcement>> createElement() {
    return _AnnouncementsListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnouncementsListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AnnouncementsListSearchRef
    on AutoDisposeFutureProviderRef<List<Announcement>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _AnnouncementsListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<Announcement>>
    with AnnouncementsListSearchRef {
  _AnnouncementsListSearchProviderElement(super.provider);

  @override
  String get query => (origin as AnnouncementsListSearchProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
