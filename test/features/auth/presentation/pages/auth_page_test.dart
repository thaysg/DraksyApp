import 'package:draksy/features/auth/domain/repositories/auth_repository.dart';
import 'package:draksy/features/auth/presentation/pages/auth_page.dart';
import 'package:draksy/features/auth/presentation/providers/auth_providers.dart';
import 'package:draksy/features/auth/presentation/widgets/social_auth_button.dart';
import 'package:draksy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockGoRouter mockRouter;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockRouter = MockGoRouter();

    when(() => mockAuthRepository.userChanges)
        .thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest({
    bool isLoading = false,
    bool emailConfirmationSent = false,
    AuthType authType = AuthType.login,
  }) =>
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          if (isLoading)
            authLoadingProvider.overrideWith(MockAuthLoadingTrue.new),
          if (emailConfirmationSent)
            emailConfirmationSentProvider
                .overrideWith(MockEmailConfirmationSentTrue.new),
          if (authType == AuthType.signup)
            authTypeProvider.overrideWith(MockAuthTypeSignup.new),
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
              child: const AuthPage(),
            ),
          ),
        ),
      );

  group('AuthPage', () {
    testWidgets('renders sign in header and form', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(SocialAuthButton), findsNWidgets(2));
    });

    testWidgets(
        'shows 4 fields in sign up mode (name, email, password, confirm)',
        (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createWidgetUnderTest(authType: AuthType.signup),
      );
      await tester.pumpAndSettle();

      // signup has: name + email + password + confirmPassword = 4 fields
      expect(find.byType(TextFormField), findsNWidgets(4));
    });

    testWidgets('toggles password visibility icon when tapped', (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Initially obscured — shows visibility_off icon
      final offIcon = find.byIcon(Icons.visibility_off_outlined).first;
      await tester.ensureVisible(offIcon);
      await tester.tap(offIcon);
      await tester.pumpAndSettle();

      // Now visible — shows visibility icon
      expect(find.byIcon(Icons.visibility_outlined), findsWidgets);
    });

    testWidgets(
        'shows email confirmation card when emailConfirmationSent is true',
        (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createWidgetUnderTest(emailConfirmationSent: true),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.mark_email_read_outlined), findsOneWidget);
      expect(find.text('Back to Sign In'), findsOneWidget);
      // Form fields should not be visible
      expect(find.byType(TextFormField), findsNothing);
    });

    testWidgets('shows loading indicator on button when isLoading is true',
        (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest(isLoading: true));
      // pump() ao invés de pumpAndSettle() — CircularProgressIndicator
      // tem animação infinita que trava o settle
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

class MockAuthLoadingTrue extends AuthLoading {
  @override
  bool build() => true;
}

class MockEmailConfirmationSentTrue extends EmailConfirmationSent {
  @override
  bool build() => true;
}

class MockAuthTypeSignup extends AuthTypeNotifier {
  @override
  AuthType build() => AuthType.signup;
}
