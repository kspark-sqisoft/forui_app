import 'package:flutter/services.dart' show FlutterVersion;

/// 사이드바 등에 표시할 SDK 문자열.
///
/// `flutter run` / `flutter build`(웹·모바일·데스크톱) 시 도구가 [FlutterVersion]용 `fromEnvironment` 값을 넣습니다.
/// **dart:io를 쓰지 않아** 웹·안드로이드·윈도우 모두 동일 소스로 빌드됩니다.
abstract final class SdkRuntimeInfo {
  /// 예: `Flutter 3.24.3 (stable)`
  static String flutterLabel() {
    final v = FlutterVersion.version;
    if (v == null || v.isEmpty) {
      return 'Flutter —';
    }
    final ch = FlutterVersion.channel;
    if (ch != null && ch.isNotEmpty) {
      return 'Flutter $v ($ch)';
    }
    return 'Flutter $v';
  }

  /// 예: `Dart 3.5.0` ([FlutterVersion.dartVersion])
  static String dartLabel() {
    final injected = FlutterVersion.dartVersion;
    if (injected != null && injected.isNotEmpty) {
      return 'Dart $injected';
    }
    return 'Dart —';
  }

  /// 있으면 짧은 프레임워크 리비전 (예: `framework abc1234`).
  static String? frameworkRevisionHint() {
    final r = FlutterVersion.frameworkRevision;
    if (r == null || r.isEmpty) return null;
    final short = r.length > 10 ? r.substring(0, 10) : r;
    return 'framework $short';
  }

  /// 있으면 엔진 리비전 앞부분.
  static String? engineRevisionHint() {
    final r = FlutterVersion.engineRevision;
    if (r == null || r.isEmpty) return null;
    final short = r.length > 10 ? r.substring(0, 10) : r;
    return 'engine $short';
  }
}
