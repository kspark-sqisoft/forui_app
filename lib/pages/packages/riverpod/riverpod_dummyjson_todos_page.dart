import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';
import 'dummyjson_todos_api.dart';

// —— Infra (테스트 시 [ProviderScope] overrides 로 [Dio] 교체 가능) ——

final _dummyJsonDioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: const {'Accept': 'application/json'},
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

final _dummyJsonTodosClientProvider = Provider<DummyJsonTodosClient>((ref) {
  return DummyJsonTodosClient(ref.watch(_dummyJsonDioProvider));
});

// —— UI 전용 동기 상태 ——

enum _TodoListFilter { all, active, completed }

final _todoListFilterProvider = NotifierProvider<_TodoListFilterNotifier, _TodoListFilter>(
  _TodoListFilterNotifier.new,
);

class _TodoListFilterNotifier extends Notifier<_TodoListFilter> {
  @override
  _TodoListFilter build() => _TodoListFilter.all;

  void setFilter(_TodoListFilter f) => state = f;
}

final _selectedTodoIdProvider = NotifierProvider<_SelectedTodoIdNotifier, int?>(_SelectedTodoIdNotifier.new);

class _SelectedTodoIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int id) => state = state == id ? null : id;
}

/// `true`면 [AsyncValue.when]이 이전 data를 유지하고, `false`면 재요청 중 `loading`에서 스피너만 보입니다.
final _keepPreviousTodosWhileLoadingProvider =
    NotifierProvider<_KeepPreviousWhileLoadingNotifier, bool>(_KeepPreviousWhileLoadingNotifier.new);

class _KeepPreviousWhileLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool value) => state = value;
}

final _todosQueryProvider = NotifierProvider<_TodosQueryNotifier, TodosQuery>(_TodosQueryNotifier.new);

class _TodosQueryNotifier extends Notifier<TodosQuery> {
  @override
  TodosQuery build() => const TodosQuery();

  void nextPage(int total) {
    final n = state.skip + state.limit;
    if (n >= total) return;
    state = TodosQuery(limit: state.limit, skip: n);
  }

  void prevPage() {
    state = TodosQuery(
      limit: state.limit,
      skip: math.max(0, state.skip - state.limit),
    );
  }

  void resetToFirst() => state = const TodosQuery();
}

// —— 핵심: [AsyncNotifier] + [ref.watch]로 쿼리·클라이언트에 반응 ——

final dummyJsonTodosNotifierProvider =
    AsyncNotifierProvider<DummyJsonTodosNotifier, TodosPageData>(DummyJsonTodosNotifier.new);

class DummyJsonTodosNotifier extends AsyncNotifier<TodosPageData> {
  @override
  Future<TodosPageData> build() async {
    final client = ref.watch(_dummyJsonTodosClientProvider);
    final q = ref.watch(_todosQueryProvider);
    return client.fetchPage(limit: q.limit, skip: q.skip);
  }

  /// [ref.invalidateSelf] 패턴 — 공식 예제와 동일하게 전체 재요청.
  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  /// 낙관적 업데이트 후 PUT, 실패 시 이전 [TodosPageData]로 롤백.
  Future<void> toggle(DummyTodo item) async {
    final page = state.value;
    if (page == null) return;

    final client = ref.read(_dummyJsonTodosClientProvider);
    final nextCompleted = !item.completed;
    final optimistic = page.copyWith(
      items: page.items
          .map((e) => e.id == item.id ? e.copyWith(completed: nextCompleted) : e)
          .toList(),
    );
    state = AsyncData(optimistic);

    try {
      final updated = await client.updateCompleted(item.id, nextCompleted);
      state = AsyncData(
        optimistic.copyWith(
          items: optimistic.items.map((e) => e.id == updated.id ? updated : e).toList(),
        ),
      );
    } on Object {
      state = AsyncData(page);
    }
  }

  /// [POST /todos/add](https://dummyjson.com/docs/todos/) — 응답만 시뮬레이션, 로컬 목록 앞에 반영.
  Future<void> addTodo(String rawTitle) async {
    final page = state.value;
    if (page == null) return;

    final title = rawTitle.trim();
    if (title.isEmpty) return;

    final client = ref.read(_dummyJsonTodosClientProvider);
    try {
      final created = await client.addTodo(title);
      state = AsyncData(
        page.copyWith(
          items: [created, ...page.items],
          total: page.total + 1,
        ),
      );
    } on Object {
      /* 네트워크 오류 시 기존 목록 유지 */
    }
  }
}

List<DummyTodo> _filtered(List<DummyTodo> items, _TodoListFilter f) {
  switch (f) {
    case _TodoListFilter.all:
      return items;
    case _TodoListFilter.active:
      return items.where((e) => !e.completed).toList();
    case _TodoListFilter.completed:
      return items.where((e) => e.completed).toList();
  }
}

