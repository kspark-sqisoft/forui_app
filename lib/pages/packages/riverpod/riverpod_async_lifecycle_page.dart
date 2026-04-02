import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// 라이프사이클 이벤트 로그(페이지 전체에서 유지). autoDispose 데모와 분리합니다.
final _lifecycleLogProvider = NotifierProvider<_LifecycleLog, List<String>>(_LifecycleLog.new);

class _LifecycleLog extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void append(String line) {
    final ts = DateTime.now().toIso8601String().substring(11, 23);
    state = [...state, '[$ts] $line'];
    if (state.length > 40) state = state.sublist(state.length - 40);
  }

  void clear() => state = [];
}

/// 다음 [AsyncNotifier] 빌드에서 `throw` 할지 여부.
final _asyncFailNextProvider = NotifierProvider<_AsyncFailNext, bool>(_AsyncFailNext.new);

class _AsyncFailNext extends Notifier<bool> {
  @override
  bool build() => false;

  void setFailNext(bool v) => state = v;
}

final _asyncLessonProvider = AsyncNotifierProvider.autoDispose<_AsyncLesson, String>(_AsyncLesson.new);

class _AsyncLesson extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final log = ref.read(_lifecycleLogProvider.notifier);
    ref.onDispose(() {
      // onDispose 안에서는 다른 provider state 변경 금지 → microtask로 이탈 후 기록.
      Future.microtask(() => log.append('[async provider] onDispose'));
    });
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (ref.read(_asyncFailNextProvider)) {
      throw Exception('의도적으로 던진 오류');
    }
    return '비동기 로드 결과';
  }
}

/// [Ref] 라이프사이클 콜백 시연용 autoDispose Notifier.
final _refLifecycleDemoProvider =
    NotifierProvider.autoDispose<_RefLifecycleDemo, int>(_RefLifecycleDemo.new);

class _RefLifecycleDemo extends Notifier<int> {
  @override
  int build() {
    final log = ref.read(_lifecycleLogProvider.notifier);
    void safe(String msg) => Future.microtask(() => log.append('[autoDispose] $msg'));

    ref.onAddListener(() => safe('onAddListener'));
    ref.onRemoveListener(() => safe('onRemoveListener'));
    ref.onCancel(() => safe('onCancel (구독자 0 → 곧 dispose 예정)'));
    ref.onResume(() => safe('onResume (같은 인스턴스가 다시 active)'));
    ref.onDispose(() => safe('onDispose (인스턴스·상태 파괴)'));

    return 0;
  }

  void increment() => state++;
}

/// [NotifierProvider] 기본(keepAlive). 구독 0이어도 dispose되지 않아 [Ref.onResume]을 로그에서 보기 쉽습니다.
final _keepAliveLifecycleDemoProvider =
    NotifierProvider<_KeepAliveLifecycleDemo, int>(_KeepAliveLifecycleDemo.new);

class _KeepAliveLifecycleDemo extends Notifier<int> {
  @override
  int build() {
    final log = ref.read(_lifecycleLogProvider.notifier);
    void safe(String msg) => Future.microtask(() => log.append('[keepAlive] $msg'));

    ref.onAddListener(() => safe('onAddListener'));
    ref.onRemoveListener(() => safe('onRemoveListener'));
    ref.onCancel(() => safe('onCancel (구독자 0, 인스턴스·state 유지)'));
    ref.onResume(() => safe('onResume (다시 구독 → 같은 state)'));
    ref.onDispose(() => safe('onDispose (앱 종료·Scope dispose 등에서만)'));

    return 0;
  }

  void increment() => state++;
}

class _AsyncDemoCard extends ConsumerWidget {
  const _AsyncDemoCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_asyncLessonProvider);
    final failNext = ref.watch(_asyncFailNextProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        async.when(
          data: (s) => Text('data: $s', style: context.theme.typography.sm),
          error: (e, st) => Text(
            'error: $e',
            style: context.theme.typography.sm.copyWith(color: context.theme.colors.destructive),
          ),
          loading: () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FCircularProgress.loader(size: .sm),
              const SizedBox(width: 10),
              Text('loading…', style: context.theme.typography.sm),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FButton(
              size: FButtonSizeVariant.sm,
              variant: FButtonVariant.outline,
              onPress: () => ref.invalidate(_asyncLessonProvider),
              child: const Text('invalidate → 다시 로딩'),
            ),
            FButton(
              size: FButtonSizeVariant.sm,
              variant: failNext ? FButtonVariant.destructive : FButtonVariant.outline,
              onPress: () => ref.read(_asyncFailNextProvider.notifier).setFailNext(!failNext),
              child: Text(failNext ? '다음 빌드: 실패 ON' : '다음 빌드: 실패 OFF'),
            ),
          ],
        ),
      ],
    );
  }
}

