import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// 문서: [Mutations (experimental)](https://riverpod.dev/ko/docs/concepts2/mutations)
final _studyAddLineMutation = Mutation<String>();

final _studyKeyedMutation = Mutation<String>();

final _studyMutationListProvider = NotifierProvider<_StudyMutationList, List<String>>(_StudyMutationList.new);

class _StudyMutationList extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void addLine(String line) => state = [...state, line];
}

class RiverpodMutationsPage extends ConsumerWidget {
  const RiverpodMutationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final addState = ref.watch(_studyAddLineMutation);
    final lines = ref.watch(_studyMutationListProvider);
    final keyed1 = ref.watch(_studyKeyedMutation('슬롯1'));
    final keyed2 = ref.watch(_studyKeyedMutation('슬롯2'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageIntro(
          title: 'Mutations (experimental)',
          body: 'API는 실험 단계이며 변경될 수 있습니다.\n\n'
              '`Mutation`은 폼 전송처럼 **일회성 비동기 작업**의 idle / pending / error / success를 '
              'UI와 분리해 다루게 합니다. `ref.watch(mutation)`으로 상태를 보고, '
              '`mutation.run(ref, (tsx) async { … })` 안에서는 `tsx.get(provider)`로 '
              '프로바이더에 접근합니다.\n\n'
              '공식: https://riverpod.dev/ko/docs/concepts2/mutations',
        ),
        DocExampleBlock(
          title: 'Mutation<String> — 성공 / 실패 / reset',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '목록은 `NotifierProvider`, 추가는 `Mutation.run`에서 지연 후 `tsx.get(notifier).addLine` 호출.',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FButton(
                    size: FButtonSizeVariant.sm,
                    onPress: addState.isPending
                        ? null
                        : () {
                            _studyAddLineMutation.run(ref, (tsx) async {
                              await Future<void>.delayed(const Duration(milliseconds: 900));
                              final n = tsx.get(_studyMutationListProvider.notifier);
                              final stamp = DateTime.now().toIso8601String();
                              n.addLine('줄 추가 $stamp');
                              return '완료: $stamp';
                            });
                          },
                    child: const Text('줄 추가 (지연)'),
                  ),
                  FButton(
                    size: FButtonSizeVariant.sm,
                    variant: FButtonVariant.outline,
                    onPress: addState.isPending
                        ? null
                        : () {
                            _studyAddLineMutation.run(ref, (_) async {
                              await Future<void>.delayed(const Duration(milliseconds: 200));
                              throw StateError('의도적 실패');
                            });
                          },
                    child: const Text('의도적 오류'),
                  ),
                  FButton(
                    size: FButtonSizeVariant.sm,
                    variant: FButtonVariant.ghost,
                    onPress: () => _studyAddLineMutation.reset(ref),
                    child: const Text('reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _MutationStatusText(state: addState, theme: theme),
              if (lines.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('목록 (${lines.length})', style: theme.typography.xs.copyWith(fontWeight: FontWeight.w600)),
                ...lines.take(5).map(
                      (l) => Text('· $l', style: theme.typography.xs),
                    ),
                if (lines.length > 5)
                  Text('… 외 ${lines.length - 5}줄', style: theme.typography.xs),
              ],
            ],
          ),
        ),
        DocExampleBlock(
          title: 'mutation(key) — 슬롯별로 상태 분리',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '같은 `Mutation`에 서로 다른 key를 주면 `ref.watch(mutation(key))` / `mutation(key).run` 이 '
                '슬롯마다 독립된 상태를 갖습니다.',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _KeyedMutationColumn(
                      label: '슬롯1',
                      state: keyed1,
                      onRun: () => _studyKeyedMutation('슬롯1').run(ref, (_) async {
                        await Future<void>.delayed(const Duration(milliseconds: 600));
                        return '슬롯1 완료 ${DateTime.now().second}s';
                      }),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _KeyedMutationColumn(
                      label: '슬롯2',
                      state: keyed2,
                      onRun: () => _studyKeyedMutation('슬롯2').run(ref, (_) async {
                        await Future<void>.delayed(const Duration(milliseconds: 600));
                        return '슬롯2 완료 ${DateTime.now().second}s';
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MutationStatusText extends StatelessWidget {
  const _MutationStatusText({required this.state, required this.theme});

  final MutationState<String> state;
  final FThemeData theme;

  @override
  Widget build(BuildContext context) {
    final style = theme.typography.sm;
    final muted = theme.typography.xs.copyWith(color: theme.colors.mutedForeground);
    return switch (state) {
      MutationIdle() => Text('상태: MutationIdle', style: muted),
      MutationPending() => Row(
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: FCircularProgress.loader(),
            ),
            const SizedBox(width: 8),
            Text('상태: MutationPending', style: style),
          ],
        ),
      MutationError(:final error) => Text(
          '상태: MutationError — $error',
          style: style.copyWith(color: theme.colors.destructive),
        ),
      MutationSuccess(:final value) => Text(
          '상태: MutationSuccess — $value',
          style: style,
        ),
    };
  }
}

class _KeyedMutationColumn extends StatelessWidget {
  const _KeyedMutationColumn({
    required this.label,
    required this.state,
    required this.onRun,
  });

  final String label;
  final MutationState<String> state;
  final VoidCallback onRun;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.typography.xs.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        FButton(
          size: FButtonSizeVariant.sm,
          variant: FButtonVariant.outline,
          onPress: state.isPending ? null : onRun,
          child: Text('$label 실행'),
        ),
        const SizedBox(height: 6),
        _MutationStatusText(state: state, theme: theme),
      ],
    );
  }
}