class _FilterChips extends ConsumerWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f = ref.watch(_todoListFilterProvider);
    final theme = context.theme;

    Widget chip(_TodoListFilter value, String label) {
      final on = f == value;
      return FButton(
        size: FButtonSizeVariant.sm,
        variant: on ? FButtonVariant.primary : FButtonVariant.outline,
        onPress: () => ref.read(_todoListFilterProvider.notifier).setFilter(value),
        child: Text(label),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Text('필터', style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground)),
        chip(_TodoListFilter.all, '전체'),
        chip(_TodoListFilter.active, '진행 중'),
        chip(_TodoListFilter.completed, '완료'),
      ],
    );
  }
}

class _Toolbar extends ConsumerWidget {
  const _Toolbar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dummyJsonTodosNotifierProvider);
    final data = async.value;
    final total = data?.total;
    final q = ref.watch(_todosQueryProvider);
    final keepPrevious = ref.watch(_keepPreviousTodosWhileLoadingProvider);
    final theme = context.theme;

    final rangeLabel = total == null
        ? 'skip ${q.skip}'
        : data != null
        ? '${data.skip + 1}–${data.skip + data.items.length} / $total'
        : '${q.skip + 1}–${math.min(q.skip + q.limit, total)} / $total';

    final atFirst = q.skip <= 0;
    final atLast = total != null && q.skip + q.limit >= total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Tooltip(
              message: keepPrevious
                  ? 'skipLoadingOnReload·Refresh = true — 페이지 전환·invalidate 시 이전 목록 유지 후 갱신.'
                  : '둘 다 false — 재요청 중 when(loading)으로 스피너만 표시.',
              child: FSwitch(
                label: const Text('이전 목록 유지'),
                value: keepPrevious,
                onChange: (v) => ref.read(_keepPreviousTodosWhileLoadingProvider.notifier).set(v),
              ),
            ),
            FButton(
              size: FButtonSizeVariant.sm,
              prefix: Icon(FIcons.refreshCw, size: 15, color: theme.colors.primaryForeground),
              onPress: () => ref.read(dummyJsonTodosNotifierProvider.notifier).refresh(),
              child: const Text('invalidateSelf'),
            ),
            FButton(
              size: FButtonSizeVariant.sm,
              variant: FButtonVariant.outline,
              onPress: () => ref.invalidate(dummyJsonTodosNotifierProvider),
              child: const Text('invalidate'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.muted.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '페이지',
                  style: theme.typography.xs.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colors.mutedForeground,
                  ),
                ),
                FButton(
                  variant: FButtonVariant.outline,
                  size: FButtonSizeVariant.sm,
                  mainAxisSize: MainAxisSize.min,
                  onPress: total == null || atFirst
                      ? null
                      : () => ref.read(_todosQueryProvider.notifier).prevPage(),
                  prefix: Icon(FIcons.chevronLeft, size: 16, color: theme.colors.foreground),
                  child: const Text('이전'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    rangeLabel,
                    style: theme.typography.xs.copyWith(
                      fontFamily: 'monospace',
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ),
                FButton(
                  variant: FButtonVariant.outline,
                  size: FButtonSizeVariant.sm,
                  mainAxisSize: MainAxisSize.min,
                  onPress: total == null || atLast
                      ? null
                      : () => ref.read(_todosQueryProvider.notifier).nextPage(total),
                  suffix: Icon(FIcons.chevronRight, size: 16, color: theme.colors.foreground),
                  child: const Text('다음'),
                ),
                FButton(
                  variant: FButtonVariant.ghost,
                  size: FButtonSizeVariant.sm,
                  mainAxisSize: MainAxisSize.min,
                  onPress: atFirst ? null : () => ref.read(_todosQueryProvider.notifier).resetToFirst(),
                  child: const Text('처음'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AddTodoRow extends ConsumerStatefulWidget {
  const _AddTodoRow();

  @override
  ConsumerState<_AddTodoRow> createState() => _AddTodoRowState();
}

class _AddTodoRowState extends ConsumerState<_AddTodoRow> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    await ref.read(dummyJsonTodosNotifierProvider.notifier).addTodo(_controller.text);
    if (mounted) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FTextField(
            label: const Text('새 할 일'),
            hint: 'DummyJSON POST /todos/add',
            spellCheckConfiguration: SpellCheckConfiguration.disabled(),
            autocorrect: false,
            enableSuggestions: false,
            control: FTextFieldControl.managed(controller: _controller),
            onSubmit: (_) => _submit(),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: FButton(
            size: FButtonSizeVariant.sm,
            onPress: _submit,
            child: const Text('추가'),
          ),
        ),
      ],
    );
  }
}

