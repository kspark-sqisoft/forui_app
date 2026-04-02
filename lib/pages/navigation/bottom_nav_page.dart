import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FBottomNavigationBar] — 3탭 / 4탭 두 구성.
class BottomNavDemoPage extends StatefulWidget {
  const BottomNavDemoPage({super.key});

  @override
  State<BottomNavDemoPage> createState() => _BottomNavDemoPageState();
}

class _BottomNavDemoPageState extends State<BottomNavDemoPage> {
  int _index3 = 0;
  int _index4 = 0;

  @override
  Widget build(BuildContext context) {
    final sm = context.theme.typography.sm;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FBottomNavigationBar',
          body: 'index·onChange 로 선택을 제어합니다. 항목 수만 바꿔도 패턴은 동일합니다.',
        ),
        DocExampleBlock(
          title: '3탭',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('선택: $_index3', style: sm),
              const SizedBox(height: 12),
              FBottomNavigationBar(
                index: _index3,
                onChange: (i) => setState(() => _index3 = i),
                children: const [
                  FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('홈')),
                  FBottomNavigationBarItem(icon: Icon(FIcons.search), label: Text('검색')),
                  FBottomNavigationBarItem(icon: Icon(FIcons.user), label: Text('프로필')),
                ],
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '4탭',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('선택: $_index4', style: sm),
              const SizedBox(height: 12),
              FBottomNavigationBar(
                index: _index4,
                onChange: (i) => setState(() => _index4 = i),
                children: const [
                  FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('홈')),
                  FBottomNavigationBarItem(icon: Icon(FIcons.compass), label: Text('둘러보기')),
                  FBottomNavigationBarItem(icon: Icon(FIcons.bell), label: Text('알림')),
                  FBottomNavigationBarItem(icon: Icon(FIcons.user), label: Text('나')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
