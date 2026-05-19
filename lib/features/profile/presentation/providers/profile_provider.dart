import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../models/profile_view_data.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfilePreviewPhoto extends _$ProfilePreviewPhoto {
  @override
  String? build() => null;

  String? get url => state;
  set url(String? url) => state = url;
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => ref.read(profileProvider.notifier).logout(),
    );
    if (ref.mounted) {
      state = result;
    }
  }

  Future<void> deleteAccount() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => ref.read(profileProvider.notifier).deleteAccount(),
    );
    if (ref.mounted) {
      state = result;
    }
  }

  Future<void> confirmAndDeleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteAccountTitle),
        content: Text(context.l10n.deleteAccountMessage),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && ref.mounted) {
      await deleteAccount();
    }
  }

  Future<void> editProfile({
    required String displayName,
    required String photoUrl,
    required String bio,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => ref.read(profileProvider.notifier).editProfile(
            displayName: displayName,
            photoUrl: photoUrl,
            bio: bio,
          ),
    );
    if (ref.mounted) {
      state = result;
    }
  }
}

@riverpod
class AvatarUploading extends _$AvatarUploading {
  @override
  bool build() => false;

  bool get isUploading => state;
  set isUploading(bool value) => state = value;
}

@riverpod
class Profile extends _$Profile {
  @override
  Stream<User?> build() {
    final authRepository = ref.watch(authRepositoryProvider);
    return authRepository.userChanges;
  }

  Future<void> logout() async {
    await ref.read(authProvider.notifier).logout();
  }

  Future<void> deleteAccount() async {
    await ref.read(authProvider.notifier).deleteAccount();
  }

  Future<void> editProfile({
    required String displayName,
    required String photoUrl,
    required String bio,
  }) async {
    await ref.read(authRepositoryProvider).updateProfile(
          displayName: displayName,
          photoUrl: photoUrl,
          bio: bio,
        );
  }

  Future<String> uploadAvatar({
    required String userId,
    required Uint8List fileBytes,
    required String fileName,
    String? mimeType,
  }) async {
    final response = await ref.read(authRepositoryProvider).uploadAvatar(
          userId: userId,
          fileBytes: fileBytes,
          fileName: fileName,
          mimeType: mimeType,
        );

    if (response.error) {
      throw Exception(response.message);
    }

    return response.data!;
  }

  /// Picks an image from [source], crops it, and uploads it as avatar.
  /// Returns the public URL of the uploaded image.
  Future<String?> pickAndUploadAvatar(
    ImageSource source, {
    required String cropTitle,
    required String finishButtonTitle,
    required String cancelButtonTitle,
    String? resetButtonTitle,
  }) async {
    final picker = ref.read(imagePickerServiceProvider);
    final image = await picker.pickImage(source: source);

    if (image == null) {
      return null;
    }

    final croppedFile = await picker.cropImage(
      sourcePath: image.path,
      title: cropTitle,
      doneButtonTitle: finishButtonTitle,
      cancelButtonTitle: cancelButtonTitle,
      resetButtonTitle: resetButtonTitle,
    );

    if (croppedFile == null) {
      return null;
    }

    final user = currentUser;
    if (user == null) {
      return null;
    }

    final bytes = await croppedFile.readAsBytes();

    if (!ref.mounted) {
      return null;
    }
    ref.read(avatarUploadingProvider.notifier).isUploading = true;

    try {
      final url = await uploadAvatar(
        userId: user.id,
        fileBytes: bytes,
        fileName: image.name,
        mimeType: image.mimeType,
      );
      return url;
    } finally {
      if (ref.mounted) {
        ref.read(avatarUploadingProvider.notifier).isUploading = false;
      }
    }
  }

  User? get currentUser {
    final asyncValue = ref.read(authProvider);
    return asyncValue.maybeWhen(
      data: (user) => user,
      orElse: () => null,
    );
  }
}

@riverpod
Future<ProfileViewData> profileView(Ref ref) async {
  final user = await ref.watch(profileProvider.future);

  // In a real app, stats would be fetched from a repository.
  // Using values from the original views as initial single source of truth.
  return ProfileViewData(
    userName: user?.displayName ?? 'Learner',
    userTag: '@${(user?.displayName ?? 'learner').toSnakeCase()}',
    email: user?.email ?? '',
    photo: user?.photoURL ?? '',
    bio: user?.bio ?? '',
    level: 12,
    totalXp: '14,250',
    streak: 42,
    lessons: 128,
    accuracy: '96%',
    currentXp: 750,
    maxXp: 1000,
    badges: const [
      ProfileBadgeData(
        title: 'Champion',
        subtitle: 'Top 10 in Diamond League',
        icon: Icons.emoji_events_rounded,
        color: AppColors.gold,
      ),
      ProfileBadgeData(
        title: 'On Fire',
        subtitle: '30 Day Streak',
        icon: Icons.local_fire_department_rounded,
        color: AppColors.rpgOrange,
      ),
      ProfileBadgeData(
        title: 'Master',
        subtitle: 'Level 20 reached',
        icon: Icons.lock_rounded,
        color: AppColors.textSecondaryLight,
      ),
    ],
    languages: const [
      ProfileLanguageData(
        title: 'English',
        subtitle: 'Intermediate • 45%',
        icon: Icons.language_rounded,
        color: AppColors.primaryAppColor,
      ),
      ProfileLanguageData(
        title: 'Spanish',
        subtitle: 'Beginner • 12%',
        icon: Icons.language_rounded,
        color: AppColors.secondaryLight,
      ),
    ],
  );
}
