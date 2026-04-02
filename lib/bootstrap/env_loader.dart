import 'env_loader_stub.dart' if (dart.library.io) 'env_loader_io.dart' as impl;

/// `.env` + `assets/env.default` 로드. [main]에서 [runApp] 전에 한 번 호출합니다.
///
/// **멀티 플랫폼**: 웹 등 `dart:io` 없는 타깃은 [env_loader_stub.dart]만 링크되고,
/// 윈도우·안드로이드 등은 [env_loader_io.dart]가 선택됩니다(조건부 import).
Future<void> loadAppEnvironment() => impl.loadAppEnvironment();
