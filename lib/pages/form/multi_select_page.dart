import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FMultiSelect] — forui.dev/docs/form/multi-select
class MultiSelectPage extends StatelessWidget {
  const MultiSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FMultiSelect',
          body: '여러 옵션을 태그 형태로 고릅니다. 데스크톱에서는 검색형 [FMultiSelect.search]도 자주 씁니다.\n\n'
              '[FMultiValueControl.managed]로 복수 선택(체크)을 씁니다.',
        ),
        DocExampleBlock(
          title: 'Map + 복수 선택',
          child: Form(
            child: FMultiSelect<String>(
              control: const FMultiValueControl.managed(
                initial: {'dart', 'flutter'},
              ),
              label: const Text('관심 기술'),
              description: const Text('필드를 눌러 목록에서 여러 개를 고르세요.'),
              items: const {
                'Dart': 'dart',
                'Flutter': 'flutter',
                'Rust': 'rust',
                'TypeScript': 'ts',
                'Kotlin': 'kotlin',
              },
            ),
          ),
        ),
      ],
    );
  }
}
