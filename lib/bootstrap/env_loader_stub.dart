import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 웹 등 `dart:io` 없는 플랫폼 — 에셋 기본값만 로드합니다.
Future<void> loadAppEnvironment() async {
  await dotenv.load(fileName: 'assets/env.default');
}
