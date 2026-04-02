import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FAccordion] — 패널 여러 개·기본 펼침 조합.
class AccordionPage extends StatelessWidget {
  const AccordionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sm = context.theme.typography.sm;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FAccordion',
          body: '한 아코디언에 여러 FAccordionItem 을 두는 패턴과, 첫 패널만 initiallyExpanded 인 패턴입니다.',
        ),
        DocExampleBlock(
          title: '기본 — 첫 패널 펼침',
          child: FAccordion(
            children: [
              FAccordionItem(
                title: const Text('시작하기'),
                initiallyExpanded: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text('온보딩 요약', style: sm),
                ),
              ),
              FAccordionItem(
                title: const Text('API'),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text('엔드포인트·인증 설명', style: sm),
                ),
              ),
              FAccordionItem(
                title: const Text('FAQ'),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text('자주 묻는 질문', style: sm),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '모두 접힌 상태에서 열기',
          child: FAccordion(
            children: [
              FAccordionItem(
                title: const Text('배송'),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text('배송 정책', style: sm),
                ),
              ),
              FAccordionItem(
                title: const Text('환불'),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text('환불 절차', style: sm),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
