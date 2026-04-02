import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FDivider] — 수평 / 수직 예시를 블록으로 구분합니다.
class DividerPage extends StatelessWidget {
  const DividerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FDivider',
          body: '기본 Axis.horizontal 과 세로 구분선(Row + Axis.vertical) 두 패턴입니다.',
        ),
        const DocExampleBlock(
          title: 'Horizontal',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('위'),
              FDivider(),
              Text('아래'),
            ],
          ),
        ),
        const DocExampleBlock(
          title: 'Vertical (고정 높이 Row 안)',
          child: SizedBox(
            height: 72,
            child: Row(
              children: [
                Text('좌'),
                FDivider(axis: Axis.vertical),
                Expanded(child: Text('우')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
