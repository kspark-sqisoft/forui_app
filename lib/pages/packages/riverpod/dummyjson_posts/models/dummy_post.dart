import 'package:freezed_annotation/freezed_annotation.dart';

part 'dummy_post.freezed.dart';
part 'dummy_post.g.dart';

/// [DummyJSON Posts](https://dummyjson.com/docs/posts/) `reactions` 객체.
@freezed
abstract class PostReactions with _$PostReactions {
  const factory PostReactions({
    required int likes,
    required int dislikes,
  }) = _PostReactions;

  factory PostReactions.fromJson(Map<String, dynamic> json) => _$PostReactionsFromJson(json);
}

/// 단일 포스트 (목록·상세·POST add 응답 공통; add 응답은 필드가 일부만 올 수 있음).
@freezed
abstract class DummyPost with _$DummyPost {
  const factory DummyPost({
    required int id,
    required String title,
    @Default('') String body,
    @Default(<String>[]) List<String> tags,
    PostReactions? reactions,
    int? views,
    @Default(1) int userId,
  }) = _DummyPost;

  factory DummyPost.fromJson(Map<String, dynamic> json) => _$DummyPostFromJson(json);
}

/// `GET /posts?limit&skip` 페이지 응답.
@freezed
abstract class PostsListPage with _$PostsListPage {
  const factory PostsListPage({
    required List<DummyPost> posts,
    required int total,
    required int skip,
    required int limit,
  }) = _PostsListPage;

  factory PostsListPage.fromJson(Map<String, dynamic> json) => _$PostsListPageFromJson(json);
}
