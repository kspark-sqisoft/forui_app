import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// 코드 생성(riverpod_generator).
class RiverpodCodegenPage extends StatelessWidget {
  const RiverpodCodegenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: '코드 생성 (riverpod_generator)',
          body: '이 앱은 이미 @riverpod / riverpod_annotation을 씁니다. '
              '예: lib/application/selected_forui_theme.dart 의 [selectedForuiThemeProvider], '
              'resolvedForuiThemeProvider 등은 build_runner로 *.g.dart가 생성됩니다.\n\n'
              '공식: riverpod.dev — Concepts — About code generation',
        ),
        DocExampleBlock(
          title: '명령',
          child: Text(
            'dart run build_runner build --delete-conflicting-outputs\n'
            '// 또는 watch\n'
            'dart run build_runner watch --delete-conflicting-outputs',
            style: context.theme.typography.xs.copyWith(
              fontFamily: 'monospace',
              height: 1.4,
              color: context.theme.colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}

/// flutter_hooks + hooks_riverpod 안내.
class RiverpodHooksPage extends StatelessWidget {
  const RiverpodHooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Hooks (hooks_riverpod)',
          body: '이 프로젝트는 flutter_riverpod만 의존성에 포함합니다. '
              '[useState]·[useEffect] 같은 React 스타일 훅과 Riverpod을 함께 쓰려면 '
              'pub.dev에서 hooks_riverpod과 flutter_hooks를 추가하고, '
              '[HookConsumerWidget] / [ConsumerStatefulWidget] 패턴을 문서대로 맞추면 됩니다.\n\n'
              '공식: riverpod.dev — Concepts — About hooks',
        ),
        DocExampleBlock(
          title: '설치 (문서 예시)',
          child: Text(
            'flutter pub add hooks_riverpod\n'
            'flutter pub add flutter_hooks',
            style: context.theme.typography.xs.copyWith(
              fontFamily: 'monospace',
              height: 1.4,
              color: context.theme.colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}
