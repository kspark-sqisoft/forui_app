import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../application/selected_forui_theme.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// Forui **테마** 개념 학습 페이지.
///
/// - [FTheme]: 자식 트리에 [FThemeData]를 주입합니다. 색·타이포·컴포넌트 스타일이 여기서 파생됩니다.
/// - [FThemes]: zinc, neutral, slate, blue 등 미리 정의된 팔레트 쌍(light/dark)을 제공합니다.
/// - [FThemeData]: `touch` 플래그로 데스크톱/터치 밀도를 바꿀 수 있습니다(이 앱은 desktop 고정).
///
/// Material의 [ThemeData]와 병행하려면 `ColorScheme.fromSeed`의 `seedColor`·`brightness`를
/// [FThemeData.colors]와 맞추는 것이 안전합니다.
class ThemeConceptPage extends ConsumerWidget {
  const ThemeConceptPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(selectedForuiThemeProvider);
    final notifier = ref.read(selectedForuiThemeProvider.notifier);
    final resolved = ref.watch(resolvedForuiThemeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: '테마 (FTheme / FThemes)',
          body: '아래 버튼은 Riverpod(selectedForuiThemeProvider)로 팔레트를 바꿉니다. '
              'Forui 기본 [FThemes] 10종 × 밝음/어두움(각 desktop) 전부 연결해 두었습니다. '
              'main.dart에서 resolvedForuiThemeProvider를 FTheme과 MaterialApp.theme에 동시에 연결해 두었습니다.',
        ),
        DocExampleBlock(
          title: '팔레트 전환 (20종)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final id in AppForuiThemeId.values)
                FButton(
                  size: FButtonSizeVariant.sm,
                  variant: current == id ? FButtonVariant.primary : FButtonVariant.outline,
                  onPress: () => notifier.pick(id),
                  child: Text(id.galleryLabel),
                ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '한 벌의 테마 안에 뭐가 들어 있나? (지금 고른 것 기준)',
          child: _SelectedThemeBreakdown(
            themeId: current,
            data: resolved,
          ),
        ),
        DocExampleBlock(
          title: 'FTheme 패턴',
          child: DocCallout(
            title: '코드',
            child: Text(
              'FTheme(\n'
              '  data: FThemes.zinc.light.desktop,\n'
              '  child: child,\n'
              ');\n'
              '// 자식에서 context.theme 으로 FThemeData 접근',
              style: context.theme.typography.xs,
            ),
          ),
        ),
      ],
    );
  }
}

/// [FThemeData] 한 인스턴스를 **구성 요소별**로 풀어 보여 줍니다.
///
/// - [FColors]: UI 전반에 쓰는 **색 이름 → Color** (primary, card, border …).
/// - [FTypography]: **글자 크기·줄간격** 등 스케일(xs, sm, md …).
/// - [FStyle]: **모서리·테두리 두께·필드 높이** 등 공통 토큰. 위젯 스타일(FButtonStyle 등)은
///   이 값들을 inherit 해서 만들어 집니다.
class _SelectedThemeBreakdown extends StatelessWidget {
  const _SelectedThemeBreakdown({
    required this.themeId,
    required this.data,
  });

  final AppForuiThemeId themeId;
  final FThemeData data;

  static String _hexRgb(Color c) {
    final v = c.toARGB32() & 0xFFFFFF;
    return '#${v.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final typo = data.typography;
    final colors = data.colors;
    final style = data.style;
    final br = style.borderRadius;
    final mdR = br.md.topLeft.x;
    final lgR = br.lg.topLeft.x;

    final caption = typo.xs.copyWith(color: colors.mutedForeground);
    final body = typo.sm.copyWith(color: colors.foreground);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '아래는 resolvedForuiThemeProvider가 돌려주는 FThemeData 한 개입니다. '
          '위에서 다른 팔레트를 고르면 이 블록의 숫자·색도 같이 바뀝니다.',
          style: body,
        ),
        const SizedBox(height: 8),
        Text('선택: ${themeId.galleryLabel}', style: typo.sm.copyWith(fontWeight: FontWeight.w600)),
        Text(
          'debugLabel: ${data.debugLabel ?? "(없음)"}',
          style: caption,
        ),
        const SizedBox(height: 16),

