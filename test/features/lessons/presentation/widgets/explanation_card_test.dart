import 'dart:async';

import 'package:draksy/features/lessons/data/models/node_content_model.dart';
import 'package:draksy/features/lessons/presentation/widgets/explanation_card.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

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
    final encoded =
        const StandardMessageCodec().encodeMessage(<Object, Object>{})!;
    return parser(encoded);
  }
}

void main() {
  const tContent = ExplanationContentModel(
    phrase: 'Hola',
    translation: 'Olá',
    contextSentence: 'Hola means Hello',
    grammarTip: 'Casual greeting',
    imageKey: 'dragon_greeting',
  );

  Widget createWidgetUnderTest() => DefaultAssetBundle(
        bundle: _FakeAssetBundle(),
        child: ProviderScope(
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: (context, _) => const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: Scaffold(
                body: ExplanationCard(
                  content: tContent,
                  dragonColor: 'Black',
                ),
              ),
            ),
          ),
        ),
      );

  testWidgets('renders explanation card content', (tester) async {
    tester.view.physicalSize = const Size(1080, 2070); // 360 * 3, 690 * 3
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.textContaining('Hola'), findsOneWidget);
    expect(find.text('Hola means Hello'), findsOneWidget);
    expect(find.text('Casual greeting'), findsOneWidget);
  });
}
