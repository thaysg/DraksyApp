import 'dart:typed_data';

import 'package:draksy/core/errors/exceptions.dart';
import 'package:draksy/core/local/local_data_base.dart';
import 'package:draksy/core/services/storage_service.dart';
import 'package:draksy/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:draksy/features/auth/data/models/user_model.dart';
import 'package:draksy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockLocalDataBase extends Mock implements LocalDataBase {}

class MockStorageService extends Mock implements StorageService {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockLocalDataBase mockLocalDb;
  late MockStorageService mockStorageService;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDb = MockLocalDataBase();
    mockStorageService = MockStorageService();
    repository = AuthRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDb,
      mockStorageService,
    );
  });

  final tUserModel = UserModel(
    id: '123',
    email: 'test@example.com',
    displayName: 'Test User',
    photoURL: 'https://example.com/photo.jpg',
    createdAt: DateTime(2024),
  );

  group('signInWithGoogle', () {
    test(
        'should return success response when remote data source call '
        'is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.signInWithGoogle())
          .thenAnswer((_) async => tUserModel);

      // act
      final result = await repository.signInWithGoogle();

      // assert
      expect(result.success, isTrue);
      expect(result.data, tUserModel);
      verify(() => mockRemoteDataSource.signInWithGoogle());
    });

    test(
        'should return error response when remote data source throws '
        'AuthException', () async {
      // arrange
      when(() => mockRemoteDataSource.signInWithGoogle())
          .thenThrow(const AuthException(message: 'Sign in failed'));

      // act
      final result = await repository.signInWithGoogle();

      // assert
      expect(result.error, isTrue);
      expect(result.message, 'Sign in failed');
    });
  });

  group('signInWithEmailAndPassword', () {
    test(
        'should return success response when remote data source call is'
        ' successful', () async {
      when(() => mockRemoteDataSource.signInWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => tUserModel);

      final result = await repository.signInWithEmailAndPassword(
          'test@example.com', 'password');

      expect(result.success, isTrue);
      expect(result.data, tUserModel);
      verify(() => mockRemoteDataSource.signInWithEmailAndPassword(
          'test@example.com', 'password'));
    });
  });

  group('signUpWithEmailAndPassword', () {
    test(
        'should return success response when remote data source call is'
        ' successful', () async {
      when(() => mockRemoteDataSource.signUpWithEmailAndPassword(
          any(), any(), any())).thenAnswer((_) async => tUserModel);

      final result = await repository.signUpWithEmailAndPassword(
          'test@example.com', 'password', 'Test User');

      expect(result.success, isTrue);
      expect(result.data, tUserModel);
      verify(() => mockRemoteDataSource.signUpWithEmailAndPassword(
          'test@example.com', 'password', 'Test User'));
    });
  });

  group('signOut', () {
    test('should call remote data source signOut and clear local database',
        () async {
      // arrange
      when(() => mockRemoteDataSource.signOut()).thenAnswer((_) async => {});
      when(() => mockLocalDb.clearUserData()).thenAnswer((_) async => {});

      // act
      final result = await repository.signOut();

      // assert
      expect(result.success, isTrue);
      verify(() => mockRemoteDataSource.signOut()).called(1);
      verify(() => mockLocalDb.clearUserData()).called(1);
    });

    test('should return error response when remote data source throws',
        () async {
      // arrange
      when(() => mockRemoteDataSource.signOut()).thenThrow(Exception('Error'));

      // act
      final result = await repository.signOut();

      // assert
      expect(result.error, isTrue);
      verify(() => mockRemoteDataSource.signOut()).called(1);
      verifyNever(() => mockLocalDb.clearUserData());
    });
  });

  group('getCurrentUser', () {
    test('should return user from remote data source', () async {
      when(() => mockRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => tUserModel);

      final result = await repository.getCurrentUser();

      expect(result, tUserModel);
      verify(() => mockRemoteDataSource.getCurrentUser());
    });
  });

  group('updateProfile', () {
    test(
        'should return success response when remote data source call is'
        ' successful', () async {
      when(() => mockRemoteDataSource.updateProfile(
            displayName: any(named: 'displayName'),
            photoUrl: any(named: 'photoUrl'),
            bio: any(named: 'bio'),
          )).thenAnswer((_) async => {});

      final result = await repository.updateProfile(
        displayName: 'New Name',
        photoUrl: 'https://example.com/new.jpg',
        bio: 'New bio',
      );

      expect(result.success, isTrue);
      verify(() => mockRemoteDataSource.updateProfile(
            displayName: 'New Name',
            photoUrl: 'https://example.com/new.jpg',
            bio: 'New bio',
          ));
    });
  });

  group('uploadAvatar', () {
    test(
        'should return success response when storage service call '
        'is successful', () async {
      // arrange
      const tUrl = 'https://example.com/avatar.jpg';
      final tBytes = Uint8List(0);
      when(() => mockStorageService.uploadAvatar(
            userId: any(named: 'userId'),
            fileBytes: any(named: 'fileBytes'),
            fileName: any(named: 'fileName'),
            mimeType: any(named: 'mimeType'),
          )).thenAnswer((_) async => tUrl);

      // act
      final result = await repository.uploadAvatar(
        userId: '123',
        fileBytes: tBytes,
        fileName: 'avatar.jpg',
      );

      // assert
      expect(result.success, isTrue);
      expect(result.data, tUrl);
      verify(() => mockStorageService.uploadAvatar(
            userId: '123',
            fileBytes: tBytes,
            fileName: 'avatar.jpg',
          ));
    });

    test('should return error response when storage service throws', () async {
      // arrange
      when(() => mockStorageService.uploadAvatar(
            userId: any(named: 'userId'),
            fileBytes: any(named: 'fileBytes'),
            fileName: any(named: 'fileName'),
            mimeType: any(named: 'mimeType'),
          )).thenThrow(const StorageException(message: 'Upload failed'));

      // act
      final result = await repository.uploadAvatar(
        userId: '123',
        fileBytes: Uint8List(0),
        fileName: 'avatar.jpg',
      );

      // assert
      expect(result.error, isTrue);
      expect(result.message, 'Upload failed');
    });
  });

  group('deleteAccount', () {
    test(
        'should call remote data source deleteAccount and clear local database',
        () async {
      // arrange
      when(() => mockRemoteDataSource.deleteAccount())
          .thenAnswer((_) async => {});
      when(() => mockLocalDb.clearUserData()).thenAnswer((_) async => {});

      // act
      final result = await repository.deleteAccount();

      // assert
      expect(result.success, isTrue);
      verify(() => mockRemoteDataSource.deleteAccount()).called(1);
      verify(() => mockLocalDb.clearUserData()).called(1);
    });

    test('should return error response when remote data source throws',
        () async {
      // arrange
      when(() => mockRemoteDataSource.deleteAccount())
          .thenThrow(Exception('Error'));

      // act
      final result = await repository.deleteAccount();

      // assert
      expect(result.error, isTrue);
      verify(() => mockRemoteDataSource.deleteAccount()).called(1);
      verifyNever(() => mockLocalDb.clearUserData());
    });
  });
}
