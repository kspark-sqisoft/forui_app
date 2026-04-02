import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// 앱 전역 [Logger] 래퍼. 디버그에서는 상세 출력, 릴리스에서는 레벨을 올려 노이즈를 줄입니다.
abstract final class AppLog {
  static final Logger _logger = Logger(
    level: kReleaseMode ? Level.warning : Level.debug,
    filter: _AppLogFilter(),
    printer: PrettyPrinter(
      methodCount: kReleaseMode ? 0 : 2,
      errorMethodCount: 8,
      lineLength: 100,
      colors: !kReleaseMode,
      printEmojis: !kReleaseMode,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static void v(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  static void d(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

final class _AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kReleaseMode) {
      return event.level.index >= Level.warning.index;
    }
    return true;
  }
}
