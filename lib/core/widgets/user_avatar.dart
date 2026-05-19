import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_images.dart';
import '../theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.photoUrl,
    this.radius = 25,
    this.borderColor,
    this.borderWidth = 0,
    super.key,
  });

  final String photoUrl;
  final double radius;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl.isNotEmpty && photoUrl.startsWith('http');

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: hasPhoto
          ? CachedNetworkImage(
              imageUrl: photoUrl,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: radius.r,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircleAvatar(
                radius: radius.r,
                backgroundColor: AppColors.surfaceContainerHighest(context),
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) => _buildLogoFallback(),
            )
          : _buildLogoFallback(),
    );
  }

  Widget _buildLogoFallback() => CircleAvatar(
        radius: radius.r,
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(radius * 0.4.r),
          child: Image.asset(
            AppImages.logo,
            fit: BoxFit.contain,
          ),
        ),
      );
}
