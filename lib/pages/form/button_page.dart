import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../core/logging/app_log.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FButton] — forui.dev/docs/form/button 과 유사하게 **여러 예시**를 둡니다.
///
/// variant·size·prefix/suffix·selected·비활성( onPress: null ) 패턴을 한 화면에서 비교합니다.
class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FButton',
          body: '공식 문서 Examples 섹션과 같이 Appearance / Sizes / Toggleable / Content 를 구분했습니다. '
              'Primary 탭 한 번은 AppLog에 남깁니다.',
        ),
        DocExampleBlock(
          title: 'Appearance (variant)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FButton(
                mainAxisSize: MainAxisSize.min,
                onPress: () => AppLog.d('FButton tap: Primary'),
                child: const Text('Primary'),
              ),
              FButton(
                variant: .secondary,
                mainAxisSize: MainAxisSize.min,
                onPress: () {},
                child: const Text('Secondary'),
              ),
              FButton(
                variant: .destructive,
                mainAxisSize: MainAxisSize.min,
                onPress: () {},
                child: const Text('Destructive'),
              ),
              FButton(
                variant: .outline,
                mainAxisSize: MainAxisSize.min,
                onPress: () {},
                child: const Text('Outline'),
              ),
              FButton(
                variant: .ghost,
                mainAxisSize: MainAxisSize.min,
                onPress: () {},
                child: const Text('Ghost'),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'Sizes (텍스트 버튼 xs ~ lg)',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FButton(variant: .outline, size: .xs, mainAxisSize: MainAxisSize.min, onPress: () {}, child: const Text('xs')),
              FButton(variant: .outline, size: .sm, mainAxisSize: MainAxisSize.min, onPress: () {}, child: const Text('sm')),
              FButton(variant: .outline, mainAxisSize: MainAxisSize.min, onPress: () {}, child: const Text('base')),
              FButton(variant: .outline, size: .lg, mainAxisSize: MainAxisSize.min, onPress: () {}, child: const Text('lg')),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'Sizes (FButton.icon)',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FButton.icon(size: .xs, onPress: () {}, child: const Icon(FIcons.chevronRight)),
              FButton.icon(size: .sm, onPress: () {}, child: const Icon(FIcons.chevronRight)),
              FButton.icon(onPress: () {}, child: const Icon(FIcons.chevronRight)),
              FButton.icon(size: .lg, onPress: () {}, child: const Icon(FIcons.chevronRight)),
            ],
          ),
        ),
        const DocExampleBlock(
          title: 'Toggleable (selected + prefix)',
          child: _ButtonItalicToggleDemo(),
        ),
        DocExampleBlock(
          title: 'Content — 텍스트 + 아이콘(prefix)',
          child: FButton(
            mainAxisSize: MainAxisSize.min,
            prefix: const Icon(FIcons.mail),
            onPress: () {},
            child: const Text('이메일로 로그인'),
          ),
        ),
        DocExampleBlock(
          title: 'Content — 아이콘만',
          child: FButton.icon(
            onPress: () {},
            child: const Icon(FIcons.chevronRight),
          ),
        ),
        DocExampleBlock(
          title: 'Content — 대기( onPress: null + FCircularProgress prefix)',
          child: FButton(
            mainAxisSize: MainAxisSize.min,
            prefix: const FCircularProgress.loader(size: .sm),
            onPress: null,
            child: const Text('잠시만 기다리세요'),
          ),
        ),
      ],
    );
  }
}

/// 문서 Toggleable 예제: selected 시 시각적 강조 + 밑줄 텍스트.
class _ButtonItalicToggleDemo extends StatefulWidget {
  const _ButtonItalicToggleDemo();

  @override
  State<_ButtonItalicToggleDemo> createState() => _ButtonItalicToggleDemoState();
}

class _ButtonItalicToggleDemoState extends State<_ButtonItalicToggleDemo> {
  bool _italic = false;

  @override
  Widget build(BuildContext context) {
    return FButton(
      variant: .outline,
      size: .sm,
      mainAxisSize: MainAxisSize.min,
      selected: _italic,
      onPress: () => setState(() => _italic = !_italic),
      prefix: const Icon(FIcons.italic),
      child: Text(
        'Italic',
        style: TextStyle(decoration: _italic ? TextDecoration.underline : null),
      ),
    );
  }
}
