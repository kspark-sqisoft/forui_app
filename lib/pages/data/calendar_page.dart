import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FCalendar] — 단일 날짜 선택 + 문서의 범위 API 안내.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _picked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FCalendar',
          body: 'managedDate 로 하루를 고릅니다. 여러 날·기간은 문서의 managedDates / managedRange 를 참고하세요.',
        ),
        DocExampleBlock(
          title: '단일 날짜 — FCalendarControl.managedDate',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _picked == null
                    ? '선택된 날짜: 없음'
                    : '선택된 날짜: ${_picked!.toIso8601String().split('T').first}',
                style: context.theme.typography.sm,
              ),
              const SizedBox(height: 12),
              FCalendar(
                control: FCalendarControl.managedDate(
                  onChange: (d) => setState(() => _picked = d),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '범위·다중 날짜',
          child: Text(
            'FCalendarControl.managedRange(...) / managedDates(...) 로 동일 위젯에서 모드를 바꿀 수 있습니다. '
            '날짜는 문서 기준 UTC 처리에 유의하세요.',
            style: context.theme.typography.sm.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}
