import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../widgets/pexels_widgets.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FCard] — forui.dev/docs/data/card 스타일로 이미지·타이틀·raw 예시를 나눕니다.
class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FCard',
          body: '문서 예제처럼 image + title + subtitle, 텍스트만 있는 카드, FCard.raw 커스텀을 둡니다.',
        ),
        DocExampleBlock(
          title: '이미지 영역 + 제목·부제 (Pexels 랜덤, 키 없으면 그라데이션)',
          child: FCard(
            image: const PexelsCardHeaderImage(height: 140),
            title: const Text('감사'),
            subtitle: const Text(
              '고마움을 느끼고 그에 보답하려는 마음가짐을 이야기할 때 쓰는 말입니다.',
            ),
          ),
        ),
        DocExampleBlock(
          title: '제목·부제·본문만',
          child: FCard(
            title: const Text('카드 제목'),
            subtitle: const Text('부제 또는 메타 정보'),
            child: Text('본문 영역', style: context.theme.typography.sm),
          ),
        ),
        DocExampleBlock(
          title: 'FCard.raw — 스타일 틀만 쓰고 내용은 전부 직접 구성',
          child: FCard.raw(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '자유 형식 레이아웃(통계, 대시보드 타일 등)에 적합합니다.',
                style: context.theme.typography.sm,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
