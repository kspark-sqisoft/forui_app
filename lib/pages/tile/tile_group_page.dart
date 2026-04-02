import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FTileGroup] — forui.dev/docs/tile/tile-group
class TileGroupPage extends StatelessWidget {
  const TileGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FTileGroup',
          body: '여러 [FTile]을 구분선과 라벨로 묶습니다.',
        ),
        DocExampleBlock(
          title: 'label + tiles',
          child: FTileGroup(
            label: const Text('일반'),
            description: const Text('앱 동작 관련 설정'),
            children: [
              FTile(
                title: const Text('언어'),
                details: const Text('한국어'),
                suffix: Icon(FIcons.chevronRight, size: 18, color: context.theme.colors.mutedForeground),
                onPress: () {},
              ),
              FTile(
                title: const Text('저장 공간'),
                onPress: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
