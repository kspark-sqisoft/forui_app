import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [showFSheet] — 바텀 / 트레이(옆에서) 두 방향 예시.
class SheetPage extends StatelessWidget {
  const SheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Sheet (showFSheet)',
          body: 'side: FLayout.btt 는 아래, FLayout.ltr 는 왼쪽에서 들어오는 시트에 가깝습니다.',
        ),
        DocExampleBlock(
          title: 'Bottom — FLayout.btt',
          child: FButton(
            mainAxisSize: MainAxisSize.min,
            onPress: () {
              showFSheet<void>(
                context: context,
                useRootNavigator: true,
                side: FLayout.btt,
                mainAxisMaxRatio: null,
                builder: (ctx) => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '바텀 시트',
                        style: ctx.theme.typography.lg.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '드래그하거나 배리어를 탭해 닫을 수 있습니다.',
                        style: ctx.theme.typography.sm,
                      ),
                      const SizedBox(height: 16),
                      FButton(
                        onPress: () => Navigator.pop(ctx),
                        child: const Text('닫기'),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Text('아래에서 열기'),
          ),
        ),
        DocExampleBlock(
          title: 'Start edge — FLayout.ltr',
          child: FButton(
            variant: .outline,
            mainAxisSize: MainAxisSize.min,
            onPress: () {
              showFSheet<void>(
                context: context,
                useRootNavigator: true,
                side: FLayout.ltr,
                mainAxisMaxRatio: 0.4,
                builder: (ctx) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '측면 시트',
                        style: ctx.theme.typography.lg.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      Text('필터·목차 등에 자주 씁니다.', style: ctx.theme.typography.sm),
                      const SizedBox(height: 24),
                      FButton(
                        onPress: () => Navigator.pop(ctx),
                        child: const Text('닫기'),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Text('왼쪽에서 열기'),
          ),
        ),
      ],
    );
  }
}
