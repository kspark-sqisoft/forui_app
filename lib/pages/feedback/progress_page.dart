import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// Progress 계열 위젯을 용도별로 나눕니다.
class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Progress',
          body: '불확정 선형 / 확정 선형(FDeterminateProgress) / 원형(FCircularProgress) 를 구분합니다. '
              'Forui FProgress(0.20.x)는 내부 LayoutBuilder+Positioned가 전환 프레임과 겹치면 assert가 날 수 있어, '
              '불확정 선형은 동일 색의 Material LinearProgressIndicator로 보여 줍니다.',
        ),
        DocExampleBlock(
          title: '불확정 — 선형 (FProgress 용도, Material로 표시)',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: SizedBox(
              height: 6,
              width: double.infinity,
              child: LinearProgressIndicator(
                minHeight: 6,
                backgroundColor: c.muted,
                color: c.primary,
              ),
            ),
          ),
        ),
        const DocExampleBlock(
          title: '확정 비율 — FDeterminateProgress',
          child: FDeterminateProgress(value: 0.65),
        ),
        const DocExampleBlock(
          title: '원형 — FCircularProgress (sm / 기본 / loader lg)',
          child: Row(
            spacing: 16,
            children: [
              FCircularProgress(size: .sm),
              FCircularProgress(),
              FCircularProgress.loader(size: .lg),
            ],
          ),
        ),
      ],
    );
  }
}
