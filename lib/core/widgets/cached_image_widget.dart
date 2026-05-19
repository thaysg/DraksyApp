import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_images.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    required this.imageUrl,
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.fill,
    this.errorColor,
    this.color,
    this.errorImage = AppImages.logo,
    this.errorHeight,
    this.errorWidth,
    this.errorFit,
  });
  final String imageUrl;
  final double? errorHeight;
  final double? errorWidth;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? errorColor;
  final Color? color;
  final String errorImage;
  final BoxFit? errorFit;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        height: height,
        width: width,
        color: color,
        errorWidget: (context, url, error) => Image.asset(
          errorImage,
          color: errorColor,
          width: errorWidth,
          height: errorHeight,
          fit: errorFit,
        ),
      );
}
