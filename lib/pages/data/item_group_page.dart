import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FItemGroup] — forui.dev/docs/data/item-group
class ItemGroupPage extends StatelessWidget {
  const ItemGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FItemGroup',
          body: '여러 [FItem]을 구분선으로 묶습니다. 루트 그룹은 스크롤·테두리 스타일이 적용됩니다.',
        ),
        DocExampleBlock(
          title: 'FItemGroup + FItem 여러 개',
          child: FItemGroup(
            divider: FItemDivider.full,
            children: [
              FItem(
                title: const Text('Wi-Fi'),
                details: const Text('연결됨'),
                onPress: () {},
              ),
              FItem(
                title: const Text('블루투스'),
                onPress: () {},
              ),
              FItem(
                title: const Text('배터리'),
                suffix: Icon(FIcons.chevronRight, size: 18, color: context.theme.colors.mutedForeground),
                onPress: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
