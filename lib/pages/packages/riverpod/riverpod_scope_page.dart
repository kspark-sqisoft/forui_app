import 'package:flutter/material.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// ProviderScope / ProviderContainer 안내(코드 위주).
class RiverpodScopePage extends StatelessWidget {
  const RiverpodScopePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'ProviderScope / ProviderContainer',
          body: 'Flutter 앱은 반드시 최상단에 [ProviderScope]가 있어야 합니다. '
              '이 앱은 lib/main.dart에서 runApp(const ProviderScope(child: …))로 이미 감싸 두었습니다.\n\n'
              '테스트·순수 Dart에서는 [ProviderContainer]를 직접 만들고 container.read / listen을 씁니다. '
              'widget_test에서는 보통 ProviderScope(overrides: …)로 주입합니다.\n\n'
              '공식: riverpod.dev — Concepts — ProviderContainers / ProviderScopes',
        ),
        DocExampleBlock(
          title: '앱 진입점 패턴',
          child: DocCallout(
            title: 'main.dart',
            child: const Text(
              'void main() {\n'
              '  runApp(\n'
              '    ProviderScope(\n'
              '      child: MyApp(),\n'
              '    ),\n'
              '  );\n'
              '}',
            ),
          ),
        ),
        DocExampleBlock(
          title: '테스트에서 Container',
          child: DocCallout(
            title: 'dart test',
            child: const Text(
              'final container = ProviderContainer();\n'
              'addTearDown(container.dispose);\n'
              'expect(container.read(myProvider), …);',
            ),
          ),
        ),
      ],
    );
  }
}
