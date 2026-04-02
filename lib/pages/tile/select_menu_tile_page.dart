import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FSelectMenuTile] — forui.dev/docs/tile/select-menu-tile
class SelectMenuTilePage extends StatelessWidget {
  const SelectMenuTilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FSelectMenuTile',
          body: '타일을 누르면 팝오버 메뉴에서 옵션을 고릅니다. 데스크톱에서는 [FSelectGroup] 사용을 권장합니다.',
        ),
        DocExampleBlock(
          title: 'fromMap — 간단한 문자열 메뉴',
          child: Form(
            child: FSelectMenuTile.fromMap(
              {
                '사과': 'apple',
                '바나나': 'banana',
                '오렌지': 'orange',
              },
              title: const Text('과일'),
              label: const Text('선호 과일'),
              selectControl: const FMultiValueControl.managedRadio(),
            ),
          ),
        ),
      ],
    );
  }
}
