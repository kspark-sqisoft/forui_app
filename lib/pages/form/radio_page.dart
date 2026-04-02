import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../features/gallery/gallery_demo.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FRadio] — 단일 선택 그룹(요금제) + 비활성 항목 예시.
class RadioPage extends ConsumerWidget {
  const RadioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(galleryDemoProvider.select((s) => s.planIndex));
    final notifier = ref.read(galleryDemoProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FRadio',
          body: '같은 그룹에서는 하나만 true 가 되도록 상태(planIndex)로 묶습니다. '
              '문서처럼 비활성 옵션을 섞을 수 있습니다.',
        ),
        DocExampleBlock(
          title: '요금제 선택 (Riverpod planIndex)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FRadio(
                label: const Text('베이직'),
                value: plan == 0,
                onChange: (selected) {
                  if (selected) notifier.setPlanIndex(0);
                },
              ),
              FRadio(
                label: const Text('프로'),
                value: plan == 1,
                onChange: (selected) {
                  if (selected) notifier.setPlanIndex(1);
                },
              ),
              FRadio(
                label: const Text('엔터프라이즈'),
                value: plan == 2,
                onChange: (selected) {
                  if (selected) notifier.setPlanIndex(2);
                },
              ),
            ],
          ),
        ),
        const DocExampleBlock(
          title: '비활성 옵션',
          child: FRadio(
            label: Text('출시 예정 플랜'),
            description: Text('아직 선택할 수 없습니다.'),
            value: false,
            onChange: null,
            enabled: false,
          ),
        ),
      ],
    );
  }
}
