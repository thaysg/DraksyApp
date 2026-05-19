import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

/// Mock implementation of [StorageService] for handling file storage operations
///  in the portfolio.
class StorageService {
  /// Uploads user avatar (Mock).
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List fileBytes,
    required String fileName,
    String? mimeType,
  }) async => 'https://ui-avatars.com/api/?name=User&background=random';
}

@riverpod
StorageService storageService(Ref ref) => StorageService();
