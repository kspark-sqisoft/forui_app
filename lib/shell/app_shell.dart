import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../core/runtime/sdk_runtime_info.dart';
import '../router/menu.dart';

/// Forui [FSidebar] 기본 폭은 256. 중첩·긴 라벨을 위해 조금 넓힙니다.
const double _kAppSidebarWidth = 300;

/// [FScaffold] + [FSidebar] + [go_router] child outlet.
///
/// - 본문 레이아웃·스크롤·오버레이 클립 규칙은 기존과 동일합니다.
/// - 사이드바: [appMenuSections]의 **섹션 헤더** 아래에
///   - 짧은 섹션(프로젝트): [FSidebarGroup] + [FSidebarItem]
///   - 긴 섹션(패키지·Forui): [FSidebarItem] 중첩 접기(섹션 → 카테고리 → 페이지).
///   라우트가 바뀌면 해당 카테고리는 [ValueKey]로 다시 붙어 `initiallyExpanded`가 반영됩니다.
/// - Forui 테마/로케일은 상위 [FTheme]·[MaterialApp]에서 전역 적용됩니다.
class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  List<Widget> _sidebarListTiles(BuildContext context, String location) {
    final theme = context.theme;
    final widgets = <Widget>[];

    for (var si = 0; si < appMenuSections.length; si++) {
      final section = appMenuSections[si];
      if (si > 0) {
        widgets.add(const SizedBox(height: 8));
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, color: theme.colors.border),
          ),
        );
        widgets.add(const SizedBox(height: 8));
      }

      widgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: theme.typography.xs.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: theme.colors.mutedForeground,
                ),
              ),
              if (section.subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    section.subtitle!,
                    style: theme.typography.xs.copyWith(
                      color: theme.colors.mutedForeground.withValues(alpha: 0.9),
                      height: 1.25,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

      if (section.collapsible) {
        final outerExpanded = menuSectionContainsPath(section, location);
        widgets.add(
          FSidebarItem(
            key: ValueKey<String>('sidebar|${section.title}|$outerExpanded'),
            icon: section.collapsibleMenuIcon != null
                ? Icon(section.collapsibleMenuIcon, size: 18)
                : null,
            label: Text(section.collapsibleMenuLabel ?? section.title),
            initiallyExpanded: outerExpanded,
            children: [
              for (final category in section.categories)
                FSidebarItem(
                  key: ValueKey<String>(
                    'sidebar|${section.title}|${category.title}|'
                    '${menuCategoryContainsPath(category, location)}',
                  ),
                  label: Text(category.title),
                  initiallyExpanded: menuCategoryContainsPath(category, location),
                  children: [
                    for (final item in category.items)
                      FSidebarItem(
                        key: ValueKey<String>(item.path),
                        icon: item.icon != null ? Icon(item.icon, size: 18) : null,
                        label: Text(item.title),
                        selected: location == item.path,
                        onPress: () => context.go(item.path),
                      ),
                  ],
                ),
            ],
          ),
        );
      } else {
        for (final category in section.categories) {
          widgets.add(
            FSidebarGroup(
              label: Text(category.title),
              children: [
                for (final item in category.items)
                  FSidebarItem(
                    icon: item.icon != null ? Icon(item.icon, size: 18) : null,
                    label: Text(item.title),
                    selected: location == item.path,
                    onPress: () => context.go(item.path),
                  ),
              ],
            ),
          );
        }
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final bp = context.theme.breakpoints;
    final windowW = MediaQuery.sizeOf(context).width;
    final maxWidth = windowW >= bp.lg
        ? 920.0
        : windowW >= bp.md
        ? 800.0
        : 720.0;

    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
      child: FScaffold(
        header: FHeader(title: Text(titleForPath(location))),
        sidebar: FSidebar(
          style: const FSidebarStyleDelta.delta(
            constraints: BoxConstraints.tightFor(width: _kAppSidebarWidth),
          ),
          header: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '플러터 샌드박스',
                  style: context.theme.typography.lg.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Forui UI · 패키지 실험',
                  style: context.theme.typography.xs.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 10),
                const _SidebarSdkCaption(),
              ],
            ),
          ),
          children: _sidebarListTiles(context, location),
        ),
        child: SelectionArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: LayoutBuilder(
                builder: (context, viewportConstraints) {
                  final padV = 8.0 * 2;
                  final h = viewportConstraints.maxHeight;
                  final minChildHeight = h.isFinite ? (h - padV).clamp(0.0, double.infinity) : 0.0;
                  return SingleChildScrollView(
                    clipBehavior: Clip.none,
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: windowW < bp.sm ? 12 : 0,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxWidth,
                        minHeight: minChildHeight,
                      ),
                      child: KeyedSubtree(
                        key: ValueKey<String>(location),
                        child: SelectionContainer.disabled(child: child),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 사이드바 상단에 [FlutterVersion] 기반 SDK 줄을 둡니다(dart:io 없음).
class _SidebarSdkCaption extends StatelessWidget {
  const _SidebarSdkCaption();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final lineStyle = theme.typography.xs.copyWith(
      color: theme.colors.mutedForeground,
      height: 1.38,
    );
    final revStyle = theme.typography.xs.copyWith(
      color: theme.colors.mutedForeground.withValues(alpha: 0.88),
      height: 1.35,
      fontFamily: 'monospace',
      fontSize: 10,
    );

    final revParts = <String>[
      ?SdkRuntimeInfo.frameworkRevisionHint(),
      ?SdkRuntimeInfo.engineRevisionHint(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          SdkRuntimeInfo.flutterLabel(),
          style: lineStyle,
        ),
        const SizedBox(height: 2),
        SelectableText(
          SdkRuntimeInfo.dartLabel(),
          style: lineStyle,
        ),
        if (revParts.isNotEmpty) ...[
          const SizedBox(height: 4),
          SelectableText(
            revParts.join(' · '),
            style: revStyle,
          ),
        ],
      ],
    );
  }
}
