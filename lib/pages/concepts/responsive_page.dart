import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// **반응형** 레이아웃 개념 페이지.
///
/// Forui는 Tailwind와 유사한 [FBreakpoints]를 [FThemeData.breakpoints]에 넣어 둡니다.
/// 일반적으로 [MediaQuery.sizeOf]의 너비와 `sm`(640), `md`(768), `lg`(1024) 등을 비교해
/// 모바일/태블릿/데스크톱 위젯을 갈아 끼웁니다.
///
/// [FAdaptiveScope] / [context.platformVariant]는 **스타일 변형**(iOS/Android/Windows…)에 가깝고,
/// 화면 너비와는 별개입니다.
class ResponsiveConceptPage extends StatelessWidget {
  const ResponsiveConceptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = context.theme.breakpoints;
    // 사이드바·본문 maxWidth 제한과 무관하게 **앱 창 전체** 기준(일반적인 MediaQuery 패턴).
    final w = MediaQuery.sizeOf(context).width;
    final bucket = _bucket(w, bp);

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentW = constraints.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageIntro(
              title: '반응형 (FBreakpoints)',
              body: '아래 구간 판별은 왼쪽 사이드바를 포함한 **앱 창 전체 너비**(`MediaQuery.sizeOf(context).width`) 기준입니다. '
                  '부모 위젯이 준 **본문 콘텐츠 폭**만 쓰려면 `LayoutBuilder`의 `constraints.maxWidth`를 쓰면 됩니다.',
            ),
            DocExampleBlock(
              title: '현재 너비·구간 (기기 관점)',
              child: FCard(
                title: Text('지금은: ${_deviceLabel(w, bp)}'),
                subtitle: Text(
                  '창 전체 너비 ${w.toStringAsFixed(0)} px · '
                  '브레이크포인트 구간: $bucket · '
                  '이 카드가 그려지는 본문 폭(참고) ${contentW.toStringAsFixed(0)} px',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '구간별 표현 — 위 판별은 **창 전체 너비** 기준(기기·dpi·회전에 따라 달라질 수 있음)',
                      style: context.theme.typography.xs.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _segment(
                      context,
                      device: '모바일(스마트폰)',
                      range: '너비 < ${bp.sm}px (< sm)',
                      active: w < bp.sm,
                    ),
                    _segment(
                      context,
                      device: '대형 폰 · 소형 태블릿',
                      range: '${bp.sm}px ≤ 너비 < ${bp.md}px (sm ~ md)',
                      active: w >= bp.sm && w < bp.md,
                    ),
                    _segment(
                      context,
                      device: '태블릿',
                      range: '${bp.md}px ≤ 너비 < ${bp.lg}px (md ~ lg)',
                      active: w >= bp.md && w < bp.lg,
                    ),
                    _segment(
                      context,
                      device: '노트북 · 소형 데스크톱',
                      range: '${bp.lg}px ≤ 너비 < ${bp.xl}px (lg ~ xl)',
                      active: w >= bp.lg && w < bp.xl,
                    ),
                    _segment(
                      context,
                      device: '데스크톱',
                      range: '${bp.xl}px ≤ 너비 < ${bp.xl2}px (xl ~ 2xl)',
                      active: w >= bp.xl && w < bp.xl2,
                    ),
                    _segment(
                      context,
                      device: '와이드 · 울트라와이드',
                      range: '너비 ≥ ${bp.xl2}px (2xl 이상)',
                      active: w >= bp.xl2,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '누적 임계값 (같은 너비에서 여러 줄이 체크될 수 있음)',
                      style: context.theme.typography.xs.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _row('sm (≥${bp.sm})', w >= bp.sm),
                    _row('md (≥${bp.md})', w >= bp.md),
                    _row('lg (≥${bp.lg})', w >= bp.lg),
                    _row('xl (≥${bp.xl})', w >= bp.xl),
                    _row('2xl (≥${bp.xl2})', w >= bp.xl2),
                  ],
                ),
              ),
            ),
            DocExampleBlock(
              title: 'switch 예시 (3단: 폰 / 태블릿 / 데스크톱)',
              child: DocCallout(
                title: '코드',
                child: Text(
                  'final width = MediaQuery.sizeOf(context).width;\n'
                  'final bp = context.theme.breakpoints;\n'
                  'return switch (width) {\n'
                  '  _ when width < bp.sm => SmartPhoneScaffold(), // 모바일\n'
                  '  _ when width < bp.lg => TabletScaffold(),    // 태블릿\n'
                  '  _ => DesktopScaffold(),                     // 데스크톱\n'
                  '};',
                  style: context.theme.typography.xs,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static String _bucket(double w, FBreakpoints bp) {
    if (w < bp.sm) return '< sm';
    if (w < bp.md) return 'sm ~ md';
    if (w < bp.lg) return 'md ~ lg';
    if (w < bp.xl) return 'lg ~ xl';
    if (w < bp.xl2) return 'xl ~ 2xl';
    return '≥ 2xl';
  }

  /// 카드 제목용 — 현재 너비에 대응하는 기기 표현.
  static String _deviceLabel(double w, FBreakpoints bp) {
    if (w < bp.sm) return '모바일(스마트폰)';
    if (w < bp.md) return '대형 폰 · 소형 태블릿';
    if (w < bp.lg) return '태블릿';
    if (w < bp.xl) return '노트북 · 소형 데스크톱';
    if (w < bp.xl2) return '데스크톱';
    return '와이드 · 울트라와이드';
  }

  static Widget _segment(
    BuildContext context, {
    required String device,
    required String range,
    required bool active,
  }) {
    final typo = context.theme.typography;
    final fg = context.theme.colors.foreground;
    final muted = context.theme.colors.mutedForeground;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              active ? FIcons.check : FIcons.minus,
              size: 18,
              color: active ? fg : muted,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device,
                  style: typo.sm.copyWith(
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? fg : muted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(range, style: typo.xs.copyWith(color: muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _row(String label, bool ok) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(ok ? FIcons.check : FIcons.minus, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
