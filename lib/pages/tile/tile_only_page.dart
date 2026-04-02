import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FTile] — forui.dev/docs/tile/tile
class TileOnlyPage extends StatelessWidget {
  const TileOnlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FTile',
          body: '터치 UI용 목록 행입니다. [FItem]보다 타일 전용 레이아웃·스타일을 씁니다.',
        ),
        DocExampleBlock(
          title: '제목·부제',
          child: FTile(
            title: const Text('알림 허용'),
            subtitle: const Text('푸시 알림을 받습니다'),
            onPress: () {},
          ),
        ),
        DocExampleBlock(
          title: 'details · suffix',
          child: FTile(
            title: const Text('언어'),
            details: const Text('한국어'),
            suffix: Icon(FIcons.chevronRight, size: 18, color: context.theme.colors.mutedForeground),
            onPress: () {},
          ),
        ),
      ],
    );
  }
}
