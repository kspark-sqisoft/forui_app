import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [showFDialog] — 기본 확인창 + 짧은 경고창 두 패턴.
class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FDialog',
          body: 'actions 구성·본문 길이에 따라 여러 레시피가 있습니다.',
        ),
        DocExampleBlock(
          title: '제목 + 본문 + 닫기/확인',
          child: FButton(
            mainAxisSize: MainAxisSize.min,
            onPress: () {
              showFDialog<void>(
                context: context,
                useRootNavigator: true,
                builder: (ctx, style, animation) => FDialog(
                  animation: animation,
                  title: const Text('다이얼로그'),
                  body: const Text('Forui FDialog + showFDialog 예제입니다.'),
                  actions: [
                    FButton(
                      variant: .secondary,
                      onPress: () => Navigator.pop(ctx),
                      child: const Text('닫기'),
                    ),
                    FButton(
                      onPress: () => Navigator.pop(ctx),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('기본 다이얼로그'),
          ),
        ),
        DocExampleBlock(
          title: '경고형 (destructive 액션)',
          child: FButton(
            variant: .outline,
            mainAxisSize: MainAxisSize.min,
            onPress: () {
              showFDialog<void>(
                context: context,
                useRootNavigator: true,
                builder: (ctx, style, animation) => FDialog(
                  animation: animation,
                  title: const Text('항목 삭제'),
                  body: const Text('이 작업은 되돌릴 수 없습니다. 계속할까요?'),
                  actions: [
                    FButton(
                      variant: .secondary,
                      onPress: () => Navigator.pop(ctx),
                      child: const Text('취소'),
                    ),
                    FButton(
                      variant: .destructive,
                      onPress: () => Navigator.pop(ctx),
                      child: const Text('삭제'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('삭제 확인 열기'),
          ),
        ),
      ],
    );
  }
}
