import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../theme/app_colors.dart';

part 'image_picker_service.g.dart';

/// Service for picking and cropping images.
class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the specified [source].
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth = 1024,
    double? maxHeight = 1024,
    int? imageQuality = 85,
  }) =>
      _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

  /// Crops an image from the specified [sourcePath].
  Future<CroppedFile?> cropImage({
    required String sourcePath,
    required String title,
    required String doneButtonTitle,
    required String cancelButtonTitle,
    String? resetButtonTitle,
  }) =>
      ImageCropper().cropImage(
        sourcePath: sourcePath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: AppColors.primaryAppColor,
            toolbarWidgetColor: AppColors.backgroundLight,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            activeControlsWidgetColor: AppColors.primaryAppColor,
            cropStyle: CropStyle.circle,
          ),
          IOSUiSettings(
            title: title,
            aspectRatioLockEnabled: true,
            doneButtonTitle: doneButtonTitle,
            cancelButtonTitle: cancelButtonTitle,
            cropStyle: CropStyle.circle,
          ),
        ],
      );
}

@riverpod
ImagePickerService imagePickerService(Ref ref) => ImagePickerService();
