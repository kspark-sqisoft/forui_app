import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FScaffold] 개념 — 이 앱 적용 + FSheets 역할.
class ScaffoldConceptPage extends StatelessWidget {
  const ScaffoldConceptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FScaffold',
          body: '헤더·사이드바·본문·푸터 슬롯을 한 번에 잡습니다. 실제 이 프로젝트는 AppShell 에서 이미 씁니다.',
        ),
        DocExampleBlock(
          title: '이 앱에서의 배치',
          child: FCard(
            title: const Text('AppShell'),
            child: Text(
              'lib/shell/app_shell.dart — FScaffold(\n'
              '  sidebar: FSidebar(...),\n'
              '  header: FHeader(...),\n'
              '  child: SingleChildScrollView 안에 라우트 본문,\n'
              ');',
              style: context.theme.typography.sm,
            ),
          ),
        ),
        DocExampleBlock(
          title: 'FSheets / showFSheet',
          child: FCard(
            subtitle: const Text('스캐폴드가 시트 라우트를 끼우는 트리를 제공합니다'),
            child: Text(
              '모달 시트 예제는 Overlay → Sheet 페이지를 참고하세요.',
              style: context.theme.typography.sm,
            ),
          ),
        ),
      ],
    );
  }
}
