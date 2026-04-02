import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FPopover] — forui.dev/docs/overlay/popover
class PopoverPage extends StatelessWidget {
  const PopoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FPopover',
          body: '앵커 위젯 기준으로 떠 있는 패널입니다. [FPopoverController.toggle]로 열고 닫습니다.\n\n'
              '[FSelectMenuTile]·[FAutocomplete] 등은 내부에서 포털/팝오버를 씁니다.',
        ),
        DocExampleBlock(
          title: '버튼 토글 + 짧은 설명',
          child: FPopover(
            constraints: const FPortalConstraints(maxWidth: 280),
            // 데스크톱 기본(topCenter/bottomCenter)은 좁은 버튼 기준으로 패널이 가로 가운데 정렬되어
            // 왼쪽 절반이 본문 밖으로 나가 잘립니다. 시작 정렬로 버튼 왼쪽 아래에 맞춥니다.
            popoverAnchor: Alignment.topLeft,
            childAnchor: Alignment.bottomLeft,
            overflow: FPortalOverflow.slide,
            popoverBuilder: (ctx, controller) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popover',
                    style: ctx.theme.typography.lg.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '바깥을 탭하거나 닫기를 누르면 사라집니다.',
                    style: ctx.theme.typography.sm,
                  ),
                  const SizedBox(height: 12),
                  FButton(
                    mainAxisSize: MainAxisSize.min,
                    onPress: controller.hide,
                    child: const Text('닫기'),
                  ),
                ],
              ),
            ),
            builder: (ctx, controller, _) => FButton(
              mainAxisSize: MainAxisSize.min,
              onPress: controller.toggle,
              child: const Text('Popover 열기'),
            ),
          ),
        ),
      ],
    );
  }
}
