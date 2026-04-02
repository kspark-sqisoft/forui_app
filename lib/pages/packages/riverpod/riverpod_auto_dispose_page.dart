import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

final _adCounterProvider = NotifierProvider.autoDispose<_AdCounter, int>(_AdCounter.new);

class _AdCounter extends Notifier<int> {
  @override
  int build() => 0;

  void inc() => state++;
}

class _AutoDisposePanel extends ConsumerWidget {
  const _AutoDisposePanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(_adCounterProvider);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('autoDispose 카운터: $n', style: context.theme.typography.sm),
            const SizedBox(width: 12),
            FButton(
              size: FButtonSizeVariant.sm,
              onPress: () => ref.read(_adCounterProvider.notifier).inc(),
              child: const Text('+1'),
            ),
          ],
        ),
      ),
    );
  }
}

class RiverpodAutoDisposePage extends StatefulWidget {
  const RiverpodAutoDisposePage({super.key});

  @override
  State<RiverpodAutoDisposePage> createState() => _RiverpodAutoDisposePageState();
}

class _RiverpodAutoDisposePageState extends State<RiverpodAutoDisposePage> {
  bool _showPanel = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Automatic disposal',
          body: '구독자가 없어지면 상태를 버리고 싶을 때 NotifierProvider.autoDispose / Provider.autoDispose 등을 씁니다. '
              '아래 패널을 숨기면 위젯이 dispose되고, 다시 보이면 카운터가 0부터 다시 시작합니다.\n\n'
              '공식: riverpod.dev — Concepts — Automatic disposal',
        ),
        DocExampleBlock(
          title: '패널 표시 토글',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: () => setState(() => _showPanel = !_showPanel),
                child: Text(_showPanel ? '패널 숨기기 (dispose)' : '패널 보이기 (다시 생성)'),
              ),
              const SizedBox(height: 12),
              if (_showPanel) const _AutoDisposePanel(),
            ],
          ),
        ),
      ],
    );
  }
}
