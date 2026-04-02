import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../widgets/pexels_widgets.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FAvatar] — 이니셜 / 이미지 / 크기 비교.
class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final typo = context.theme.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FAvatar',
          body: 'FAvatar.raw 로 텍스트·아이콘, FAvatar 로 이미지+fallback, size 로 히트 영역을 조절합니다.',
        ),
        DocExampleBlock(
          title: '이니셜 (FAvatar.raw)',
          child: FAvatar.raw(
            size: 48,
            child: Text(
              'FU',
              style: typo.lg.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        DocExampleBlock(
          title: '네트워크 이미지 + fallback (Pexels 랜덤)',
          child: const PexelsRandomAvatarDemo(size: 48),
        ),
        DocExampleBlock(
          title: '크기 (32 / 48 / 64)',
          child: Row(
            spacing: 16,
            children: [
              FAvatar.raw(
                size: 32,
                child: Text('A', style: typo.sm.copyWith(fontWeight: FontWeight.w600)),
              ),
              FAvatar.raw(
                size: 48,
                child: Text('B', style: typo.lg.copyWith(fontWeight: FontWeight.w600)),
              ),
              FAvatar.raw(
                size: 64,
                child: Text('C', style: typo.xl.copyWith(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
