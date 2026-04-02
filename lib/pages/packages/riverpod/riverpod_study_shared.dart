import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 오버라이드·스코프 학습 페이지에서 공유하는 인사 문자열 [Provider].
final studyGreetingProvider = Provider<String>((ref) => '안녕, Riverpod (기본값)');
