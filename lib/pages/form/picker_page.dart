import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FPicker] + [FPickerWheel] — forui.dev/docs/form/picker
class PickerPage extends StatelessWidget {
  const PickerPage({super.key});

  static const _hours = ['09', '10', '11', '12', '13', '14', '15', '16', '17', '18'];
  static const _minutes = ['00', '15', '30', '45'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FPicker',
          body: '터치·모바일에서 휠로 값을 고르는 위젯입니다. 데스크톱에서는 [FSelect] 계열을 권장합니다.\n\n'
              '화살표 키로 휠 간 이동·값 증감이 됩니다.',
        ),
        DocExampleBlock(
          title: '시 · 분 두 휠',
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 220,
              child: FPicker(
                control: const FPickerControl.managed(initial: [2, 1]),
                children: [
                  FPickerWheel(
                    loop: false,
                    children: [for (final h in _hours) Text(h)],
                  ),
                  Center(
                    child: Text(':', style: context.theme.typography.xl.copyWith(fontWeight: FontWeight.w600)),
                  ),
                  FPickerWheel(
                    loop: false,
                    children: [for (final m in _minutes) Text(m)],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
