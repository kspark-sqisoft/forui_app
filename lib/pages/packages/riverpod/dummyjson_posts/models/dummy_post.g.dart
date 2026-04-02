// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostReactions _$PostReactionsFromJson(Map<String, dynamic> json) =>
    _PostReactions(
      likes: (json['likes'] as num).toInt(),
      dislikes: (json['dislikes'] as num).toInt(),
    );

Map<String, dynamic> _$PostReactionsToJson(_PostReactions instance) =>
    <String, dynamic>{'likes': instance.likes, 'dislikes': instance.dislikes};

_DummyPost _$DummyPostFromJson(Map<String, dynamic> json) => _DummyPost(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String? ?? '',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  reactions: json['reactions'] == null
      ? null
      : PostReactions.fromJson(json['reactions'] as Map<String, dynamic>),
  views: (json['views'] as num?)?.toInt(),
  userId: (json['userId'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$DummyPostToJson(_DummyPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'tags': instance.tags,
      'reactions': instance.reactions,
      'views': instance.views,
      'userId': instance.userId,
    };

_PostsListPage _$PostsListPageFromJson(Map<String, dynamic> json) =>
    _PostsListPage(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => DummyPost.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$PostsListPageToJson(_PostsListPage instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
