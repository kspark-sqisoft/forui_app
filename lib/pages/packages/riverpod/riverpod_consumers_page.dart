import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

final _listenDemoCounterProvider = NotifierProvider<_ListenDemo, int>(_ListenDemo.new);

class _ListenDemo extends Notifier<int> {
  @override
  int build() => 0;

  void inc() => state++;
}

/// [Consumer]로 트리 일부만 구독하는 예시용 위젯.
class _CounterChunk extends ConsumerWidget {
  const _CounterChunk();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(_listenDemoCounterProvider);
    return Text('Consumer 구간: $n', style: context.theme.typography.sm);
  }
}

class RiverpodConsumersPage extends ConsumerWidget {
  const RiverpodConsumersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<int>(_listenDemoCounterProvider, (prev, next) {
      if (prev != null && next != prev) {
        showFToast(
          context: context,
          title: Text('listen: $prev → $next'),
          description: const Text('ref.listen은 사이드 이펙트(토스트·라우팅 등)에 쓰세요.'),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Consumers',
          body: 'ConsumerWidget / Consumer는 [WidgetRef]로 provider를 읽습니다. '
              'ref.watch는 값이 바뀔 때 위젯을 다시 그립니다. '
              'ref.listen은 값 변화마다 콜백을 호출해 토스트·네비게이션 같은 부수 효과에 적합합니다.\n\n'
              '공식: riverpod.dev — Concepts — Consumers',
        ),
        DocExampleBlock(
          title: 'ConsumerWidget 전체 vs Consumer 일부',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이 페이지 전체가 ConsumerWidget이라 listen·버튼이 같은 ref를 씁니다.',
                style: context.theme.typography.sm.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 8),
              const _CounterChunk(),
              const SizedBox(height: 8),
              FButton(
                size: FButtonSizeVariant.sm,
                onPress: () => ref.read(_listenDemoCounterProvider.notifier).inc(),
                child: const Text('카운트 +1 (listen으로 토스트)'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
