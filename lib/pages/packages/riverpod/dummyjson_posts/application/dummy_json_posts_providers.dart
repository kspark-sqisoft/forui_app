import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/logging/app_log.dart';
import '../data/dummy_json_posts_repository.dart';
import '../models/dummy_post.dart';

final dummyJsonPostsDioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

final dummyJsonPostsRepositoryProvider = Provider<DummyJsonPostsRepository>((
  ref,
) {
  return DummyJsonPostsRepository(ref.watch(dummyJsonPostsDioProvider));
});

/// 페이지네이션 쿼리 (Notifier).
final postsQueryProvider = NotifierProvider<PostsQueryNotifier, PostsQuery>(
  PostsQueryNotifier.new,
);

final class PostsQuery {
  const PostsQuery({this.limit = 10, this.skip = 0});

  final int limit;
  final int skip;

  PostsQuery copyWith({int? limit, int? skip}) {
    return PostsQuery(limit: limit ?? this.limit, skip: skip ?? this.skip);
  }
}

class PostsQueryNotifier extends Notifier<PostsQuery> {
  @override
  PostsQuery build() => const PostsQuery();

  void nextPage(int total) {
    final n = state.skip + state.limit;
    if (n >= total) return;
    state = state.copyWith(skip: n);
  }

  void prevPage() {
    final next = state.skip - state.limit;
    state = state.copyWith(skip: next < 0 ? 0 : next);
  }

  void reset() => state = const PostsQuery();

  /// [pageIndex]는 0부터. [totalCount]는 API의 전체 건수.
  void goToPageIndex(int pageIndex, int totalCount) {
    final limit = state.limit;
    if (limit <= 0) return;
    final totalPages = (totalCount + limit - 1) ~/ limit;
    if (pageIndex < 0 || pageIndex >= totalPages) return;
    state = state.copyWith(skip: pageIndex * limit);
  }
}

/// 목록 + 페이지 메타.
final postsListNotifierProvider =
    AsyncNotifierProvider<PostsListNotifier, PostsListPage>(
      PostsListNotifier.new,
    );

class PostsListNotifier extends AsyncNotifier<PostsListPage> {
  @override
  Future<PostsListPage> build() async {
    ref.onDispose(() {
      AppLog.i('PostsListNotifier disposed');
    });
    ref.onCancel(() {
      AppLog.i('PostsListNotifier cancelled');
    });
    ref.onResume(() {
      AppLog.i('PostsListNotifier resumed');
    });
    ref.onAddListener(() {
      AppLog.i('PostsListNotifier added listener');
    });
    ref.onRemoveListener(() {
      AppLog.i('PostsListNotifier removed listener');
    });
    final repo = ref.watch(dummyJsonPostsRepositoryProvider);
    final q = ref.watch(postsQueryProvider);
    return repo.fetchPosts(limit: q.limit, skip: q.skip);
  }

  Future<void> refresh() async => ref.invalidateSelf();

  Future<void> addPost({
    required String title,
    String? body,
    int userId = 1,
  }) async {
    final page = state.value;
    if (page == null) return;

    final repo = ref.read(dummyJsonPostsRepositoryProvider);
    final created = await repo.addPost(
      title: title,
      body: body,
      userId: userId,
    );
    state = AsyncData(
      page.copyWith(posts: [created, ...page.posts], total: page.total + 1),
    );
  }
}

/// 마지막 리스너가 끊긴 뒤 이 시간이 지나면 [KeepAliveLink]를 닫아 캐시를 비웁니다.
const postDetailCacheTtl = Duration(seconds: 30);

DummyPost? _dummyPostFromCurrentList(Ref ref, int id) {
  final posts = ref.read(postsListNotifierProvider).value?.posts;
  if (posts == null) return null;
  for (final p in posts) {
    if (p.id == id) return p;
  }
  return null;
}

/// 상세 1건. `keepAlive`로 잠시 캐시 유지 → 같은 id로 다시 열면 로딩 없이 즉시 표시.
///
/// DummyJSON `POST /posts/add`로 만든 id는 `GET /posts/:id`에 없을 수 있어(404),
/// 그때는 [postsListNotifierProvider]에 있는 동일 id 행으로 대체합니다.
///
/// 참고: 리스너 해제 시 HTTP는 [CancelToken]으로 취소하지만, 이미 완료된 [AsyncData]는
/// TTL 동안 메모리에 남습니다.
final postDetailProvider = FutureProvider.autoDispose.family<DummyPost, int>((
  ref,
  id,
) async {
  final link = ref.keepAlive();
  Timer? disposeTimer;
  final cancelToken = CancelToken();

  ref.onDispose(() {
    AppLog.i('postDetailProvider($id) disposed');
    disposeTimer?.cancel();
    cancelToken.cancel();
  });

  ref.onCancel(() {
    AppLog.i('postDetailProvider($id) cancelled');
    disposeTimer = Timer(postDetailCacheTtl, link.close);
  });

  ref.onResume(() {
    AppLog.i('postDetailProvider($id) resumed');
    disposeTimer?.cancel();
  });
  ref.onAddListener(() {
    AppLog.i('postDetailProvider($id) added listener');
  });
  ref.onRemoveListener(() {
    AppLog.i('postDetailProvider($id) removed listener');
  });

  final repo = ref.watch(dummyJsonPostsRepositoryProvider);
  try {
    return await repo.fetchPost(id, cancelToken: cancelToken);
  } on DummyJsonPostsRequestFailure catch (e) {
    AppLog.e('fetchPost failed: ${e.statusCode} ${e.message}');
    if (e.statusCode == 404) {
      final local = _dummyPostFromCurrentList(ref, id);
      if (local != null) return local;
    }
    rethrow;
  }
});
