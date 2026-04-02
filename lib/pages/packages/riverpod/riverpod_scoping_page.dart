import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';
import 'riverpod_study_shared.dart';

class RiverpodScopingPage extends ConsumerWidget {
  const RiverpodScopingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final root = ref.watch(studyGreetingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Scoping providers',
          body: '중첩 [ProviderScope]는 **자식 트리에만** override를 적용합니다. '
              '같은 [studyGreetingProvider]라도 깊은 subtree에서는 다른 값을 읽을 수 있습니다.\n\n'
              '공식: riverpod.dev — Concepts — Scoping providers',
        ),
        DocExampleBlock(
          title: '전역 값 vs 스코프 한정 값',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이 페이지 최상단 ref: $root', style: context.theme.typography.sm),
              const SizedBox(height: 12),
              ProviderScope(
                overrides: [
                  studyGreetingProvider.overrideWithValue('깊은 카드 안에서만 보이는 인사'),
                ],
                child: Consumer(
                  builder: (context, ref, _) {
                    final scoped = ref.watch(studyGreetingProvider);
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.theme.colors.muted.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.theme.colors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '중첩 Scope 내부: $scoped',
                          style: context.theme.typography.sm,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
