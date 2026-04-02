import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// [pubspec.yaml] `fonts` family — 기본 한글 UI·Quill 등에서 공통으로 참조합니다.
const String kBundledKoreanFontFamily = 'Noto Sans KR';

/// 나눔고딕(Regular + Bold). [pubspec.yaml]의 family와 동일해야 합니다.
const String kBundledNanumGothicFontFamily = 'Nanum Gothic';

const String _notoKrVariable = 'assets/fonts/NotoSansKR-Variable.ttf';
const String _nanumRegular = 'assets/fonts/NanumGothic-Regular.ttf';
const String _nanumBold = 'assets/fonts/NanumGothic-Bold.ttf';

/// 웹에서 번들 TTF를 [runApp] 전에 엔진에 등록합니다(첫 페인트·Quill 글꼴 선택용).
Future<void> preloadKoreanUiFont() async {
  if (!kIsWeb) return;

  final noto = FontLoader(kBundledKoreanFontFamily)
    ..addFont(rootBundle.load(_notoKrVariable));
  await noto.load();

  final nanum = FontLoader(kBundledNanumGothicFontFamily)
    ..addFont(rootBundle.load(_nanumRegular))
    ..addFont(rootBundle.load(_nanumBold));
  await nanum.load();
}