        Text('1) FColors — 의미별 색 토큰', style: typo.sm.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(
          'primary·secondary·muted·destructive·error 와, 그 위에 올리는 글자용 *Foreground, '
          '배경(background)·카드(card)·테두리(border)·딤(barrier) 등이 한 세트입니다.',
          style: caption,
        ),
        const SizedBox(height: 8),
        Text('brightness: ${colors.brightness}', style: caption),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: [
            _ColorSwatch(name: 'background', color: colors.background, caption: caption),
            _ColorSwatch(name: 'foreground', color: colors.foreground, caption: caption),
            _ColorSwatch(name: 'primary', color: colors.primary, caption: caption),
            _ColorSwatch(name: 'primaryFg', color: colors.primaryForeground, caption: caption),
            _ColorSwatch(name: 'secondary', color: colors.secondary, caption: caption),
            _ColorSwatch(name: 'secondaryFg', color: colors.secondaryForeground, caption: caption),
            _ColorSwatch(name: 'muted', color: colors.muted, caption: caption),
            _ColorSwatch(name: 'mutedFg', color: colors.mutedForeground, caption: caption),
            _ColorSwatch(name: 'destructive', color: colors.destructive, caption: caption),
            _ColorSwatch(name: 'destructiveFg', color: colors.destructiveForeground, caption: caption),
            _ColorSwatch(name: 'error', color: colors.error, caption: caption),
            _ColorSwatch(name: 'errorFg', color: colors.errorForeground, caption: caption),
            _ColorSwatch(name: 'card', color: colors.card, caption: caption),
            _ColorSwatch(name: 'border', color: colors.border, caption: caption),
            _ColorSwatch(name: 'barrier', color: colors.barrier, caption: caption),
          ],
        ),

        const SizedBox(height: 20),
        Text('2) FTypography — 글자 스케일 (일부)', style: typo.sm.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(
          '위젯은 보통 typography.xs / .sm / .md … 를 가져가 제목·본문·캡션을 맞춥니다.',
          style: caption,
        ),
        const SizedBox(height: 8),
        _TypoRow(label: 'xs', t: typo.xs, caption: caption),
        _TypoRow(label: 'sm', t: typo.sm, caption: caption),
        _TypoRow(label: 'md', t: typo.md, caption: caption),
        _TypoRow(label: 'lg', t: typo.lg, caption: caption),

        const SizedBox(height: 20),
        Text('3) FStyle — 공통 모양·크기 토큰', style: typo.sm.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(
          '버튼·카드·입력창 등은 각자 FButtonStyle, FCardStyle … 을 갖지만, '
          '그 안의 모서리·테두리 두께 등은 여기 [borderRadius]·[borderWidth] 등을 inherit 합니다.',
          style: caption,
        ),
        const SizedBox(height: 8),
        Text('borderWidth: ${style.borderWidth}px', style: body),
        Text('borderRadius.md (대표): ${mdR.toStringAsFixed(0)}px, .lg: ${lgR.toStringAsFixed(0)}px', style: body),
        Text(
          'sizes.field (버튼·필드 높이): xs=${style.sizes.field.xs}, sm=${style.sizes.field.sm}, '
          'md=${style.sizes.field.md}, lg=${style.sizes.field.lg}',
          style: body,
        ),
        Text('sizes.item: ${style.sizes.item}, tile: ${style.sizes.tile}, calendar: ${style.sizes.calendar}', style: body),
        Text('iconStyle (기본): size=${style.iconStyle.size?.toStringAsFixed(0) ?? "—"}', style: body),

        const SizedBox(height: 16),
        FCard(
          title: const Text('같은 테마의 FCard + FButton'),
          subtitle: Text(
            '이 카드의 테두리·배경색은 위 FColors / FStyle 토큰에서 옵니다.',
            style: data.typography.sm,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FButton(
              onPress: () {},
              child: const Text('Primary'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.name,
    required this.color,
    required this.caption,
  });

  final String name;
  final Color color;
  final TextStyle caption;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0x33000000)),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: caption.copyWith(fontWeight: FontWeight.w600, color: caption.color)),
          Text(_SelectedThemeBreakdown._hexRgb(color), style: caption),
        ],
      ),
    );
  }
}

class _TypoRow extends StatelessWidget {
  const _TypoRow({
    required this.label,
    required this.t,
    required this.caption,
  });

  final String label;
  final TextStyle t;
  final TextStyle caption;

  @override
  Widget build(BuildContext context) {
    final h = t.height;
    final hStr = h == null ? '—' : h.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              '$label — size ${t.fontSize?.toStringAsFixed(0) ?? "—"}, height $hStr',
              style: caption,
            ),
          ),
          Text('Ag 샘플 $label', style: t),
        ],
      ),
    );
  }
}
