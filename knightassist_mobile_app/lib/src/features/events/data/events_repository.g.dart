// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsRepositoryHash() => r'b30ee26924f9e33e3741f554c84a0fe50c63303f';

/// See also [eventsRepository].
@ProviderFor(eventsRepository)
final eventsRepositoryProvider = AutoDisposeProvider<EventsRepository>.internal(
  eventsRepository,
  name: r'eventsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EventsRepositoryRef = AutoDisposeProviderRef<EventsRepository>;
String _$eventsListStreamHash() => r'34155e1de98474dfb523b8c8323aaecc3736f8ba';

/// See also [eventsListStream].
@ProviderFor(eventsListStream)
final eventsListStreamProvider =
    AutoDisposeStreamProvider<List<Event>>.internal(
  eventsListStream,
  name: r'eventsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EventsListStreamRef = AutoDisposeStreamProviderRef<List<Event>>;
String _$eventsListFutureHash() => r'9442ea87dc3d2048fff338b855ab69f737e4b3e8';

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

/// See also [eventsListFuture].
@ProviderFor(eventsListFuture)
const eventsListFutureProvider = EventsListFutureFamily();

/// See also [eventsListFuture].
class EventsListFutureFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [eventsListFuture].
  const EventsListFutureFamily();

  /// See also [eventsListFuture].
  EventsListFutureProvider call(
    String id,
  ) {
    return EventsListFutureProvider(
      id,
    );
  }

  @override
  EventsListFutureProvider getProviderOverride(
    covariant EventsListFutureProvider provider,
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
  String? get name => r'eventsListFutureProvider';
}

/// See also [eventsListFuture].
class EventsListFutureProvider extends AutoDisposeFutureProvider<List<Event>> {
  /// See also [eventsListFuture].
  EventsListFutureProvider(
    String id,
  ) : this._internal(
          (ref) => eventsListFuture(
            ref as EventsListFutureRef,
            id,
          ),
          from: eventsListFutureProvider,
          name: r'eventsListFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsListFutureHash,
          dependencies: EventsListFutureFamily._dependencies,
          allTransitiveDependencies:
              EventsListFutureFamily._allTransitiveDependencies,
          id: id,
        );

  EventsListFutureProvider._internal(
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
    FutureOr<List<Event>> Function(EventsListFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsListFutureProvider._internal(
        (ref) => create(ref as EventsListFutureRef),
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
  AutoDisposeFutureProviderElement<List<Event>> createElement() {
    return _EventsListFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsListFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsListFutureRef on AutoDisposeFutureProviderRef<List<Event>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _EventsListFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Event>>
    with EventsListFutureRef {
  _EventsListFutureProviderElement(super.provider);

  @override
  String get id => (origin as EventsListFutureProvider).id;
}

String _$eventHash() => r'ff688a7f2d4406cb14e3824d5ecc9fc7d520adb1';

/// See also [event].
@ProviderFor(event)
const eventProvider = EventFamily();

/// See also [event].
class EventFamily extends Family<AsyncValue<Event?>> {
  /// See also [event].
  const EventFamily();

  /// See also [event].
  EventProvider call(
    String id,
  ) {
    return EventProvider(
      id,
    );
  }

  @override
  EventProvider getProviderOverride(
    covariant EventProvider provider,
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
  String? get name => r'eventProvider';
}

/// See also [event].
class EventProvider extends AutoDisposeStreamProvider<Event?> {
  /// See also [event].
  EventProvider(
    String id,
  ) : this._internal(
          (ref) => event(
            ref as EventRef,
            id,
          ),
          from: eventProvider,
          name: r'eventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventHash,
          dependencies: EventFamily._dependencies,
          allTransitiveDependencies: EventFamily._allTransitiveDependencies,
          id: id,
        );

  EventProvider._internal(
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
    Stream<Event?> Function(EventRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventProvider._internal(
        (ref) => create(ref as EventRef),
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
  AutoDisposeStreamProviderElement<Event?> createElement() {
    return _EventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventRef on AutoDisposeStreamProviderRef<Event?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _EventProviderElement extends AutoDisposeStreamProviderElement<Event?>
    with EventRef {
  _EventProviderElement(super.provider);

  @override
  String get id => (origin as EventProvider).id;
}

String _$eventsListOrgHash() => r'ea68bf5736979432a00b74a9e71806bdb1a0c435';

/// See also [eventsListOrg].
@ProviderFor(eventsListOrg)
const eventsListOrgProvider = EventsListOrgFamily();

/// See also [eventsListOrg].
class EventsListOrgFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [eventsListOrg].
  const EventsListOrgFamily();

  /// See also [eventsListOrg].
  EventsListOrgProvider call(
    String orgID,
  ) {
    return EventsListOrgProvider(
      orgID,
    );
  }

  @override
  EventsListOrgProvider getProviderOverride(
    covariant EventsListOrgProvider provider,
  ) {
    return call(
      provider.orgID,
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
  String? get name => r'eventsListOrgProvider';
}

/// See also [eventsListOrg].
class EventsListOrgProvider extends AutoDisposeFutureProvider<List<Event>> {
  /// See also [eventsListOrg].
  EventsListOrgProvider(
    String orgID,
  ) : this._internal(
          (ref) => eventsListOrg(
            ref as EventsListOrgRef,
            orgID,
          ),
          from: eventsListOrgProvider,
          name: r'eventsListOrgProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsListOrgHash,
          dependencies: EventsListOrgFamily._dependencies,
          allTransitiveDependencies:
              EventsListOrgFamily._allTransitiveDependencies,
          orgID: orgID,
        );

  EventsListOrgProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orgID,
  }) : super.internal();

  final String orgID;

  @override
  Override overrideWith(
    FutureOr<List<Event>> Function(EventsListOrgRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsListOrgProvider._internal(
        (ref) => create(ref as EventsListOrgRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orgID: orgID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Event>> createElement() {
    return _EventsListOrgProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsListOrgProvider && other.orgID == orgID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orgID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsListOrgRef on AutoDisposeFutureProviderRef<List<Event>> {
  /// The parameter `orgID` of this provider.
  String get orgID;
}

class _EventsListOrgProviderElement
    extends AutoDisposeFutureProviderElement<List<Event>>
    with EventsListOrgRef {
  _EventsListOrgProviderElement(super.provider);

  @override
  String get orgID => (origin as EventsListOrgProvider).orgID;
}

String _$eventsListStudentHash() => r'1e305e019be5efb3bb8fca5a9d4ede333e814b78';

/// See also [eventsListStudent].
@ProviderFor(eventsListStudent)
const eventsListStudentProvider = EventsListStudentFamily();

/// See also [eventsListStudent].
class EventsListStudentFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [eventsListStudent].
  const EventsListStudentFamily();

  /// See also [eventsListStudent].
  EventsListStudentProvider call(
    String uid,
  ) {
    return EventsListStudentProvider(
      uid,
    );
  }

  @override
  EventsListStudentProvider getProviderOverride(
    covariant EventsListStudentProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'eventsListStudentProvider';
}

/// See also [eventsListStudent].
class EventsListStudentProvider extends AutoDisposeFutureProvider<List<Event>> {
  /// See also [eventsListStudent].
  EventsListStudentProvider(
    String uid,
  ) : this._internal(
          (ref) => eventsListStudent(
            ref as EventsListStudentRef,
            uid,
          ),
          from: eventsListStudentProvider,
          name: r'eventsListStudentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsListStudentHash,
          dependencies: EventsListStudentFamily._dependencies,
          allTransitiveDependencies:
              EventsListStudentFamily._allTransitiveDependencies,
          uid: uid,
        );

  EventsListStudentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<List<Event>> Function(EventsListStudentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsListStudentProvider._internal(
        (ref) => create(ref as EventsListStudentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Event>> createElement() {
    return _EventsListStudentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsListStudentProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsListStudentRef on AutoDisposeFutureProviderRef<List<Event>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _EventsListStudentProviderElement
    extends AutoDisposeFutureProviderElement<List<Event>>
    with EventsListStudentRef {
  _EventsListStudentProviderElement(super.provider);

  @override
  String get uid => (origin as EventsListStudentProvider).uid;
}

String _$eventsListSearchHash() => r'2161db5630bf34307657024316819cbb42ac494a';

/// See also [eventsListSearch].
@ProviderFor(eventsListSearch)
const eventsListSearchProvider = EventsListSearchFamily();

/// See also [eventsListSearch].
class EventsListSearchFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [eventsListSearch].
  const EventsListSearchFamily();

  /// See also [eventsListSearch].
  EventsListSearchProvider call(
    String query,
  ) {
    return EventsListSearchProvider(
      query,
    );
  }

  @override
  EventsListSearchProvider getProviderOverride(
    covariant EventsListSearchProvider provider,
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
  String? get name => r'eventsListSearchProvider';
}

/// See also [eventsListSearch].
class EventsListSearchProvider extends AutoDisposeFutureProvider<List<Event>> {
  /// See also [eventsListSearch].
  EventsListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => eventsListSearch(
            ref as EventsListSearchRef,
            query,
          ),
          from: eventsListSearchProvider,
          name: r'eventsListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsListSearchHash,
          dependencies: EventsListSearchFamily._dependencies,
          allTransitiveDependencies:
              EventsListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  EventsListSearchProvider._internal(
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
    FutureOr<List<Event>> Function(EventsListSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsListSearchProvider._internal(
        (ref) => create(ref as EventsListSearchRef),
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
  AutoDisposeFutureProviderElement<List<Event>> createElement() {
    return _EventsListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventsListSearchRef on AutoDisposeFutureProviderRef<List<Event>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _EventsListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<Event>>
    with EventsListSearchRef {
  _EventsListSearchProviderElement(super.provider);

  @override
  String get query => (origin as EventsListSearchProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member