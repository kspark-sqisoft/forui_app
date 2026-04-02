import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FItem] — forui.dev/docs/data/item
class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = Border.all(color: context.theme.colors.border);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FItem',
          body: '목록·설정 행에 쓰는 범용 행 위젯입니다. [FTile]은 터치 UI에 특화된 변형입니다.',
        ),
        DocExampleBlock(
          title: '제목만',
          child: DecoratedBox(
            decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(8)),
            child: FItem(
              title: const Text('알림'),
              onPress: () {},
            ),
          ),
        ),
        DocExampleBlock(
          title: '부제·접미(화살표)',
          child: DecoratedBox(
            decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(8)),
            child: FItem(
              title: const Text('계정'),
              subtitle: const Text('이메일·비밀번호'),
              suffix: Icon(FIcons.chevronRight, size: 18, color: context.theme.colors.mutedForeground),
              onPress: () {},
            ),
          ),
        ),
        DocExampleBlock(
          title: 'destructive 변형',
          child: DecoratedBox(
            decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(8)),
            child: FItem(
              variant: FItemVariant.destructive,
              title: const Text('로그아웃'),
              onPress: () {},
            ),
          ),
        ),
      ],
    );
  }
}
