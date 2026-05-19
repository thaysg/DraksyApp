import 'package:draksy/core/local/hive_cache_keys.dart';
import 'package:draksy/core/local/local_data_base.dart';
import 'package:draksy/features/lessons/data/datasources/lesson_local_data_source_impl.dart';
import 'package:draksy/features/lessons/data/models/lesson_progress_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataBase extends Mock implements LocalDataBase {}

void main() {
  late LessonLocalDataSourceImpl dataSource;
  late MockLocalDataBase mockLocalDb;

  final tModel = LessonProgressModel(
    unitId: 'unit1',
    nodeId: 'node1',
    isCompleted: true,
    xpEarned: 50,
    completedAt: '2024-01-01T00:00:00.000Z',
  );

  final tExpectedKey = HiveCacheKeys.lessonProgressKey('unit1', 'node1');

  setUp(() {
    mockLocalDb = MockLocalDataBase();
    dataSource = LessonLocalDataSourceImpl(mockLocalDb);
  });

  // ─────────────────────────────────────────────
  // getProgress
  // ─────────────────────────────────────────────
  group('getProgress', () {
    test('returns model when localDb.read returns a value', () async {
      when(() => mockLocalDb.read<LessonProgressModel>(any()))
          .thenAnswer((_) async => tModel);

      final result = await dataSource.getProgress(
        unitId: 'unit1',
        nodeId: 'node1',
      );

      expect(result, tModel);
    });

    test('returns null when localDb.read returns null', () async {
      when(() => mockLocalDb.read<LessonProgressModel>(any()))
          .thenAnswer((_) async => null);

      final result = await dataSource.getProgress(
        unitId: 'unit1',
        nodeId: 'node1',
      );

      expect(result, isNull);
    });

    test('calls localDb.read with the correct composite key', () async {
      when(() => mockLocalDb.read<LessonProgressModel>(any()))
          .thenAnswer((_) async => null);

      await dataSource.getProgress(unitId: 'unit1', nodeId: 'node1');

      verify(() => mockLocalDb.read<LessonProgressModel>(tExpectedKey))
          .called(1);
    });
  });

  // ─────────────────────────────────────────────
  // saveProgress
  // ─────────────────────────────────────────────
  group('saveProgress', () {
    test('calls localDb.write with the correct key and model', () async {
      when(() => mockLocalDb.write(any(), any())).thenAnswer((_) async {});

      await dataSource.saveProgress(tModel);

      verify(() => mockLocalDb.write(tExpectedKey, tModel)).called(1);
    });

    test('key is derived from model unitId and nodeId', () async {
      when(() => mockLocalDb.write(any(), any())).thenAnswer((_) async {});

      final customModel = LessonProgressModel(
        unitId: 'unitX',
        nodeId: 'nodeY',
        isCompleted: false,
        xpEarned: 0,
        completedAt: null,
      );

      await dataSource.saveProgress(customModel);

      final expectedKey = HiveCacheKeys.lessonProgressKey('unitX', 'nodeY');
      verify(() => mockLocalDb.write(expectedKey, customModel)).called(1);
    });
  });

  // ─────────────────────────────────────────────
  // getAllProgress
  // ─────────────────────────────────────────────
  group('getAllProgress', () {
    test('returns list of models when localDb.readAll returns values',
        () async {
      final tList = [tModel];
      when(() => mockLocalDb.readAll<LessonProgressModel>(any()))
          .thenAnswer((_) async => tList);

      final result = await dataSource.getAllProgress();

      expect(result, tList);
    });

    test('returns empty list when localDb.readAll returns empty list',
        () async {
      when(() => mockLocalDb.readAll<LessonProgressModel>(any()))
          .thenAnswer((_) async => []);

      final result = await dataSource.getAllProgress();

      expect(result, isEmpty);
    });

    test('calls localDb.readAll with lessonProgressBox key', () async {
      when(() => mockLocalDb.readAll<LessonProgressModel>(any()))
          .thenAnswer((_) async => []);

      await dataSource.getAllProgress();

      verify(
        () => mockLocalDb.readAll<LessonProgressModel>(
          HiveCacheKeys.lessonProgressBox,
        ),
      ).called(1);
    });
  });

  // ─────────────────────────────────────────────
  // clearAll
  // ─────────────────────────────────────────────
  group('clearAll', () {
    test('calls localDb.clearUserData', () async {
      when(() => mockLocalDb.clearUserData()).thenAnswer((_) async {});

      await dataSource.clearAll();

      verify(() => mockLocalDb.clearUserData()).called(1);
    });

    test('completes without error', () async {
      when(() => mockLocalDb.clearUserData()).thenAnswer((_) async {});

      expect(() => dataSource.clearAll(), returnsNormally);
    });
  });
}
