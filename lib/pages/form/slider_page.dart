import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../features/gallery/gallery_demo.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FSlider] — 연속 단일 값 + 연속 **범위** (문서 continuousRange 패턴).
class SliderPage extends ConsumerWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fraction = ref.watch(galleryDemoProvider.select((s) => s.sliderFraction));
    final notifier = ref.read(galleryDemoProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FSlider',
          body: 'liftedContinuous 로 단일 thumb, liftedContinuousRange 로 최소·최대 두 thumb 을 다룹니다.',
        ),
        DocExampleBlock(
          title: 'Continuous — 단일 값 (Riverpod sliderFraction)',
          child: FSlider(
            control: FSliderControl.liftedContinuous(
              value: FSliderValue(max: fraction),
              onChange: (v) => notifier.setSliderFraction(v.max),
            ),
            label: Text('값: ${(fraction * 100).round()}%'),
          ),
        ),
        const DocExampleBlock(
          title: 'Continuous range — 최소·최대 동시 조절',
          child: _RangeSliderDemo(),
        ),
      ],
    );
  }
}

class _RangeSliderDemo extends StatefulWidget {
  const _RangeSliderDemo();

  @override
  State<_RangeSliderDemo> createState() => _RangeSliderDemoState();
}

class _RangeSliderDemoState extends State<_RangeSliderDemo> {
  FSliderValue _range = FSliderValue(min: 0.2, max: 0.75);

  @override
  Widget build(BuildContext context) {
    return FSlider(
      control: FSliderControl.liftedContinuousRange(
        value: _range,
        onChange: (v) => setState(() => _range = v),
      ),
      label: Text(
        '${(_range.min * 100).round()}% ~ ${(_range.max * 100).round()}%',
      ),
    );
  }
}
