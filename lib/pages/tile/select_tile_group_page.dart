import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FSelectTileGroup] — forui.dev/docs/tile/select-tile-group
class SelectTileGroupPage extends StatelessWidget {
  const SelectTileGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FSelectTileGroup',
          body: '폼 필드로 묶인 단일/다중 선택 타일 그룹입니다. [FMultiValueControl.managedRadio]로 하나만 고르게 할 수 있습니다.',
        ),
        DocExampleBlock(
          title: '단일 선택 (managedRadio)',
          child: Form(
            child: FSelectTileGroup<String>(
              control: const FMultiValueControl.managedRadio(),
              label: const Text('색 테마'),
              description: const Text('앱에 적용할 팔레트'),
              children: [
                FSelectTile(title: const Text('Zinc'), value: 'zinc'),
                FSelectTile(title: const Text('Slate'), value: 'slate'),
                FSelectTile(title: const Text('Blue'), value: 'blue'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
