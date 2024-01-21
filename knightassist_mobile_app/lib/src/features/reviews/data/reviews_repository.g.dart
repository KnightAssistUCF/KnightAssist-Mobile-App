// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewsRepositoryHash() => r'65d3f77ba541b9f480abc3afaf0f0eeb1b3640e4';

/// See also [reviewsRepository].
@ProviderFor(reviewsRepository)
final reviewsRepositoryProvider = Provider<ReviewsRepository>.internal(
  reviewsRepository,
  name: r'reviewsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReviewsRepositoryRef = ProviderRef<ReviewsRepository>;
String _$eventReviewsHash() => r'ab22848f0862a1fb909789696ff919106063bb57';

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

/// See also [eventReviews].
@ProviderFor(eventReviews)
const eventReviewsProvider = EventReviewsFamily();

/// See also [eventReviews].
class EventReviewsFamily extends Family<AsyncValue<List<Review>>> {
  /// See also [eventReviews].
  const EventReviewsFamily();

  /// See also [eventReviews].
  EventReviewsProvider call(
    String id,
  ) {
    return EventReviewsProvider(
      id,
    );
  }

  @override
  EventReviewsProvider getProviderOverride(
    covariant EventReviewsProvider provider,
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
  String? get name => r'eventReviewsProvider';
}

/// See also [eventReviews].
class EventReviewsProvider extends AutoDisposeStreamProvider<List<Review>> {
  /// See also [eventReviews].
  EventReviewsProvider(
    String id,
  ) : this._internal(
          (ref) => eventReviews(
            ref as EventReviewsRef,
            id,
          ),
          from: eventReviewsProvider,
          name: r'eventReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventReviewsHash,
          dependencies: EventReviewsFamily._dependencies,
          allTransitiveDependencies:
              EventReviewsFamily._allTransitiveDependencies,
          id: id,
        );

  EventReviewsProvider._internal(
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
    Stream<List<Review>> Function(EventReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventReviewsProvider._internal(
        (ref) => create(ref as EventReviewsRef),
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
  AutoDisposeStreamProviderElement<List<Review>> createElement() {
    return _EventReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventReviewsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventReviewsRef on AutoDisposeStreamProviderRef<List<Review>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _EventReviewsProviderElement
    extends AutoDisposeStreamProviderElement<List<Review>>
    with EventReviewsRef {
  _EventReviewsProviderElement(super.provider);

  @override
  String get id => (origin as EventReviewsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