class _TodoList extends ConsumerWidget {
  const _TodoList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dummyJsonTodosNotifierProvider);
    final filter = ref.watch(_todoListFilterProvider);
    final selectedId = ref.watch(_selectedTodoIdProvider);
    final keepPrevious = ref.watch(_keepPreviousTodosWhileLoadingProvider);
    final theme = context.theme;

    return async.when(
      skipLoadingOnReload: keepPrevious,
      skipLoadingOnRefresh: keepPrevious,
      data: (page) {
        final visible = _filtered(page.items, filter);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'skip ${page.skip} · limit ${page.limit} · total ${page.total} · 표시 ${visible.length}건',
              style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 320,
              child: visible.isEmpty
                  ? Center(
                      child: Text(
                        '이 필터에 맞는 항목이 없습니다.',
                        style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground),
                      ),
                    )
                  : ListView.separated(
                      itemCount: visible.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 6),
                      itemBuilder: (context, i) {
                        final t = visible[i];
                        final selected = selectedId == t.id;
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selected ? theme.colors.primary : theme.colors.border,
                              width: selected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: selected
                                ? theme.colors.primary.withValues(alpha: 0.06)
                                : theme.colors.background,
                          ),
                          child: FItem(
                            prefix: FCheckbox(
                              value: t.completed,
                              onChange: (_) =>
                                  ref.read(dummyJsonTodosNotifierProvider.notifier).toggle(t),
                            ),
                            title: Text(
                              t.todo,
                              style: theme.typography.sm.copyWith(
                                decoration: t.completed ? TextDecoration.lineThrough : null,
                                color: t.completed ? theme.colors.mutedForeground : null,
                              ),
                            ),
                            subtitle: Text(
                              '#${t.id} · userId ${t.userId}',
                              style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
                            ),
                            onPress: () => ref.read(_selectedTodoIdProvider.notifier).select(t.id),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '로드 실패',
              style: theme.typography.sm.copyWith(
                color: theme.colors.destructive,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            SelectableText('$e', style: theme.typography.xs),
            const SizedBox(height: 12),
            FButton(
              size: FButtonSizeVariant.sm,
              onPress: () => ref.invalidate(dummyJsonTodosNotifierProvider),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: FCircularProgress.loader()),
      ),
    );
  }
}

/// [DummyJSON Todos](https://dummyjson.com/docs/todos/) + Riverpod [AsyncNotifier] 학습 화면.
class RiverpodDummyJsonTodosPage extends ConsumerWidget {
  const RiverpodDummyJsonTodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(dummyJsonTodosNotifierProvider, (prev, next) {
      if (next.hasError && (prev == null || !prev.hasError)) {
        showFToast(
          context: context,
          title: const Text('Todos'),
          description: Text('${next.error}'),
          icon: Icon(FIcons.circleAlert, color: context.theme.colors.destructive),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Todos — DummyJSON + AsyncNotifier',
          body: '[dummyjson.com](https://dummyjson.com/) Todos API를 [Dio]로 호출하고, '
              '[AsyncNotifierProvider]로 목록·페이지네이션을 묶습니다.\n\n'
              '• `build()` 안에서 `ref.watch(_todosQueryProvider)` → skip/limit 바뀌면 자동 재요청\n'
              '• `refresh` / `ref.invalidate` 로 [AsyncValue] 재로딩\n'
              '• `AsyncValue.when(skipLoadingOnReload / skipLoadingOnRefresh)` — 툴바 스위치로 '
              '「이전 목록 유지」vs「전체 로딩」을 비교\n'
              '• `NotifierProvider` 필터·선택·쿼리는 UI 상태만 (파생은 위젯에서 `where`)\n'
              '• `toggle` / `addTodo` 는 낙관적 UI + API 시뮬레이션 응답 반영',
        ),
        DocExampleBlock(
          title: '도구 모음',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Toolbar(),
              const SizedBox(height: 8),
              const _FilterChips(),
              const SizedBox(height: 16),
              const _AddTodoRow(),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'AsyncValue + 목록',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TodoList(),
              const SizedBox(height: 12),
              DocCallout(
                title: '코드 스케치',
                child: Text(
                  '@override\n'
                  'Future<TodosPageData> build() async {\n'
                  '  final client = ref.watch(_dummyJsonTodosClientProvider);\n'
                  '  final q = ref.watch(_todosQueryProvider);\n'
                  '  return client.fetchPage(limit: q.limit, skip: q.skip);\n'
                  '}',
                  style: context.theme.typography.xs.copyWith(
                    fontFamily: 'monospace',
                    height: 1.35,
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
