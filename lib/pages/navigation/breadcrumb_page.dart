import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FBreadcrumb] — 짧은 경로 / 긴 경로 두 예시.
class BreadcrumbPage extends StatelessWidget {
  const BreadcrumbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FBreadcrumb',
          body: '마지막 항목은 current: true. 긴 계층은 collapsed·collapsedTiles 로 접는 API가 문서에 있습니다.',
        ),
        DocExampleBlock(
          title: '짧은 경로 (앱 > 학습 > 현재)',
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem(child: const Text('앱'), onPress: () {}),
              FBreadcrumbItem(child: const Text('학습'), onPress: () {}),
              FBreadcrumbItem(current: true, child: const Text('Breadcrumb')),
            ],
          ),
        ),
        DocExampleBlock(
          title: '깊은 경로',
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem(child: const Text('홈'), onPress: () {}),
              FBreadcrumbItem(child: const Text('프로젝트'), onPress: () {}),
              FBreadcrumbItem(child: const Text('forui_app'), onPress: () {}),
              FBreadcrumbItem(child: const Text('docs'), onPress: () {}),
              FBreadcrumbItem(current: true, child: const Text('breadcrumb.md')),
            ],
          ),
        ),
      ],
    );
  }
}
