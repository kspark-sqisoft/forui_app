import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FTabs] — 탭 수·라벨 길이 다른 두 예시.
class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sm = context.theme.typography.sm;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FTabs',
          body: 'FTabEntry 목록으로 상단 탭과 본문을 한 위젯에 묶습니다. expands 는 부모 높이가 있을 때만 true 로 두세요.',
        ),
        DocExampleBlock(
          title: '3탭 — 개요 / 설정 / 로그',
          child: FTabs(
            children: [
              FTabEntry(
                label: const Text('개요'),
                child: Text('개요 탭 내용', style: sm),
              ),
              FTabEntry(
                label: const Text('설정'),
                child: Text('설정 탭 내용', style: sm),
              ),
              FTabEntry(
                label: const Text('로그'),
                child: Text('로그 탭 내용', style: sm),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '2탭 — 짧은 라벨',
          child: FTabs(
            children: [
              FTabEntry(
                label: const Text('A'),
                child: Text('탭 A 본문', style: sm),
              ),
              FTabEntry(
                label: const Text('B'),
                child: Text('탭 B 본문', style: sm),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
