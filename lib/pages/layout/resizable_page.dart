import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FResizable] — 가로 분할 + 세로 분할.
class ResizablePage extends StatelessWidget {
  const ResizablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FResizable',
          body: 'axis 로 가로·세로 스플리터를 바꿉니다. FResizableRegion 의 initialExtent·minExtent 로 초기·최소 폭을 줍니다.',
        ),
        DocExampleBlock(
          title: 'Horizontal — 좌우 2분할',
          child: SizedBox(
            height: 160,
            child: FResizable(
              axis: Axis.horizontal,
              children: [
                FResizableRegion(
                  initialExtent: 160,
                  minExtent: 80,
                  builder: (context, data, child) => ColoredBox(
                    color: context.theme.colors.muted.withValues(alpha: 0.4),
                    child: Center(
                      child: Text('A\n${data.extent.current.toStringAsFixed(0)}px'),
                    ),
                  ),
                ),
                FResizableRegion(
                  initialExtent: 200,
                  minExtent: 80,
                  builder: (context, data, child) => ColoredBox(
                    color: context.theme.colors.secondary.withValues(alpha: 0.25),
                    child: Center(
                      child: Text('B\n${data.extent.current.toStringAsFixed(0)}px'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DocExampleBlock(
          title: 'Vertical — 상하 2분할',
          child: SizedBox(
            height: 200,
            child: FResizable(
              axis: Axis.vertical,
              children: [
                FResizableRegion(
                  initialExtent: 90,
                  minExtent: 48,
                  builder: (context, data, child) => ColoredBox(
                    color: context.theme.colors.primary.withValues(alpha: 0.12),
                    child: Center(child: Text('상단 ${data.extent.current.toStringAsFixed(0)}px')),
                  ),
                ),
                FResizableRegion(
                  initialExtent: 90,
                  minExtent: 48,
                  builder: (context, data, child) => ColoredBox(
                    color: context.theme.colors.muted.withValues(alpha: 0.35),
                    child: Center(child: Text('하단 ${data.extent.current.toStringAsFixed(0)}px')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
