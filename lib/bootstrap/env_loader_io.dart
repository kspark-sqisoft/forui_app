import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 프로젝트 루트 `.env`가 있으면 우선 사용하고, 없으면 [assets/env.default]를 씁니다.
Future<void> loadAppEnvironment() async {
  final file = File('.env');
  if (await file.exists()) {
    final raw = await file.readAsString();
    if (raw.trim().isEmpty) {
      await dotenv.load(fileName: 'assets/env.default');
      return;
    }
    dotenv.loadFromString(envString: raw);
    return;
  }
  await dotenv.load(fileName: 'assets/env.default');
}