/// 동일 [NotifierProvider]에 [ref.watch]를 건 Consumer를 두 개 두어
/// onAddListener / onRemoveListener가 여러 번 찍히는지 로그로 비교합니다.
class _CounterWatchTile<T extends Notifier<int>> extends ConsumerWidget {
  const _CounterWatchTile({required this.label, required this.provider});

  final String label;
  final NotifierProvider<T, int> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(provider);
    final theme = context.theme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.typography.xs.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'ref.watch → state = $n',
              style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriberOffPlaceholder extends StatelessWidget {
  const _SubscriberOffPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border.withValues(alpha: 0.65)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          '$title\n'
          '→ Consumer 없음 (다른 쪽이 켜져 있으면 onCancel 아님)',
          style: theme.typography.xs.copyWith(
            color: theme.colors.mutedForeground,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _CounterDemoPanel<T extends Notifier<int>> extends StatelessWidget {
  const _CounterDemoPanel({
    required this.showSubscriberA,
    required this.showSubscriberB,
    required this.provider,
    required this.zeroWatchHint,
    required this.onIncrement,
  });

  final bool showSubscriberA;
  final bool showSubscriberB;
  final NotifierProvider<T, int> provider;
  final String zeroWatchHint;
  final void Function(WidgetRef ref) onIncrement;

  @override
  Widget build(BuildContext context) {
    final nWatchers = (showSubscriberA ? 1 : 0) + (showSubscriberB ? 1 : 0);

    final theme = context.theme;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nWatchers == 0
                  ? zeroWatchHint
                  : nWatchers == 1
                  ? 'ref.watch 1개만 마운트됨'
                  : 'ref.watch 2개 — 같은 NotifierProvider, 리스너 2개',
              style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: showSubscriberA
                      ? _CounterWatchTile<T>(label: '구독 A', provider: provider)
                      : const _SubscriberOffPlaceholder(title: '구독 A 끔'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: showSubscriberB
                      ? _CounterWatchTile<T>(label: '구독 B', provider: provider)
                      : const _SubscriberOffPlaceholder(title: '구독 B 끔'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, _) {
                return FButton(
                  size: FButtonSizeVariant.sm,
                  onPress: () => onIncrement(ref),
                  child: const Text('+1 (read만 — 이 버튼은 watch 안 함)'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// [AsyncValue]와 [Ref]의 onDispose / onCancel / onResume / onAddListener / onRemoveListener.
class RiverpodAsyncLifecyclePage extends ConsumerStatefulWidget {
  const RiverpodAsyncLifecyclePage({super.key});

  @override
  ConsumerState<RiverpodAsyncLifecyclePage> createState() => _RiverpodAsyncLifecyclePageState();
}

class _RiverpodAsyncLifecyclePageState extends ConsumerState<RiverpodAsyncLifecyclePage> {
  bool _showLifecyclePanel = true;

  /// 각 Consumer([ref.watch])를 독립적으로 마운트할지 여부.
  bool _showSubscriberA = true;
  bool _showSubscriberB = true;

  bool _showKeepAliveA = true;
  bool _showKeepAliveB = true;

  @override
  Widget build(BuildContext context) {
    final logLines = ref.watch(_lifecycleLogProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'AsyncValue · Ref 라이프사이클',
          body: '[AsyncValue]는 비동기 provider의 loading / data / error 세 가지를 하나의 타입으로 다룹니다. '
              'UI에서는 [when]·[maybeWhen]·[map] 등으로 분기합니다.\n\n'
              '[Ref.onAddListener] / [onRemoveListener]는 구독이 붙거나 떨어질 때, '
              '[onCancel]은 마지막 구독이 사라져 provider가 inactive가 될 때, '
              '[onResume]은 그 상태에서 다시 구독해 같은 인스턴스가 active가 될 때입니다. '
              '[NotifierProvider.autoDispose]는 구독 0 직후 dispose되어 [onResume]이 잘 안 보일 수 있어, '
              '아래에 keepAlive(기본) provider 데모를 따로 두었습니다.\n\n'
              '[onDispose]는 상태가 파괴될 때(리빌드 직전·autoDispose·Scope dispose 등) 호출됩니다.\n\n'
              '아래 로그는 `_lifecycleLogProvider`에 쌓입니다. onDispose·onCancel 등 라이프사이클 콜백 안에서는 '
              '`ref`로 다른 provider를 읽거나 그들의 state를 바꿀 수 없습니다. '
              '로그처럼 부수 효과가 필요하면 `Future.microtask` 등으로 콜백이 끝난 뒤 실행하세요.',
        ),
        DocExampleBlock(
          title: 'AsyncValue — when / error',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _AsyncDemoCard(),
              const SizedBox(height: 12),
              DocCallout(
                title: '패턴',
                child: Text(
                  'ref.watch(asyncProvider).when(\n'
                  '  data: (d) => …,\n'
                  '  error: (e, st) => …,\n'
                  '  loading: () => …,\n'
                  ');',
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
        DocExampleBlock(
          title: 'Ref 라이프사이클 — 구독 A/B 각각 토글 · 패널 숨김',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: () => setState(() => _showLifecyclePanel = !_showLifecyclePanel),
                child: Text(_showLifecyclePanel ? '패널 숨기기 (구독 제거)' : '패널 보이기 (다시 구독)'),
              ),
              if (_showLifecyclePanel) ...[
                const SizedBox(height: 12),
                FSwitch(
                  label: const Text('구독 A — ref.watch 마운트'),
                  description: const Text(
                    '끄면 A Consumer dispose → onRemoveListener. '
                    'B만 남으면 onCancel은 아직 아닙니다. A·B 둘 다 끄면 구독 0.',
                  ),
                  value: _showSubscriberA,
                  onChange: (v) => setState(() => _showSubscriberA = v),
                ),
                const SizedBox(height: 8),
                FSwitch(
                  label: const Text('구독 B — ref.watch 마운트'),
                  description: const Text(
                    'A와 동일하게 독립 동작. 한쪽만 켜거나 둘 다 켠 뒤 로그 순서를 비교해 보세요.',
                  ),
                  value: _showSubscriberB,
                  onChange: (v) => setState(() => _showSubscriberB = v),
                ),
                const SizedBox(height: 12),
                _CounterDemoPanel<_RefLifecycleDemo>(
                  showSubscriberA: _showSubscriberA,
                  showSubscriberB: _showSubscriberB,
                  provider: _refLifecycleDemoProvider,
                  zeroWatchHint:
                      'ref.watch 0개 → onCancel 후 스케줄된 dispose → onDispose (인스턴스 소멸)',
                  onIncrement: (ref) => ref.read(_refLifecycleDemoProvider.notifier).increment(),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                '패널을 통째로 숨기면 마지막 리스너까지 사라져 onCancel 후 autoDispose면 onDispose가 이어집니다.',
                style: context.theme.typography.xs.copyWith(
                  color: context.theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'onCancel / onResume — keepAlive NotifierProvider',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '구독 A·B를 모두 끄면 [onCancel]만 호출되고 인스턴스는 유지됩니다. '
                '다시 A 또는 B를 켜면 같은 state로 [onResume]이 찍힙니다. '
                '+1로 숫자를 올린 뒤 둘 다 끄고 다시 켜 보면 값이 이어지는지 확인할 수 있습니다.',
                style: context.theme.typography.xs.copyWith(
                  color: context.theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              FSwitch(
                label: const Text('keepAlive — 구독 A'),
                description: const Text('autoDispose 데모와 동일하게, watch Consumer만 토글합니다.'),
                value: _showKeepAliveA,
                onChange: (v) => setState(() => _showKeepAliveA = v),
              ),
              const SizedBox(height: 8),
              FSwitch(
                label: const Text('keepAlive — 구독 B'),
                value: _showKeepAliveB,
                onChange: (v) => setState(() => _showKeepAliveB = v),
              ),
              const SizedBox(height: 12),
              _CounterDemoPanel<_KeepAliveLifecycleDemo>(
                showSubscriberA: _showKeepAliveA,
                showSubscriberB: _showKeepAliveB,
                provider: _keepAliveLifecycleDemoProvider,
                zeroWatchHint:
                    'ref.watch 0개 → onCancel (인스턴스 유지). 다시 켜면 onResume + 이전 state',
                onIncrement: (ref) => ref.read(_keepAliveLifecycleDemoProvider.notifier).increment(),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '이벤트 로그',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.ghost,
                onPress: () => ref.read(_lifecycleLogProvider.notifier).clear(),
                child: const Text('로그 비우기'),
              ),
              const SizedBox(height: 8),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: context.theme.colors.border),
                  borderRadius: BorderRadius.circular(8),
                  color: context.theme.colors.muted.withValues(alpha: 0.2),
                ),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: SelectableText(
                      logLines.isEmpty ? '(아직 로그 없음)' : logLines.join('\n'),
                      style: context.theme.typography.xs.copyWith(
                        fontFamily: 'monospace',
                        height: 1.35,
                        color: context.theme.colors.foreground,
                      ),
                    ),
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
