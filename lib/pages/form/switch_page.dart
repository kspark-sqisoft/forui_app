import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../features/gallery/gallery_demo.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FSwitch] — 문서 Disabled 예제 + Riverpod 연동 예제.
class SwitchPage extends ConsumerWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demo = ref.watch(galleryDemoProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FSwitch',
          body: 'forui.dev Examples: Disabled / Form 등. 여기서는 비활성 패턴과 앱 전역 데모(Riverpod)를 함께 둡니다.',
        ),
        const DocExampleBlock(
          title: 'Disabled (문서 패턴)',
          child: _DisabledSwitchDemo(),
        ),
        DocExampleBlock(
          title: 'Riverpod — 알림 설정 (galleryDemoProvider)',
          child: FSwitch(
            label: const Text('알림 받기'),
            description: const Text('켜면 푸시 알림을 받습니다.'),
            value: demo.notificationsEnabled,
            onChange: (v) => ref.read(galleryDemoProvider.notifier).setNotificationsEnabled(v),
          ),
        ),
      ],
    );
  }
}

class _DisabledSwitchDemo extends StatefulWidget {
  const _DisabledSwitchDemo();

  @override
  State<_DisabledSwitchDemo> createState() => _DisabledSwitchDemoState();
}

class _DisabledSwitchDemoState extends State<_DisabledSwitchDemo> {
  bool _on = false;

  @override
  Widget build(BuildContext context) {
    return FSwitch(
      label: const Text('비행기 모드'),
      semanticsLabel: '비행기 모드',
      value: _on,
      onChange: (v) => setState(() => _on = v),
      enabled: false,
    );
  }
}
