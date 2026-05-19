import 'package:draksy/core/utils/pagination/paginated_state.dart';
import 'package:draksy/features/lessons/domain/entities/lesson_node_state.dart';
import 'package:draksy/features/lessons/domain/entities/lesson_unit_data.dart';
import 'package:draksy/features/lessons/presentation/models/lessons_path_view_data.dart';
import 'package:draksy/features/lessons/presentation/pages/lessons_path_page.dart';
import 'package:draksy/features/lessons/presentation/providers/lesson_path_provider.dart';
import 'package:draksy/features/lessons/presentation/widgets/lesson_path_node.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

class _MockSelectedOptionMinus1 extends SelectedOption {
  @override
  int build() => -1;
}

class _MockLessonPathUnitsFromData extends LessonPathUnits {
  @override
  PaginatedState<LessonUnitData> build(String levelName) =>
      PaginatedState<LessonUnitData>.initial().copyWith(
        items: const [
          LessonUnitData(
            id: '1',
            lessonId: 'l1',
            unitNumber: 1,
            state: LessonNodeState.completed,
          ),
          LessonUnitData(
            id: '2',
            lessonId: 'l2',
            unitNumber: 2,
            state: LessonNodeState.current,
          ),
          LessonUnitData(
            id: '3',
            lessonId: 'l3',
            unitNumber: 3,
            state: LessonNodeState.locked,
          ),
        ],
        isLoading: false,
      );
}

void main() {
  late MockGoRouter mockRouter;

  const tCategoryTitle = 'Test Category';

  const tData = LessonsPathViewData(
    categoryTitle: tCategoryTitle,
    units: [],
    progress: 0.5,
    currentUnits: 1,
    totalUnits: 2,
    nextUnitNumber: 2,
    levelName: 'beginner',
  );

  setUp(() {
    mockRouter = MockGoRouter();
  });

  Widget createWidgetUnderTest() => ProviderScope(
        overrides: [
          lessonsPathViewProvider(tCategoryTitle).overrideWith(
            (ref) => tData,
          ),
          selectedOptionProvider.overrideWith(_MockSelectedOptionMinus1.new),
          lessonPathUnitsProvider
              .overrideWith(_MockLessonPathUnitsFromData.new),
        ],
        child: ScreenUtilInit(
          designSize: const Size(500, 1000),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: InheritedGoRouter(
              goRouter: mockRouter,
              child: const LessonsPathPage(categoryTitle: tCategoryTitle),
            ),
          ),
        ),
      );

  // LessonPathCurrentNode usa AnimationController..repeat() (animação infinita)
  // e LessonPathTrail usa TweenAnimationBuilder de 1500ms.
  // pumpAndSettle nunca termina — usamos pump(Duration) explícito.
  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(seconds: 3));
  }

  group('LessonsPathPage', () {
    testWidgets('renders category title', (tester) async {
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpPage(tester);

      expect(find.text(tCategoryTitle), findsOneWidget);
    });

    testWidgets('renders progress percentage', (tester) async {
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpPage(tester);

      // progress: 0.5 → 50%
      expect(find.text('50%'), findsWidgets);
    });

    testWidgets('renders lesson path nodes', (tester) async {
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpPage(tester);

      expect(find.byType(LessonPathNode), findsWidgets);
    });

    testWidgets('renders back button', (tester) async {
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpPage(tester);

      expect(find.byIcon(Icons.chevron_left_rounded), findsOneWidget);
    });

    testWidgets('renders next unit info', (tester) async {
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpPage(tester);

      // nextUnitNumber é 2 — aparece no progress card
      expect(find.textContaining('2'), findsWidgets);
    });
  });
}
