import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FCollapsible] — forui.dev/docs/foundation/collapsible
class CollapsiblePage extends StatefulWidget {
  const CollapsiblePage({super.key});

  @override
  State<CollapsiblePage> createState() => _CollapsiblePageState();
}

class _CollapsiblePageState extends State<CollapsiblePage> with SingleTickerProviderStateMixin {
  late final AnimationController _open = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
    value: 1,
  );

  @override
  void dispose() {
    _open.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_open.value > 0.5) {
      _open.reverse();
    } else {
      _open.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FCollapsible',
          body: 'value가 0이면 자식 높이가 0으로 접히고, 1이면 전체가 보입니다. '
              '[AnimationController]로 0↔1을 보간하면 부드럽게 열고 닫을 수 있습니다.',
        ),
        DocExampleBlock(
          title: 'AnimationController + 토글',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListenableBuilder(
                listenable: _open,
                builder: (context, _) {
                  final expanded = _open.value > 0.5;
                  return FButton(
                    mainAxisSize: MainAxisSize.min,
                    onPress: _toggle,
                    child: Text(expanded ? '접기' : '펼치기'),
                  );
                },
              ),
              const SizedBox(height: 12),
              AnimatedBuilder(
                animation: _open,
                builder: (context, _) {
                  return FCollapsible(
                    value: _open.value,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.theme.colors.muted.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '이 영역은 FCollapsible 안에 있습니다. 높이는 value에 비례해 줄어듭니다.',
                          style: context.theme.typography.sm,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
