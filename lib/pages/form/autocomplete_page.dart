import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FAutocomplete] — forui.dev/docs/form/autocomplete
class AutocompletePage extends StatelessWidget {
  const AutocompletePage({super.key});

  static const _spellOff = SpellCheckConfiguration.disabled();

  static const _cities = [
    '서울',
    '부산',
    '대구',
    '인천',
    '광주',
    '대전',
    '울산',
    '세종',
    '수원',
    '창원',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FAutocomplete',
          body: '텍스트 필드에 입력하면 제안 목록이 뜹니다. 제안에 없는 문자열도 그대로 입력할 수 있습니다 '
              '(검색 전용 셀렉트가 아닙니다).\n\n'
              '웹에서는 화살표 키로 제안 탐색이 제한될 수 있습니다.',
        ),
        DocExampleBlock(
          title: '도시 이름 (앞 글자 일치 필터)',
          child: Form(
            child: FAutocomplete(
              items: _cities,
              label: const Text('도시'),
              hint: '입력해 보세요',
              description: const Text('기본 필터는 소문자 기준 접두 일치입니다.'),
              spellCheckConfiguration: _spellOff,
              autocorrect: false,
              enableSuggestions: false,
            ),
          ),
        ),
      ],
    );
  }
}
