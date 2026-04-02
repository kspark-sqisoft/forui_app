import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FBadge] — variant 별 + 숫자 느낌 예시.
class BadgePage extends StatelessWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FBadge',
          body: '문서와 같이 Primary / Secondary / Outline / Destructive 를 나열하고, 짧은 숫자 배지도 둡니다.',
        ),
        DocExampleBlock(
          title: 'Variant',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FBadge(child: const Text('Primary')),
              FBadge(variant: .secondary, child: const Text('Secondary')),
              FBadge(variant: .outline, child: const Text('Outline')),
              FBadge(variant: .destructive, child: const Text('Destructive')),
            ],
          ),
        ),
        DocExampleBlock(
          title: '짧은 라벨 (개수·상태)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FBadge(child: const Text('3')),
              FBadge(variant: .outline, child: const Text('New')),
              FBadge(variant: .destructive, child: const Text('!')),
            ],
          ),
        ),
      ],
    );
  }
}
