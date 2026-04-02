import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../application/selected_forui_theme.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

// =============================================================================
// 이 파일이 설명하는 것: Forui에서 "커스텀 테마"를 만들고 "어디에 적용"하는지
// =============================================================================
//
// 1) FThemeData 란?
//    - 색(FColors), 글꼴(FTypography), 공통 토큰(FStyle)뿐 아니라
//      FButtonStyles, FCardStyle 같은 "위젯별 스타일"까지 한 덩어리로 들고 있습니다.
//    - 즉 "primary 색"만 있는 게 아니라, 그 primary를 이미 반영해 만들어 둔 버튼·카드 스타일도
//      같은 인스턴스 안에 들어 있습니다.
//
// 2) 왜 copyWith(colors: ...)만으로는 버튼 색이 안 바뀌었나?
//    - copyWith로 colors만 갈아끼우면, 예전 colors로 이미 생성된 buttonStyles / cardStyle 필드는
//      그대로 남습니다. 위젯은 대부분 그 필드를 읽기 때문에 화면이 안 바뀝니다.
//    - 그래서 색·코너 등을 바꾼 뒤에는 FThemeData( colors:, typography:, style:, touch: ) 팩토리로
//      "처음부터 다시 inherit" 시켜, 모든 위젯 스타일이 새 colors/style을 보게 해야 합니다.
//      (공식 가이드: https://forui.dev/docs/guides/customizing-themes )
//
// 3) "적용"은 어디서 하나? → FTheme 위젯
//    - FTheme(data: …, child: …)는 InheritedWidget 계열로, child 트리의 context.theme이
//      이 data를 보게 합니다.
//    - 앱 전체: main.dart 쪽 최상위 FTheme + MaterialApp.router (전역 테마).
//    - 이 페이지 데모: 회색 테두리 박스 안에만 또 하나의 FTheme를 두어 "이 박스 안만" 덮어씁니다.
//
// 4) 전역 테마는 어디서 오나?
//    - selected_forui_theme.dart 의 resolvedForuiThemeProvider → Zinc/Neutral 등 FThemes.*.desktop
//    - 이 페이지는 그걸 base로 받아서, 데모용으로만 수정한 FThemeData를 중첩 FTheme에 넘깁니다.

/// Forui **테마 커스터마이징** 샘플 — CLI 스캐폴딩과 코드로의 덮어쓰기를 한 화면에서 봅니다.
///
/// 가이드: https://forui.dev/docs/guides/customizing-themes
class CustomizingThemesPage extends ConsumerStatefulWidget {
  const CustomizingThemesPage({super.key});

  @override
  ConsumerState<CustomizingThemesPage> createState() => _CustomizingThemesPageState();
}

class _CustomizingThemesPageState extends ConsumerState<CustomizingThemesPage> {
  // --- 데모 상태: 이 값들이 바뀌면 setState → _scopedDemo가 새 FThemeData를 만들고 FTheme가 그립니다.

  /// true면 primary / primaryForeground를 사용자 선택 액센트로 바꾼 [FColors]를 씁니다.
  bool _customPrimary = true;

  /// [_customPrimary]가 true일 때 버튼 Primary 등에 쓸 색.
  Color _accent = const Color(0xFF7C3AED);

  /// true면 [FStyle.borderRadius] 토큰 전체를 scale(0.45) — 카드·필드 등 모서리가 더 각져 보임.
  bool _sharpCorners = false;

  static const _accentPresets = <({String label, Color color})>[
    (label: '보라', color: Color(0xFF7C3AED)),
    (label: '청록', color: Color(0xFF0D9488)),
    (label: '주황', color: Color(0xFFEA580C)),
  ];

