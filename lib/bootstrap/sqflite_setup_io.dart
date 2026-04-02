import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Windows / Linux / macOS 에서 `sqflite` 전역 API를 쓰기 전에 FFI 팩토리를 연결합니다.
///
/// Android·iOS는 `sqflite`가 자체 초기화하므로 여기서는 건드리지 않습니다.
Future<void> ensureSqfliteInitialized() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}
