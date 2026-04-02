import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [PEXELS_API_KEY] 우선순위: 루트 `.env`(IO 플랫폼) / `assets/env.default` → `--dart-define`.
///
/// ```sh
/// flutter run --dart-define=PEXELS_API_KEY=여기에_키
/// ```
///
/// 키가 비어 있으면 [pexelsServiceProvider]는 `null`이 되고, UI는 그라데이션·기본 아바타로 대체합니다.
String get resolvedPexelsApiKey {
  final fromFile = dotenv.env['PEXELS_API_KEY']?.trim() ?? '';
  if (fromFile.isNotEmpty) {
    return fromFile;
  }
  const fromDefine = String.fromEnvironment('PEXELS_API_KEY');
  return fromDefine.trim();
}

/// Pexels에서 가져온 한 장의 메타데이터.
///
/// 표시 시 사진가·Pexels 안내: https://www.pexels.com/api/documentation/
class PexelsPhoto {
  const PexelsPhoto({
    required this.imageUrl,
    required this.portraitUrl,
    required this.photographer,
    required this.photographerUrl,
  });

  /// 카드 헤더 등 가로형에 적합.
  final String imageUrl;

  /// 아바타 등 정사각형 크롭에 적합.
  final String portraitUrl;

  final String photographer;
  final String photographerUrl;
}

/// [https://www.pexels.com/api/](https://www.pexels.com/api/) — 검색 API로 랜덤에 가까운 샘플을 고릅니다.
class PexelsService {
  PexelsService({required this.apiKey, Dio? dio}) : _dio = dio ?? Dio();

  final String apiKey;
  final Dio _dio;

  static final _random = Random();

  static const _queries = <String>[
    'nature',
    'architecture',
    'texture',
    'minimal',
    'urban',
    'abstract',
    'interior',
    'landscape',
    'food',
    'pattern',
  ];

  Future<PexelsPhoto?> fetchRandomPhoto() async {
    try {
      final q = _queries[_random.nextInt(_queries.length)];
      final page = 1 + _random.nextInt(40);
      final response = await _dio.get<Map<String, dynamic>>(
        'https://api.pexels.com/v1/search',
        queryParameters: <String, dynamic>{'query': q, 'page': page, 'per_page': 15},
        options: Options(headers: <String, dynamic>{'Authorization': apiKey}),
      );
      final list = response.data?['photos'] as List<dynamic>?;
      if (list == null || list.isEmpty) {
        return null;
      }
      final raw = list[_random.nextInt(list.length)] as Map<String, dynamic>;
      final src = raw['src'] as Map<String, dynamic>?;
      if (src == null) {
        return null;
      }
      final medium = src['medium'] as String?;
      if (medium == null) {
        return null;
      }
      final portrait = src['portrait'] as String? ?? medium;
      return PexelsPhoto(
        imageUrl: medium,
        portraitUrl: portrait,
        photographer: raw['photographer'] as String? ?? 'Pexels',
        photographerUrl: raw['photographer_url'] as String? ?? 'https://www.pexels.com',
      );
    } on Object {
      return null;
    }
  }
}

/// 키가 없으면 `null` — 네트워크 호출을 하지 않습니다.
final pexelsServiceProvider = Provider<PexelsService?>((Ref ref) {
  final key = resolvedPexelsApiKey;
  if (key.isEmpty) {
    return null;
  }
  return PexelsService(apiKey: key);
});