  /// **커스텀 테마 "생성"의 핵심:** 기존 테마를 복사하는 게 아니라, 바꾼 입력으로 **새 FThemeData를 조립**합니다.
  ///
  /// 단계:
  /// 1. [base]: 앱에서 쓰는 전역 테마(예: Zinc light desktop) — 변경하지 않고 읽기만 함.
  /// 2. [colors]: 전역 팔레트를 그대로 쓰거나, copyWith로 primary만 덮어쓴 복사본.
  /// 3. [style]: 전역과 동일하거나, borderRadius만 줄인 복사본.
  /// 4. `FThemeData(colors:, typography:, style:, touch: …)` 호출
  ///    → 내부에서 typography/style이 없으면 inherit하고,
  ///       buttonStyles·cardStyle 등 **모든 위젯 스타일을 새 colors+style로 다시 만듦**.
  ///
  /// 이렇게 만든 값을 아래 [build]의 `FTheme(data: demo, …)`에 넣으면 "적용"됩니다.
  FThemeData _scopedDemo(FThemeData base) {
    // (A) 색 커스터마이즈: FColors는 값 객체이므로 copyWith로 새 인스턴스를 만듦.
    //     아직 FThemeData는 만들지 않음 — 곧 팩토리에 넣을 재료일 뿐.
    final colors = _customPrimary
        ? base.colors.copyWith(
            primary: _accent,
            primaryForeground: const Color(0xFFFFFFFF),
          )
        : base.colors;

    // (B) 모서리: FStyle도 copyWith로 borderRadius 토큰만 교체한 새 FStyle.
    final style = _sharpCorners
        ? base.style.copyWith(
            borderRadius: base.style.borderRadius.scale(0.45),
          )
        : base.style;

    // (C) 여기서 "커스텀 테마 생성": 팩토리가 colors + typography + style을 받아
    //     버튼/카드/… 스타일을 전부 다시 inherit → 화면에 반영됨.
    //
    // touch: 이 학습 앱은 resolvedForuiThemeProvider가 모두 *.desktop (touch: false) 이므로 맞춤.
    //        터치용 테마를 쓰는 앱이면 여기도 true로 통일해야 패딩·히트영역이 일관됩니다.
    // extensions: 전역 테마에 ThemeExtension을 붙였다면 같이 넘겨 유지.
    return FThemeData(
      colors: colors,
      typography: base.typography,
      style: style,
      touch: false,
      breakpoints: base.breakpoints,
      debugLabel: base.debugLabel,
      extensions: base.extensions,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 전역 테마: Riverpod → 앱 루트 FTheme와 동일 소스.
    final base = ref.watch(resolvedForuiThemeProvider);

    // 이 위젯 트리 안에서 "데모 박스"에 넣을 전용 테마 (매 build마다 위 로직으로 생성).
    final demo = _scopedDemo(base);

    // 주의: 여기 context는 **중첩 FTheme 바깥** → 사이드바/전역과 같은 context.theme.
    //       데모 박스 안에서는 반드시 Builder 등으로 안쪽 context를 따로 잡아야 함 (아래 참고).
    final typo = context.theme.typography;
    final muted = context.theme.colors.mutedForeground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: '테마 커스터마이징',
          body: '공식 가이드는 Forui CLI로 main.dart·테마·위젯 스타일 파일을 만들고, '
              '생성된 FThemeData를 FTheme에 넘기는 흐름을 설명합니다.\n\n'
              '이 페이지는 같은 원리를 코드만으로 보여 줍니다: 개념 > 테마에서 고른 전역 팔레트(resolvedForuiThemeProvider)를 '
              '기준으로, 아래 중첩 FTheme 안에서만 FThemeData(colors·typography·style…) 팩토리로 색·코너를 바꿉니다 '
              '(copyWith로 colors만 바꾸면 버튼·카드 등 위젯 스타일은 그대로인 점이 포인트입니다).\n\n'
              '문서: https://forui.dev/docs/guides/customizing-themes',
        ),
        DocExampleBlock(
          title: '1) Forui CLI (프로젝트 루트에서)',
          child: DocCallout(
            title: '자주 쓰는 명령',
            // CLI는 프로젝트에 theme.dart / widget 스타일 파일을 생성해, 위와 같은 FThemeData를
            // 파일로 관리하고 싶을 때 씁니다. 런타임에만 바꿀 거면 코드로 FThemeData(…) 해도 동일 원리입니다.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('dart run forui init'),
                SizedBox(height: 6),
                Text('dart run forui theme ls'),
                Text('dart run forui theme create neutral-light'),
                SizedBox(height: 6),
                Text('dart run forui style ls'),
                Text('dart run forui style create accordion'),
              ],
            ),
          ),
        ),
        DocExampleBlock(
          title: '2) 코드: 중첩 FTheme + FThemeData 재구성 (이 블록 안쪽만)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '토글과 색 칩은 바깥 context.theme을 쓰고, 회색 테두리 안의 카드·버튼만 아래 FTheme이 적용합니다.',
                style: typo.sm.copyWith(color: muted),
              ),
              const SizedBox(height: 12),
              FSwitch(
                label: const Text('primary / primaryForeground 덮어쓰기'),
                description: const Text(
                  '색만 copyWith 하면 버튼·카드 스타일은 갱신되지 않습니다. '
                  '이 데모는 FThemeData(colors, typography, style, touch)로 다시 inherit합니다.',
                ),
                value: _customPrimary,
                onChange: (v) => setState(() => _customPrimary = v),
              ),
              const SizedBox(height: 8),
              if (_customPrimary) ...[
                Text('액센트 색', style: typo.sm.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in _accentPresets)
                      FButton(
                        variant: FButtonVariant.outline,
                        onPress: () => setState(() => _accent = p.color),
                        child: Text(p.label),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              FSwitch(
                label: const Text('모서리 더 각지게 (FStyle.borderRadius 스케일)'),
                description: const Text(
                  'style.copyWith(borderRadius: …) 후 같은 FThemeData 팩토리로 카드·필드 등에 전파합니다.',
                ),
                value: _sharpCorners,
                onChange: (v) => setState(() => _sharpCorners = v),
              ),
              const SizedBox(height: 16),

              // --- "적용" 구간: FTheme(data: demo) 아래 자식만 demo를 봄 ---
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: context.theme.colors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FTheme(
                  data: demo,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    // Builder로 **이 Padding 아래**의 BuildContext를 잡아야 ctx.theme == demo.
                    // build(context)의 context는 여전히 전역 테마를 가리킵니다.
                    child: Builder(
                      builder: (ctx) {
                        final t = ctx.theme;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FCard(
                              title: const Text('FCard'),
                              subtitle: Text(
                                _customPrimary
                                    ? '이 안의 primary는 데모 액센트를 따릅니다.'
                                    : '전역 팔레트 primary를 그대로 씁니다.',
                                style: t.typography.sm,
                              ),
                            ),
                            const SizedBox(height: 12),
                            FButton(
                              onPress: () {},
                              child: const Text('Primary 버튼'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '3) 전역 팔레트는 «테마» 페이지와 동일',
          child: Text(
            '사이드바·앱 루트 FTheme은 selectedForuiThemeProvider → resolvedForuiThemeProvider와 연결되어 있습니다. '
            '실서비스에서는 CLI로 만든 theme.dart를 그 데이터로 쓰면 됩니다.',
            style: typo.sm.copyWith(color: muted),
          ),
        ),
      ],
    );
  }
}
