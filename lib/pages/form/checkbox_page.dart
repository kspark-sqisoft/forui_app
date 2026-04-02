import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../features/gallery/gallery_demo.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FCheckbox] — 동의(상태 연동) / 비활성 / 설명 있는 체크 예시.
class CheckboxPage extends ConsumerWidget {
  const CheckboxPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demo = ref.watch(galleryDemoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FCheckbox',
          body: '문서와 같이 enabled: false, label·description 조합을 구분해 둡니다.',
        ),
        DocExampleBlock(
          title: 'Riverpod — 약관 동의',
          child: FCheckbox(
            label: const Text('약관에 동의합니다'),
            value: demo.termsAccepted,
            onChange: (v) => ref.read(galleryDemoProvider.notifier).setTermsAccepted(v),
          ),
        ),
        const DocExampleBlock(
          title: 'Disabled',
          child: FCheckbox(
            label: Text('비활성 체크박스'),
            value: true,
            onChange: null,
            enabled: false,
          ),
        ),
        const DocExampleBlock(
          title: 'Label + description',
          child: FCheckbox(
            label: Text('마케팅 수신'),
            description: Text('신제품·이벤트 소식을 이메일로 받습니다.'),
            value: false,
            onChange: null,
            enabled: false,
          ),
        ),
      ],
    );
  }
}
