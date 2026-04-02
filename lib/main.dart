import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import 'application/app_locale.dart';
import 'application/selected_forui_theme.dart';
import 'bootstrap/app_fonts.dart';
import 'bootstrap/env_loader.dart';
import 'bootstrap/sqflite_setup.dart';
import 'core/logging/app_log.dart';
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ensureSqfliteInitialized();
  await loadAppEnvironment();
  await preloadKoreanUiFont();
  AppLog.i('Application starting');
  runApp(const ProviderScope(child: FlutterSandboxApp()));
}

/// Forui [FTheme]와 Material [ThemeData], 그리고 [locale]을 Riverpod로 동기화합니다.
///
/// - [resolvedForuiThemeProvider]: [AppForuiThemeId] → [FThemeData] (학습 페이지에서 전환).
/// - [appLocaleProvider]: ko / en / ja 빠른 전환(로컬라이제이션 학습 페이지와 동일 소스).
///
/// **테마가 두 갈래인 이유**
/// - Forui 위젯(FButton, FCard …)은 [FTheme]의 [FThemeData](색·타이포·컴포넌트 스타일)를 [context.theme]으로 읽습니다.
/// - Flutter 기본 위젯(일부 Material)은 [MaterialApp.theme]의 [ThemeData]를 봅니다.
///   그래서 `seedColor`·`brightness`를 [FThemeData.colors]와 맞춰 한쪽은 밝고 한쪽은 어둡게 어긋나지 않게 합니다.
class FlutterSandboxApp extends ConsumerWidget {
  const FlutterSandboxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 개념 > 테마 화면의 [selectedForuiThemeProvider]가 바뀌면 여기서도 다시 빌드됩니다.
    final fTheme = ref.watch(resolvedForuiThemeProvider);
    final locale = ref.watch(appLocaleProvider);

    // 최상위 FTheme: 앱 전체 트리에 Forui용 FThemeData를 주입합니다.
    // (하위에서 중첩 FTheme을 쓰면 그 subtree만 다른 data를 쓸 수 있음 — customizing_themes_page 참고)
    final colorScheme = ColorScheme.fromSeed(
      seedColor: fTheme.colors.primary,
      brightness: fTheme.colors.brightness,
    );
    return FTheme(
      data: fTheme,
      child: MaterialApp.router(
        title: '플러터 샌드박스',
        debugShowCheckedModeBanner: false,
        // Material 3 ColorScheme: Forui primary·light/dark와 톤을 맞춤 (완전 동일하진 않지만 이질감 완화)
        theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
          fontFamily: kIsWeb ? kBundledKoreanFontFamily : null,
        ),
        locale: locale,
        localizationsDelegates: const [
          ...FLocalizations.localizationsDelegates,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        supportedLocales: FLocalizations.supportedLocales,
        builder: (context, child) =>
            FToaster(child: child ?? const SizedBox.shrink()),
        routerConfig: appRouter,
      ),
    );
  }
}
