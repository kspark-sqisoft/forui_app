import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// 앱 진입 시 보이는 요약 화면.
///
/// Flutter 기능·서드파티 패키지를 한곳에서 시험하는 샌드박스입니다.
/// [go_router] [ShellRoute]로 [AppShell]([FScaffold]+[FSidebar])을 고정하고 본문만 갈아 끼웁니다.
/// UI 베이스는 Forui([FTheme])이며, 테마·로케일은 앱 전역 `lib/application` 프로바이더와 동기화됩니다.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: '플러터 샌드박스',
          body: '왼쪽은 큰 주제별로 나뉜 네비게이션입니다: 프로젝트(홈), 패키지 실험, Forui 컴포넌트. '
              '패키지·Forui 블록은 「라이브러리」「컴포넌트」줄을 눌러 접었다 펼칠 수 있고, '
              '그 아래 카테고리(개념, Form, 상태 …)도 각각 접을 수 있어 항목이 많아져도 스크롤이 줄어듭니다.\n\n'
              '테마·밝기 전환은 「개념 > 테마」 등에서 바꾸면 앱 전체에 적용됩니다.',
        ),
        DocExampleBlock(
          title: '공식 문서',
          child: FCard(
            title: const Text('forui.dev'),
            subtitle: const Text('https://forui.dev/docs'),
            child: Text(
              '위젯 API, CLI(`dart run forui style create …`), Hooks(forui_hooks) 등은 문서를 기준으로 합니다.',
              style: context.theme.typography.sm,
            ),
          ),
        ),
      ],
    );
  }
}
