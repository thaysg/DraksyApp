import 'package:draksy/core/utils/models/pagination_request.dart';
import 'package:draksy/core/utils/models/pagination_response.dart';
import 'package:draksy/features/lessons/data/models/unit_model.dart';
import 'package:draksy/features/lessons/data/providers/lesson_repository_providers.dart';
import 'package:draksy/features/lessons/domain/entities/lesson_node_state.dart';
import 'package:draksy/features/lessons/domain/repositories/lesson_repository.dart';
import 'package:draksy/features/lessons/presentation/providers/lesson_path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockLessonRepository extends Mock implements LessonRepository {}

class FakePaginationRequest extends Fake implements PaginationRequest {}

void main() {
  late MockLessonRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakePaginationRequest());
  });

  setUp(() {
    mockRepository = MockLessonRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        lessonRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  // ─────────────────────────────────────────────
  // SelectedOption
  // ─────────────────────────────────────────────
  group('SelectedOption', () {
    test('initial state is -1 (nothing selected)', () {
      final container = makeContainer();
      expect(container.read(selectedOptionProvider), equals(-1));
    });

    test('select = 2 changes state to 2', () {
      final container = makeContainer();
      container.read(selectedOptionProvider.notifier).select = 2;
      expect(container.read(selectedOptionProvider), equals(2));
    });

    test('clear() resets state to -1', () {
      final container = makeContainer();
      container.read(selectedOptionProvider.notifier).select = 2;
      container.read(selectedOptionProvider.notifier).clear();
      expect(container.read(selectedOptionProvider), equals(-1));
    });

    test('select = 0 is valid (index zero)', () {
      final container = makeContainer();
      container.read(selectedOptionProvider.notifier).select = 0;
      expect(container.read(selectedOptionProvider), equals(0));
    });

    test('select getter returns current state', () {
      final container = makeContainer();
      container.read(selectedOptionProvider.notifier).select = 3;
      expect(container.read(selectedOptionProvider.notifier).select, equals(3));
    });
  });

  // ─────────────────────────────────────────────
  // LessonPathUnits
  // ─────────────────────────────────────────────
  group('LessonPathUnits', () {
    test('build() returns units from repository', () async {
      final container = makeContainer();
      const tUnits = [
        UnitModel(
          id: '1',
          orderIndex: 1,
          title: 'Unit 1',
          description: '',
          difficulty: 'basic',
          languageTarget: 'en',
          lessonId: 'l1',
        ),
        UnitModel(
          id: '2',
          orderIndex: 2,
          title: 'Unit 2',
          description: '',
          difficulty: 'basic',
          languageTarget: 'en',
          lessonId: 'l2',
        ),
      ];

      when(() => mockRepository.getUnitsByDifficulty(
            difficulty: any(named: 'difficulty'),
            request: any(named: 'request'),
          )).thenAnswer((_) async => StrautilsResponse.success(
            const PaginationResponse(
              items: tUnits,
              totalCount: 2,
              currentPage: 1,
              lastPage: 1,
            ),
          ));
      when(() => mockRepository.getUnitsProgress(any()))
          .thenAnswer((_) async => StrautilsResponse.success({}));

      // Iniciar o provider e carregar os dados iniciais
      await container
          .read(lessonPathUnitsProvider('basic').notifier)
          .loadInitial();

      final state = container.read(lessonPathUnitsProvider('basic'));
      final units = state.items;

      expect(units.length, equals(2));
      expect(units[0].unitNumber, equals(1));
      expect(units[0].state,
          equals(LessonNodeState.current)); // basic & orderIndex 1
      expect(units[1].state, equals(LessonNodeState.locked));
    });

    test('randomDragon returns a non-empty string', () {
      final container = makeContainer();
      final dragon = container.read(randomDragonProvider);
      expect(dragon, isNotEmpty);
    });
  });
}
