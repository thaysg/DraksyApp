import 'dart:async';

import 'package:draksy/core/utils/pagination/paginated_state.dart';
import 'package:draksy/core/widgets/xp_bar.dart';
import 'package:draksy/features/lessons/domain/entities/lesson_node_state.dart';
import 'package:draksy/features/lessons/domain/entities/lesson_unit_data.dart';
import 'package:draksy/features/lessons/presentation/models/lesson_detail_view_data.dart';
import 'package:draksy/features/lessons/presentation/pages/lesson_detail_page.dart';
import 'package:draksy/features/lessons/presentation/providers/lesson_detail_provider.dart';
import 'package:draksy/features/lessons/presentation/providers/lesson_path_provider.dart';
import 'package:draksy/features/lessons/presentation/widgets/check_button.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

// Fake asset bundle que:
// 1. Retorna um mapa vazio codificado em StandardMessageCodec para o
//    AssetManifest.bin (evita UnimplementedError em loadStructuredBinaryData)
// 2. Retorna bytes de um PNG 1×1 transparente para qualquer chave de imagem
class _FakeAssetBundle extends CachingAssetBundle {
  static const _kTransparentPng = <int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x62,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ];

  @override
  Future<ByteData> load(String key) async =>
      Uint8List.fromList(_kTransparentPng).buffer.asByteData();

  @override
  Future<T> loadStructuredBinaryData<T>(
    String key,
    FutureOr<T> Function(ByteData data) parser,
  ) async {
    // Codifica um mapa vazio via StandardMessageCodec.
    // AssetManifest.loadFromAssetBundle usa esse método e espera um mapa;
    // retornar vazio faz o AssetImage cair no fallback de escala 1.0.
    final encoded =
        const StandardMessageCodec().encodeMessage(<Object, Object>{})!;
    return parser(encoded);
  }
}

class MockGoRouter extends Mock implements GoRouter {}

class _MockSelectedOptionMinus1 extends SelectedOption {
  @override
  int build() => -1;
}

class _MockLessonPathUnitsSingle extends LessonPathUnits {
  @override
  PaginatedState<LessonUnitData> build(String levelName) =>
      PaginatedState<LessonUnitData>.initial().copyWith(
        items: const [
          LessonUnitData(
            id: '1',
            lessonId: 'l1',
            unitNumber: 1,
            state: LessonNodeState.current,
          ),
        ],
        isLoading: false,
      );
}

void main() {
  late MockGoRouter mockRouter;

  const tData = LessonDetailViewData(
    title: 'Greetings & Intros',
    meaningTitle: 'Hola means Hello in Spanish',
    targetWord: 'Hello',
    description: 'Use this when greeting someone.',
    dragonImage: '',
    exerciseTitle: 'How do you say Hello?',
    options: [
      LessonOptionData(label: 'Adiós', emoji: '👋'),
      LessonOptionData(label: 'Hola', emoji: '🧑'),
      LessonOptionData(label: 'Gracias', emoji: '🙏'),
      LessonOptionData(label: 'Noches', emoji: '🌙'),
    ],
    selectedOptionIndex: -1,
    currentXp: 40,
    maxXp: 100,
    lives: 5,
  );

  setUp(() {
    mockRouter = MockGoRouter();
  });

  Widget createWidgetUnderTest() => DefaultAssetBundle(
        bundle: _FakeAssetBundle(),
        child: ProviderScope(
          overrides: [
            lessonDetailViewProvider.overrideWith((ref) => tData),
            selectedOptionProvider.overrideWith(_MockSelectedOptionMinus1.new),
            lessonPathUnitsProvider
                .overrideWith(_MockLessonPathUnitsSingle.new),
          ],
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) => MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: InheritedGoRouter(
                goRouter: mockRouter,
                child: const LessonDetailPage(),
              ),
            ),
          ),
        ),
      );

  group('LessonDetailPage', () {
    testWidgets('renders lesson title', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Greetings & Intros'), findsOneWidget);
    });

    testWidgets('renders exercise title', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('How do you say Hello?'), findsOneWidget);
    });

    testWidgets('renders all 4 answer options', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Adiós'), findsOneWidget);
      expect(find.text('Hola'), findsOneWidget);
      expect(find.text('Gracias'), findsOneWidget);
      expect(find.text('Noches'), findsOneWidget);
    });

    testWidgets('renders XP bar', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(XpBar), findsOneWidget);
    });

    testWidgets('renders lives count in app bar', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('5'), findsWidgets);
      expect(find.byIcon(Icons.favorite), findsWidgets);
    });

    testWidgets('renders submit (check) button', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CheckButton), findsOneWidget);
    });

    testWidgets('renders close button in app bar', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });
}
