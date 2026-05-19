import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../models/edit_profile_view_data.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/edit_profile_header.dart';

class EditProfileMobileView extends StatelessWidget {
  const EditProfileMobileView({
    required this.data,
    required this.onSave,
    required this.isSaving,
    super.key,
  });

  final EditProfileViewData data;
  final OnSaveCallback onSave;
  final bool isSaving;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditProfileHeader(
              displayName: data.displayName,
              username: data.username,
              photoUrl: data.photoUrl,
              level: data.level,
            ),
            20.heightBox,
            EditProfileForm(
              displayName: data.displayName,
              username: data.username,
              email: data.email,
              bio: data.bio,
              photoUrl: data.photoUrl,
              onSave: onSave,
              isSaving: isSaving,
            ),
            100.heightBox,
          ],
        ),
      );
}
