import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FLabel] — vertical(폼 필드) / horizontal(한 줄 라벨+컨트롤) 예시.
class LabelPage extends StatelessWidget {
  const LabelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = Border.all(color: context.theme.colors.border);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FLabel',
          body: 'axis: vertical 은 일반 입력 필드, horizontal 은 체크박스·스위치 한 줄 배치에 가깝습니다.',
        ),
        DocExampleBlock(
          title: 'Vertical — 라벨 위, child 아래',
          child: FLabel(
            axis: Axis.vertical,
            label: const Text('커스텀 필드'),
            description: const Text('설명 텍스트'),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: border,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('child 영역 (임의 위젯)', style: context.theme.typography.sm),
            ),
          ),
        ),
        DocExampleBlock(
          title: 'Horizontal — 라벨과 컨트롤을 한 줄에',
          child: FLabel(
            axis: Axis.horizontal,
            label: const Text('옵션'),
            description: const Text('FLabel 이 라벨을 담당하고 child 는 스위치만 둡니다.'),
            child: FSwitch(
              value: true,
              onChange: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}
