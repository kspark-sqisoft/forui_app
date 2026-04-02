import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FTextField] — forui.dev/docs/form/text-field 의 States / Clearable / Presets 예시를 묶었습니다.
class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  static const _spellOff = SpellCheckConfiguration.disabled();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FTextField',
          body: '문서 Examples: Enabled / Disabled / Clearable / Email·Password·Multiline 프리셋.\n\n'
              'Windows 맞춤법 밑줄을 줄이려면 spellCheckConfiguration·autocorrect·enableSuggestions 를 끕니다.',
        ),
        const DocExampleBlock(
          title: 'States — Enabled',
          child: FTextField(
            label: Text('사용자 이름'),
            hint: 'JaneDoe',
            description: Text('로그인에 쓸 이름입니다.'),
            spellCheckConfiguration: _spellOff,
            autocorrect: false,
            enableSuggestions: false,
          ),
        ),
        const DocExampleBlock(
          title: 'States — Disabled',
          child: FTextField(
            label: Text('사용자 이름'),
            hint: 'JaneDoe',
            description: Text('비활성 필드입니다.'),
            enabled: false,
            spellCheckConfiguration: _spellOff,
            autocorrect: false,
            enableSuggestions: false,
          ),
        ),
        DocExampleBlock(
          title: 'Clearable (값이 있을 때만 지우기 아이콘)',
          child: FTextField(
            control: const FTextFieldControl.managed(
              initial: TextEditingValue(text: 'MyUsername'),
            ),
            label: const Text('사용자 이름'),
            hint: 'JaneDoe',
            description: const Text('clearable 콜백으로 X 버튼 노출을 제어합니다.'),
            clearable: (value) => value.text.isNotEmpty,
            spellCheckConfiguration: _spellOff,
            autocorrect: false,
            enableSuggestions: false,
          ),
        ),
        DocExampleBlock(
          title: 'Preset — FTextField.email',
          child: const FTextField.email(
            control: FTextFieldControl.managed(
              initial: TextEditingValue(text: 'jane@example.com'),
            ),
            spellCheckConfiguration: _spellOff,
          ),
        ),
        DocExampleBlock(
          title: 'Preset — FTextField.password',
          child: FTextField.password(
            control: const FTextFieldControl.managed(
              initial: TextEditingValue(text: 'sample-password'),
            ),
            spellCheckConfiguration: _spellOff,
          ),
        ),
        const DocExampleBlock(
          title: 'Preset — FTextField.multiline',
          child: FTextField.multiline(
            label: Text('리뷰'),
            hint: '서비스 경험을 적어 주세요',
            maxLines: 4,
            spellCheckConfiguration: _spellOff,
            autocorrect: false,
            enableSuggestions: false,
          ),
        ),
      ],
    );
  }
}
