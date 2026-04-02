import 'package:dio/dio.dart';

import '../../../../../core/logging/app_log.dart';
import '../models/dummy_post.dart';

/// [DummyJSON Posts API](https://dummyjson.com/docs/posts/) 호출 실패 시 UI·로그용 메시지.
final class DummyJsonPostsRequestFailure implements Exception {
  DummyJsonPostsRequestFailure(
    this.message, {
    this.statusCode,
    this.cancelled = false,
  });

  final String message;
  final int? statusCode;

  /// [CancelToken] 등으로 중단된 경우(다이얼로그 닫기 등).
  final bool cancelled;

  @override
  String toString() => message;
}

/// [DummyJSON Posts API](https://dummyjson.com/docs/posts/) — 저장은 시뮬레이션입니다.
final class DummyJsonPostsRepository {
  DummyJsonPostsRepository(this._dio);

  final Dio _dio;

  Future<PostsListPage> fetchPosts({
    required int limit,
    required int skip,
  }) async {
    try {
      AppLog.i('fetchPosts(limit: $limit, skip: $skip)');
      final res = await _dio.get<Map<String, dynamic>>(
        '/posts',
        queryParameters: {'limit': limit, 'skip': skip},
      );
      return PostsListPage.fromJson(res.data!);
    } on DioException catch (e) {
      throw _mapDio(e, context: '목록');
    }
  }

  Future<DummyPost> fetchPost(int id, {CancelToken? cancelToken}) async {
    try {
      AppLog.i('fetchPost($id)');
      final res = await _dio.get<Map<String, dynamic>>(
        '/posts/$id',
        cancelToken: cancelToken,
      );
      return DummyPost.fromJson(res.data!);
    } on DioException catch (e) {
      throw _mapDio(e, context: '상세');
    }
  }

  /// [POST /posts/add](https://dummyjson.com/docs/posts/) — 응답에 `body`·`tags` 등이 없을 수 있습니다.
  Future<DummyPost> addPost({
    required String title,
    String? body,
    int userId = 1,
    List<String>? tags,
  }) async {
    try {
      AppLog.i(
        'addPost(title: $title, body: $body, userId: $userId, tags: $tags)',
      );
      final data = <String, dynamic>{
        'title': title,
        'userId': userId,
        if (body != null && body.isNotEmpty) 'body': body,
        if (tags != null && tags.isNotEmpty) 'tags': tags,
      };
      final res = await _dio.post<Map<String, dynamic>>(
        '/posts/add',
        data: data,
      );
      return DummyPost.fromJson(res.data!);
    } on DioException catch (e) {
      throw _mapDio(e, context: '글 등록');
    }
  }
}

DummyJsonPostsRequestFailure _mapDio(
  DioException e, {
  required String context,
}) {
  if (e.type == DioExceptionType.cancel) {
    return DummyJsonPostsRequestFailure(
      '요청이 취소되었습니다.',
      statusCode: e.response?.statusCode,
      cancelled: true,
    );
  }

  final code = e.response?.statusCode;
  final bodyMsg = _messageFromResponseData(e.response?.data);

  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return DummyJsonPostsRequestFailure(
      '$context: 연결·응답 시간이 초과되었습니다.',
      statusCode: code,
    );
  }

  if (e.type == DioExceptionType.connectionError) {
    return DummyJsonPostsRequestFailure(
      '$context: 네트워크에 연결할 수 없습니다.',
      statusCode: code,
    );
  }

  switch (code) {
    case null:
      return DummyJsonPostsRequestFailure(
        '$context: ${e.message ?? '알 수 없는 오류'}.',
      );
    case 404:
      return DummyJsonPostsRequestFailure(
        '$context: 해당 데이터를 찾을 수 없습니다(404).',
        statusCode: 404,
      );
    case 401:
    case 403:
      return DummyJsonPostsRequestFailure(
        '$context: 접근이 거부되었습니다($code).',
        statusCode: code,
      );
    case final int c when c >= 500:
      return DummyJsonPostsRequestFailure(
        '$context: 서버 오류($c)${bodyMsg != null ? ' — $bodyMsg' : ''}.',
        statusCode: c,
      );
    default:
      return DummyJsonPostsRequestFailure(
        '$context: 요청 실패($code)${bodyMsg != null ? ' — $bodyMsg' : ''}.',
        statusCode: code,
      );
  }
}

String? _messageFromResponseData(Object? data) {
  if (data is Map<String, dynamic>) {
    final m = data['message'];
    if (m is String && m.isNotEmpty) return m;
  }
  return null;
}
