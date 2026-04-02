import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FAlert] — Primary / Destructive 등 variant 를 문서처럼 블록으로 나눕니다.
class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FAlert',
          body: 'forui.dev Examples: Primary, Destructive. title·subtitle·icon 조합이 동일합니다.',
        ),
        const DocExampleBlock(
          title: 'Primary',
          child: FAlert(
            variant: .primary,
            title: Text('알림'),
            subtitle: Text('CLI로 컴포넌트 스타일을 생성할 수 있습니다.'),
            icon: Icon(FIcons.info),
          ),
        ),
        const DocExampleBlock(
          title: 'Destructive',
          child: FAlert(
            variant: .destructive,
            title: Text('주의'),
            subtitle: Text('삭제나 되돌릴 수 없는 동작 전에 사용하기 좋습니다.'),
            icon: Icon(FIcons.circleAlert),
          ),
        ),
      ],
    );
  }
}
