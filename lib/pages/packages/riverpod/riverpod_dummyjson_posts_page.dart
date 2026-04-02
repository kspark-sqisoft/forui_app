import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import 'dummyjson_posts/application/dummy_json_posts_providers.dart';
import 'dummyjson_posts/data/dummy_json_posts_repository.dart';

class _PostDetailErrorPane extends StatelessWidget {
  const _PostDetailErrorPane({
    required this.message,
    required this.cancelled,
    required this.onRetry,
  });

  final String message;
  final bool cancelled;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                FIcons.circleAlert,
                size: 20,
                color: theme.colors.destructive,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SelectableText(
                  message,
                  style: theme.typography.sm.copyWith(height: 1.4),
                ),
              ),
            ],
          ),
          if (cancelled)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '다이얼로그를 닫으면서 요청이 취소된 경우입니다. 다시 불러오기를 눌러 보세요.',
                style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
              ),
            ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: FButton(
              size: FButtonSizeVariant.sm,
              variant: FButtonVariant.outline,
              onPress: onRetry,
              child: const Text('다시 시도'),
            ),
          ),
        ],
      ),
    );
  }
}

void _showPostDetail(BuildContext context, WidgetRef ref, int postId) {
  showFDialog<void>(
    context: context,
    useRootNavigator: true,
    builder: (ctx, style, animation) => _PostDetailDialog(
      postId: postId,
      animation: animation,
    ),
  );
}

class _PostDetailDialog extends ConsumerWidget {
  const _PostDetailDialog({
    required this.postId,
    required this.animation,
  });

  final int postId;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(postDetailProvider(postId));
    final theme = context.theme;

    return FDialog(
      animation: animation,
      title: Text('Post #$postId'),
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 420),
        child: async.when(
          data: (post) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: theme.typography.sm.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  post.body.isEmpty ? '(본문 없음)' : post.body,
                  style: theme.typography.sm.copyWith(
                    color: theme.colors.mutedForeground,
                    height: 1.45,
                  ),
                ),
                if (post.tags.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final t in post.tags)
                        FBadge(child: Text(t)),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  'userId ${post.userId}'
                  '${post.views != null ? ' · views ${post.views}' : ''}'
                  '${post.reactions != null ? ' · 👍 ${post.reactions!.likes} · 👎 ${post.reactions!.dislikes}' : ''}',
                  style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
                ),
              ],
            ),
          ),
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: FCircularProgress.loader()),
          ),
          error: (e, _) => _PostDetailErrorPane(
            message: '$e',
            cancelled: e is DummyJsonPostsRequestFailure && e.cancelled,
            onRetry: () => ref.invalidate(postDetailProvider(postId)),
          ),
        ),
      ),
      actions: [
        FButton(
          variant: FButtonVariant.secondary,
          onPress: () => Navigator.pop(context),
          child: const Text('닫기'),
        ),
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => ref.invalidate(postDetailProvider(postId)),
          child: const Text('상세 다시 불러오기'),
        ),
      ],
    );
  }
}

class _PostsPager extends ConsumerWidget {
  const _PostsPager();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(postsListNotifierProvider.select((a) => a.value?.total));
    final q = ref.watch(postsQueryProvider);
    final theme = context.theme;

    final limit = q.limit;
    final totalPages = total != null && limit > 0 ? math.max(1, (total + limit - 1) ~/ limit) : 0;
    final current0Based = limit > 0
        ? (q.skip ~/ limit).clamp(0, totalPages > 0 ? totalPages - 1 : 0)
        : 0;

