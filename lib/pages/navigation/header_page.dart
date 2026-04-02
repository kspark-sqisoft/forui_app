import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FHeader] — 루트형 vs nested 미리보기.
class HeaderDemoPage extends StatelessWidget {
  const HeaderDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = Border.all(color: context.theme.colors.border);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FHeader',
          body: 'FHeader 는 스택 루트, FHeader.nested 는 하위 페이지(뒤로가기·액션) 패턴입니다.',
        ),
        DocExampleBlock(
          title: 'FHeader — 루트(제목 시작 정렬)',
          child: DecoratedBox(
            decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FHeader(
                  title: const Text('설정'),
                  suffixes: [
                    FHeaderAction(
                      onPress: () {},
                      icon: const Icon(FIcons.menu),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('본문', style: context.theme.typography.sm),
                ),
              ],
            ),
          ),
        ),
        DocExampleBlock(
          title: 'FHeader.nested — 중앙 제목 + 접두/접미',
          child: SelectionContainer.disabled(
            child: DecoratedBox(
              decoration: BoxDecoration(border: border, borderRadius: BorderRadius.circular(8)),
              child: Column(
                // stretch 이면 nested 헤더에 가로 tight 제약이 들어가 Forui [_RenderNestedHeader]가
                // 접두/접미 Row 너비를 전부 쓴다고 가정해 title maxWidth 가 음수가 될 수 있습니다.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FHeader.nested(
                    title: const Text('상세'),
                    prefixes: [
                      FHeaderAction(
                        onPress: () {},
                        icon: const Icon(FIcons.chevronLeft),
                      ),
                    ],
                    suffixes: [
                      FHeaderAction(
                        onPress: () {},
                        icon: const Icon(FIcons.search),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('본문 영역', style: context.theme.typography.sm),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
