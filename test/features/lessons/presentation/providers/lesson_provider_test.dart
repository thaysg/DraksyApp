import 'package:draksy/features/lessons/data/models/node_content_model.dart';
import 'package:draksy/features/lessons/data/models/node_model.dart';
import 'package:draksy/features/lessons/domain/providers/lesson_usecase_providers.dart';
import 'package:draksy/features/lessons/domain/usecases/get_lesson_nodes.dart';
import 'package:draksy/features/lessons/presentation/providers/lesson_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:strawti_utils/strawti_utils.dart';

class MockGetLessonNodes extends Mock implements GetLessonNodes {}

void main() {
  late MockGetLessonNodes mockGetLessonNodes;

  setUp(() {
    mockGetLessonNodes = MockGetLessonNodes();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        getLessonNodesProvider.overrideWithValue(mockGetLessonNodes),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  const tNode = NodeModel(
    id: '1',
    lessonId: 'lesson1',
    orderIndex: 0,
    type: 'explanation',
    content: ExplanationContentModel(
      phrase: 'Hola',
      translation: 'Olá',
      contextSentence: 'Hola means Hello',
      grammarTip: 'Casual greeting',
      imageKey: 'dragon_greeting',
    ),
  );

  test('lessonNodesProvider returns nodes on success', () async {
    final container = makeContainer();
    const tLessonId = 'lesson1';
    final tNodes = [tNode];

    when(() => mockGetLessonNodes(tLessonId))
        .thenAnswer((_) async => StrautilsResponse.success(tNodes));

    final result = await container.read(lessonNodesProvider(tLessonId).future);

    expect(result, tNodes);
    verify(() => mockGetLessonNodes(tLessonId)).called(1);
  });

  group('LessonSession', () {
    test('initial state is correct', () {
      final container = makeContainer();
      final state = container.read(lessonSessionProvider);

      expect(state.currentIndex, 0);
      expect(state.selectedAnswer, isNull);
      expect(state.dragonImageKey, isNull);
      expect(state.totalXp, 0);
    });

    test('selectAnswer updates state correctly on correct answer', () {
      final container = makeContainer();
      container.read(lessonSessionProvider.notifier).selectAnswer(1, 1);

      final state = container.read(lessonSessionProvider);
      expect(state.selectedAnswer, 1);
      expect(state.dragonImageKey, 'dragon_celebrating');
      expect(state.totalXp, 10);
    });

    test('selectAnswer updates state correctly on wrong answer', () {
      final container = makeContainer();
      container.read(lessonSessionProvider.notifier).selectAnswer(0, 1);
      final state = container.read(lessonSessionProvider);
      expect(state.selectedAnswer, 0);
      expect(state.dragonImageKey, 'dragon_sad');
      expect(state.totalXp, 0);
    });

    test('advance increments currentIndex and resets fields', () {
      final container = makeContainer();
      container.read(lessonSessionProvider.notifier)
        ..init(10, 5) // Set 10 nodes
        ..selectAnswer(1, 1)
        ..advance();

      final state = container.read(lessonSessionProvider);
      expect(state.currentIndex, 1);
      expect(state.selectedAnswer, isNull);
      expect(state.dragonImageKey, isNull);
    });

    test('advance preserves totalXp from previous answers', () {
      final container = makeContainer();
      container.read(lessonSessionProvider.notifier)
        ..init(10, 5) // Set 10 nodes
        ..selectAnswer(1, 1)
        ..advance();

      final state = container.read(lessonSessionProvider);
      expect(state.totalXp, 10);
    });
  });
}
