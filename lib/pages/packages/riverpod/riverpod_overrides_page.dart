import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';
import 'riverpod_study_shared.dart';

class RiverpodOverridesPage extends ConsumerWidget {
  const RiverpodOverridesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(studyGreetingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Provider overrides',
          body: '테스트나 특정 화면만 다른 구현을 쓰려면 ProviderScope(overrides: …)로 '
              '[studyGreetingProvider] 같은 provider를 교체합니다. '
              '아래는 **이 페이지만** 다른 인사말을 주입한 예입니다.\n\n'
              '공식: riverpod.dev — Concepts — Provider overrides',
        ),
        DocExampleBlock(
          title: 'ProviderScope(overrides: …)',
          child: ProviderScope(
            overrides: [
              studyGreetingProvider.overrideWithValue('오버라이드된 인사 (이 subtree만)'),
            ],
            child: Consumer(
              builder: (context, ref, _) {
                final inner = ref.watch(studyGreetingProvider);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('바깥(페이지): $text', style: context.theme.typography.sm),
                    const SizedBox(height: 8),
                    Text('안쪽(override): $inner', style: context.theme.typography.sm),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
