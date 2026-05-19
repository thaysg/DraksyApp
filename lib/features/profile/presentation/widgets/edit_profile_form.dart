import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../providers/profile_provider.dart';
import 'about_you_card.dart';
import 'avatar_source_sheet.dart';
import 'profile_photo_card.dart';
import 'text_fields_card.dart';

typedef OnSaveCallback = Future<void> Function({
  required String displayName,
  required String photoUrl,
  required String bio,
});

class EditProfileForm extends ConsumerStatefulWidget {
  const EditProfileForm({
    required this.displayName,
    required this.username,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.onSave,
    required this.isSaving,
    super.key,
  });

  final String displayName;
  final String username;
  final String email;
  final String bio;
  final String photoUrl;
  final OnSaveCallback onSave;
  final bool isSaving;

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _bioController;

  late String _selectedPhotoUrl;

  // Preset avatars — second slot is the "upload" option (camera icon)
  static const List<String> _presetAvatars = [
    '', // placeholder = current user photo (handled below)
    '__camera__',
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=150&h=150&fit=crop',
    'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=150&h=150&fit=crop',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=150&h=150&fit=crop',
  ];

  bool get _hasChanges =>
      _displayNameController.text != widget.displayName ||
      _usernameController.text != widget.username ||
      _emailController.text != widget.email ||
      _bioController.text != widget.bio ||
      _selectedPhotoUrl != widget.photoUrl;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(text: widget.displayName);
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _bioController = TextEditingController(text: widget.bio);
    _selectedPhotoUrl = widget.photoUrl;

    _displayNameController.addListener(() => setState(() {}));
    _usernameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _bioController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUploading = ref.watch(avatarUploadingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Text fields card ─────────────────────────────────────────
        TextFieldCards(
          displayNameController: _displayNameController,
          usernameController: _usernameController,
          emailController: _emailController,
        ),

        24.heightBox,

        // ── Profile photo card ───────────────────────────────────────
        CustomDecoratedBox(
          opacity: 1,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.profilePhoto,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.textSecondary(context),
                  fontWeight: FontWeight.w700,
                ),
              ),
              14.heightBox,
              SizedBox(
                height: 76.r,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _presetAvatars.length,
                  itemBuilder: (context, index) {
                    final isPreset =
                        _presetAvatars.sublist(2).contains(_selectedPhotoUrl);
                    final avatarUrl = index == 0
                        ? (isPreset ? widget.photoUrl : _selectedPhotoUrl)
                        : _presetAvatars[index];
                    final isCamera = avatarUrl == '__camera__';
                    final isSelected =
                        !isCamera && _selectedPhotoUrl == avatarUrl;

                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: GestureDetector(
                        onTap: isCamera
                            ? () => AvatarSourceSheet.show(
                                  context,
                                  onSourceSelected: (source) async {
                                    final url = await ref
                                        .read(profileProvider.notifier)
                                        .pickAndUploadAvatar(
                                          source,
                                          cropTitle: context.l10n.adjustPhoto,
                                          finishButtonTitle:
                                              context.l10n.finish,
                                          cancelButtonTitle:
                                              context.l10n.cancel,
                                          resetButtonTitle: context.l10n.reset,
                                        );
                                    if (url != null && mounted) {
                                      setState(() => _selectedPhotoUrl = url);
                                      ref
                                          .read(
                                            profilePreviewPhotoProvider
                                                .notifier,
                                          )
                                          .url = url;
                                    }
                                  },
                                )
                            : () {
                                setState(() => _selectedPhotoUrl = avatarUrl);
                                ref
                                    .read(profilePreviewPhotoProvider.notifier)
                                    .url = avatarUrl;
                              },
                        child: ProfilePhotoCard(
                          isSelected: isSelected,
                          isCamera: isCamera,
                          isUploading: isUploading,
                          avatarUrl: avatarUrl,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        24.heightBox,

        // ── About You card ───────────────────────────────────────────
        AboutYouCard(bioController: _bioController),

        24.heightBox,

        // ── Save button ──────────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: context.l10n.saveChanges,
            onPressed: _hasChanges && !widget.isSaving && !isUploading
                ? () => widget.onSave(
                      displayName: _displayNameController.text.trim(),
                      photoUrl: _selectedPhotoUrl,
                      bio: _bioController.text.trim(),
                    )
                : null,
            type: ButtonType.elevated,
            isLoading: widget.isSaving,
            height: 56.h,
          ),
        ),
      ],
    );
  }
}