    final rangeLabel = total == null
        ? 'skip ${q.skip}'
        : '${q.skip + 1}–${math.min(q.skip + q.limit, total)} / $total';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '페이지 (FPagination · 0 기반)',
                  style: theme.typography.xs.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colors.mutedForeground,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    rangeLabel,
                    style: theme.typography.xs.copyWith(
                      fontFamily: 'monospace',
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (total == null || totalPages == 0)
              Text(
                '건수를 불러오면 [FPagination]이 표시됩니다.',
                style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
              )
            else
              FPagination(
                control: FPaginationControl.lifted(
                  page: current0Based,
                  pages: totalPages,
                  siblings: 1,
                  onChange: (index) =>
                      ref.read(postsQueryProvider.notifier).goToPageIndex(index, total),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddPostForm extends ConsumerStatefulWidget {
  const _AddPostForm();

  @override
  ConsumerState<_AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends ConsumerState<_AddPostForm> {
  late final TextEditingController _title = TextEditingController();
  late final TextEditingController _body = TextEditingController();
  late final TextEditingController _userId = TextEditingController(text: '1');

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _userId.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _title.text.trim();
    if (title.isEmpty) return;

    final uid = int.tryParse(_userId.text.trim()) ?? 1;
    final bodyText = _body.text.trim();
    try {
      await ref.read(postsListNotifierProvider.notifier).addPost(
            title: title,
            body: bodyText.isEmpty ? null : bodyText,
            userId: uid,
          );
      if (mounted) {
        _title.clear();
        _body.clear();
        showFToast(
          context: context,
          title: const Text('등록'),
          description: const Text('POST /posts/add 시뮬레이션 — 목록 맨 위에 반영되었습니다.'),
          icon: const Icon(FIcons.check),
        );
      }
    } catch (e) {
      if (mounted) {
        showFToast(
          context: context,
          title: const Text('실패'),
          description: Text('$e'),
          icon: Icon(FIcons.circleAlert, color: context.theme.colors.destructive),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FTextField(
          label: const Text('제목'),
          hint: '필수',
          spellCheckConfiguration: SpellCheckConfiguration.disabled(),
          autocorrect: false,
          control: FTextFieldControl.managed(controller: _title),
        ),
        const SizedBox(height: 10),
        FTextField(
          label: const Text('본문'),
          hint: '선택',
          spellCheckConfiguration: SpellCheckConfiguration.disabled(),
          autocorrect: false,
          maxLines: 3,
          control: FTextFieldControl.managed(controller: _body),
        ),
        const SizedBox(height: 10),
        FTextField(
          label: const Text('userId'),
          hint: '1',
          spellCheckConfiguration: SpellCheckConfiguration.disabled(),
          keyboardType: TextInputType.number,
          control: FTextFieldControl.managed(controller: _userId),
        ),
        const SizedBox(height: 10),
        FButton(
          size: FButtonSizeVariant.sm,
          onPress: _submit,
          child: const Text('POST /posts/add'),
        ),
      ],
    );
  }
}

class _PostsListSection extends ConsumerWidget {
  const _PostsListSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(postsListNotifierProvider);
    final theme = context.theme;
    final listHeight = math.max(
      280.0,
      MediaQuery.sizeOf(context).height * 0.48,
    );

    return async.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      data: (page) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '총 ${page.total}건 · 이 페이지 ${page.posts.length}건',
              style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: listHeight,
              child: ListView.separated(
                itemCount: page.posts.length,
                separatorBuilder: (_, _) => const SizedBox(height: 6),
                itemBuilder: (context, i) {
                  final p = page.posts[i];
                  final likes = p.reactions?.likes;
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FItem(
                      title: Text(
                        p.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.typography.sm,
                      ),
                      subtitle: Text(
                        likes != null ? '👍 $likes · user ${p.userId}' : 'user ${p.userId}',
                        style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
                      ),
                      suffix: Icon(FIcons.chevronRight, size: 18, color: theme.colors.mutedForeground),
                      onPress: () => _showPostDetail(context, ref, p.id),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: FCircularProgress.loader()),
      ),
      error: (e, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText('$e', style: theme.typography.sm),
          const SizedBox(height: 8),
          FButton(
            size: FButtonSizeVariant.sm,
            onPress: () => ref.invalidate(postsListNotifierProvider),
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }
}

/// [DummyJSON Posts](https://dummyjson.com/docs/posts/) — Freezed 모델, Repository, Riverpod, FDialog 상세.
class RiverpodDummyJsonPostsPage extends ConsumerWidget {
  const RiverpodDummyJsonPostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(postsListNotifierProvider, (prev, next) {
      if (next.hasError && (prev == null || !prev.hasError)) {
        showFToast(
          context: context,
          title: const Text('Posts'),
          description: Text('${next.error}'),
          icon: Icon(FIcons.circleAlert, color: context.theme.colors.destructive),
        );
      }
    });

    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DummyJSON posts · 상세 `postDetailProvider`는 닫은 뒤 ${postDetailCacheTtl.inSeconds}s 캐시(keepAlive)',
          style: theme.typography.xs.copyWith(
            color: theme.colors.mutedForeground,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FButton(
              size: FButtonSizeVariant.sm,
              prefix: Icon(
                FIcons.refreshCw,
                size: 15,
                color: theme.colors.primaryForeground,
              ),
              onPress: () => ref.read(postsListNotifierProvider.notifier).refresh(),
              child: const Text('invalidateSelf'),
            ),
            FButton(
              size: FButtonSizeVariant.sm,
              variant: FButtonVariant.outline,
              onPress: () => ref.invalidate(postsListNotifierProvider),
              child: const Text('invalidate'),
            ),
            const _PostsPager(),
          ],
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: 8),
            title: Text(
              'POST /posts/add (시뮬)',
              style: theme.typography.xs.copyWith(fontWeight: FontWeight.w600),
            ),
            initiallyExpanded: false,
            children: const [
              _AddPostForm(),
            ],
          ),
        ),
        Text(
          '목록 · 행 탭 → 상세',
          style: theme.typography.sm.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colors.foreground,
          ),
        ),
        const SizedBox(height: 6),
        const _PostsListSection(),
      ],
    );
  }
}
