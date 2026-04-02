import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [showFToast] — 성공·오류 톤을 나눈 예시.
class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Toast',
          body: 'title·description·icon 조합만 바꿔도 용도가 달라 보입니다.',
        ),
        DocExampleBlock(
          title: '성공 톤',
          child: FButton(
            mainAxisSize: MainAxisSize.min,
            onPress: () {
              showFToast(
                context: context,
                title: const Text('저장됨'),
                description: const Text('변경 사항이 반영되었습니다.'),
                icon: const Icon(FIcons.check),
              );
            },
            child: const Text('성공 토스트'),
          ),
        ),
        DocExampleBlock(
          title: '경고 톤',
          child: FButton(
            variant: .outline,
            mainAxisSize: MainAxisSize.min,
            onPress: () {
              showFToast(
                context: context,
                title: const Text('네트워크 지연'),
                description: const Text('잠시 후 다시 시도해 주세요.'),
                icon: const Icon(FIcons.wifiOff),
              );
            },
            child: const Text('경고 토스트'),
          ),
        ),
      ],
    );
  }
}
