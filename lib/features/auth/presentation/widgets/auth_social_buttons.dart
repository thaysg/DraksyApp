import 'package:flutter/material.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/extensions/spacing.dart';
import 'social_auth_button.dart';

class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({required this.onGoogleSignIn, super.key});

  final VoidCallback onGoogleSignIn;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: SocialAuthButton(
              icon: Icons.apple,
              onPressed: () {
                // UI ONLY
              },
            ),
          ),
          16.widthBox,
          Expanded(
            child: SocialAuthButton(
              assetIcon: AppIcons.google,
              onPressed: onGoogleSignIn,
            ),
          ),
        ],
      );
}
