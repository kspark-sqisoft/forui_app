import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FTooltip] — tipBuilder 내용·트리거 위젯을 바꾼 두 예시.
class TooltipPage extends StatelessWidget {
  const TooltipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FTooltip',
          body: 'child 가 트리거입니다. 데스크톱은 호버·포커스, 터치는 롱프레스로 열리는 경우가 많습니다.',
        ),
        DocExampleBlock(
          title: '긴 설명 말풍선',
          child: FTooltip(
            tipBuilder: (context, controller) => const Padding(
              padding: EdgeInsets.all(8),
              child: Text('이것은 FTooltip 입니다'),
            ),
            child: FButton(
              onPress: () {},
              child: const Text('마우스를 올리거나 포커스하세요'),
            ),
          ),
        ),
        DocExampleBlock(
          title: '짧은 힌트 + 아웃라인 버튼',
          child: FTooltip(
            tipBuilder: (context, controller) => const Padding(
              padding: EdgeInsets.all(6),
              child: Text('저장'),
            ),
            child: FButton(
              variant: .outline,
              mainAxisSize: MainAxisSize.min,
              onPress: () {},
              child: const Icon(FIcons.save),
            ),
          ),
        ),
      ],
    );
  }
}
