// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfilePreviewPhoto)
final profilePreviewPhotoProvider = ProfilePreviewPhotoProvider._();

final class ProfilePreviewPhotoProvider
    extends $NotifierProvider<ProfilePreviewPhoto, String?> {
  ProfilePreviewPhotoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profilePreviewPhotoProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profilePreviewPhotoHash();

  @$internal
  @override
  ProfilePreviewPhoto create() => ProfilePreviewPhoto();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$profilePreviewPhotoHash() =>
    r'5de4f944aec686c14a784b4556ef26e23d8766bf';

abstract class _$ProfilePreviewPhoto extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String?, String?>, String?, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

final class ProfileControllerProvider
    extends $NotifierProvider<ProfileController, AsyncValue<void>> {
  ProfileControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$profileControllerHash() => r'4ddc6af5bd60a49c7549d27a8c798fb900c3f021';

abstract class _$ProfileController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(AvatarUploading)
final avatarUploadingProvider = AvatarUploadingProvider._();

final class AvatarUploadingProvider
    extends $NotifierProvider<AvatarUploading, bool> {
  AvatarUploadingProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'avatarUploadingProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$avatarUploadingHash();

  @$internal
  @override
  AvatarUploading create() => AvatarUploading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$avatarUploadingHash() => r'3acf555ac860d35bc975cb9ddee8fa6cc768c6ee';

abstract class _$AvatarUploading extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Profile)
final profileProvider = ProfileProvider._();

final class ProfileProvider extends $StreamNotifierProvider<Profile, User?> {
  ProfileProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileHash();

  @$internal
  @override
  Profile create() => Profile();
}

String _$profileHash() => r'73e774df6bd90080092866e88ab405dac246591f';

abstract class _$Profile extends $StreamNotifier<User?> {
  Stream<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<User?>, User?>,
        AsyncValue<User?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(profileView)
final profileViewProvider = ProfileViewProvider._();

final class ProfileViewProvider extends $FunctionalProvider<
        AsyncValue<ProfileViewData>, ProfileViewData, FutureOr<ProfileViewData>>
    with $FutureModifier<ProfileViewData>, $FutureProvider<ProfileViewData> {
  ProfileViewProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileViewProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileViewHash();

  @$internal
  @override
  $FutureProviderElement<ProfileViewData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ProfileViewData> create(Ref ref) {
    return profileView(ref);
  }
}

String _$profileViewHash() => r'd4f832b5e70c3669fbad3c1beb0b672dbb3b2555';
