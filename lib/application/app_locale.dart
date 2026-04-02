import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_locale.g.dart';

/// [MaterialApp.router]의 `locale`에 바인딩되는 앱 로케일.
///
/// Forui 문자열은 [FLocalizations]가 [Locale]에 맞는 ARB를 고릅니다.
/// `supportedLocales`에는 반드시 [FLocalizations.supportedLocales]를 넘기고,
/// 여기서는 그 중에서 **ko / en / ja**만 버튼으로 빠르게 전환하는 예시를 둡니다.
///
/// 참고: https://forui.dev/docs (Localization)
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale build() => const Locale('ko');

  void useKorean() => state = const Locale('ko');
  void useEnglish() => state = const Locale('en');
  void useJapanese() => state = const Locale('ja');
}
