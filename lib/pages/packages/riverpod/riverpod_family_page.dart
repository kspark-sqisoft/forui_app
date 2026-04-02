import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

final _labelFamilyProvider = Provider.family<String, String>((ref, id) => '항목 "$id"의 라벨');

class RiverpodFamilyPage extends ConsumerStatefulWidget {
  const RiverpodFamilyPage({super.key});

  @override
  ConsumerState<RiverpodFamilyPage> createState() => _RiverpodFamilyPageState();
}

class _RiverpodFamilyPageState extends ConsumerState<RiverpodFamilyPage> {
  String _selectedId = 'A';

  @override
  Widget build(BuildContext context) {
    final label = ref.watch(_labelFamilyProvider(_selectedId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Family',
          body: 'family는 동일한 로직에 매개변수만 다른 provider 묶음을 만듭니다. '
              '예: userId별 프로필, 탭별 설정. 인자가 바뀌면 다른 provider 인스턴스가 됩니다.\n\n'
              '공식: riverpod.dev — Concepts — Family',
        ),
        DocExampleBlock(
          title: 'Provider.family',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final id in ['A', 'B', 'C'])
                    FButton(
                      size: FButtonSizeVariant.sm,
                      variant: _selectedId == id ? FButtonVariant.primary : FButtonVariant.outline,
                      onPress: () => setState(() => _selectedId = id),
                      child: Text('id = $id'),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(label, style: context.theme.typography.sm),
            ],
          ),
        ),
      ],
    );
  }
}
