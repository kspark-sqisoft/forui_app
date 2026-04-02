import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) 실험용 자리.
///
/// `Provider` / `Notifier` / 테스트 패턴 등을 이 라우트 아래에 페이지·예제로 추가하면 됩니다.
class RiverpodLabPage extends StatelessWidget {
  const RiverpodLabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Riverpod 실험',
          body: '앱 루트는 이미 [ProviderScope]로 감싸져 있습니다(lib/main.dart).\n\n'
              '여기서부터 AsyncNotifier·family·keepAlive·테스트용 [ProviderContainer] 등을 '
              '페이지별로 쌓아 가면 됩니다. UI는 Forui로 통일해도 되고, 순수 위젯만 써도 됩니다.',
        ),
        DocExampleBlock(
          title: '다음에 넣기 좋은 것들',
          child: Text(
            '• 간단 카운터(Provider vs Notifier)\n'
            '• mock과 함께 쓰는 Repository + AsyncValue UI\n'
            '• widget_test에서 ProviderScope(overrides: …)',
            style: context.theme.typography.sm.copyWith(
              color: context.theme.colors.mutedForeground,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}
