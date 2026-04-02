import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FLineCalendar] — forui.dev/docs/data/line-calendar
class LineCalendarPage extends StatefulWidget {
  const LineCalendarPage({super.key});

  @override
  State<LineCalendarPage> createState() => _LineCalendarPageState();
}

class _LineCalendarPageState extends State<LineCalendarPage> {
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FLineCalendar',
          body: '날짜를 가로 한 줄로 스크롤합니다. 터치 기기에 적합하고, 데스크톱에서는 [FCalendar]를 권장합니다.',
        ),
        DocExampleBlock(
          title: 'FLineCalendarControl.managed',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selected == null
                    ? '선택: 없음'
                    : '선택: ${_selected!.toIso8601String().split('T').first}',
                style: context.theme.typography.sm,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 88,
                child: FLineCalendar(
                  start: DateTime.utc(2026, 3, 20),
                  end: DateTime.utc(2026, 5, 1),
                  today: DateTime.utc(2026, 4, 1),
                  initialScroll: DateTime.utc(2026, 4, 1),
                  control: FLineCalendarControl.managed(
                    initial: DateTime.utc(2026, 4, 1),
                    onChange: (d) => setState(() => _selected = d),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
