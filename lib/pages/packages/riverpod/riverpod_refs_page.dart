import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

final _refsClockProvider = FutureProvider<String>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 350));
  return '불러옴: ${DateTime.now().toIso8601String()}';
});

class RiverpodRefsPage extends ConsumerWidget {
  const RiverpodRefsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncClock = ref.watch(_refsClockProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Refs',
          body: '[WidgetRef] / [Ref]에서 흔히 쓰는 API:\n'
              '• watch — UI가 상태를 구독할 때\n'
              '• read — 이벤트 핸들러에서 한 번 읽거나 notifier를 가져올 때\n'
              '• listen — 사이드 이펙트\n'
              '• invalidate — provider를 무효화해 다시 빌드·재실행 유도\n\n'
              '공식: riverpod.dev — Concepts — Refs',
        ),
        DocExampleBlock(
          title: 'invalidate로 FutureProvider 재요청',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              asyncClock.when(
                data: (s) => Text(s, style: context.theme.typography.sm),
                error: (e, _) => Text('오류: $e', style: context.theme.typography.sm),
                loading: () => const FCircularProgress.loader(size: .sm),
              ),
              const SizedBox(height: 10),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: () => ref.invalidate(_refsClockProvider),
                child: const Text('ref.invalidate(_refsClockProvider)'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
