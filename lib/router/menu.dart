import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// 사이드바 한 줄(라우트 타깃).
final class GalleryMenuItem {
  const GalleryMenuItem({required this.path, required this.title, this.icon});

  final String path;
  final String title;
  final IconData? icon;
}

/// [FSidebarGroup] 단위 — 섹션 아래의 중간 그룹(예: Layout, Form).
final class GalleryMenuCategory {
  const GalleryMenuCategory({required this.title, required this.items});

  final String title;
  final List<GalleryMenuItem> items;
}

/// 큰 주제 구분(프로젝트 / 패키지 실험 / Forui 등). [AppShell]에서 섹션 헤더로 렌더링합니다.
///
/// [collapsible]이 true이면 Forui [FSidebarItem] 접기(자식 있음)로 **섹션 전체 → 카테고리 → 페이지** 트리를 만듭니다.
/// Riverpod 등 하위 항목이 늘어나도 사이드바 길이를 줄일 수 있습니다.
final class GalleryMenuSection {
  const GalleryMenuSection({
    required this.title,
    this.subtitle,
    required this.categories,
    this.collapsible = false,
    this.collapsibleMenuLabel,
    this.collapsibleMenuIcon,
  });

  final String title;
  final String? subtitle;
  final List<GalleryMenuCategory> categories;

  /// [FSidebarGroup] 대신 접는 트리로 그릴지 여부.
  final bool collapsible;

  /// [collapsible]일 때 최상위 접는 줄 라벨. null이면 [title]을 씁니다.
  final String? collapsibleMenuLabel;

  /// [collapsible]일 때 최상위 접는 줄 아이콘.
  final IconData? collapsibleMenuIcon;
}

bool menuCategoryContainsPath(GalleryMenuCategory category, String path) {
  return category.items.any((e) => e.path == path);
}

bool menuSectionContainsPath(GalleryMenuSection section, String path) {
  for (final c in section.categories) {
    if (menuCategoryContainsPath(c, path)) return true;
  }
  return false;
}

/// [AppShell] 네비게이션 순서. 테마·로케일은 앱 전역([FTheme], [MaterialApp])이고, 여기는 **어디로 갈지**만 나눕니다.
const List<GalleryMenuSection> appMenuSections = [
  GalleryMenuSection(
    title: '프로젝트',
    subtitle: '앱 소개 · 진입',
    categories: [
      GalleryMenuCategory(
        title: '시작',
        items: [
          GalleryMenuItem(path: '/home', title: '홈', icon: FIcons.house),
        ],
      ),
    ],
  ),
  GalleryMenuSection(
    title: '패키지 실험',
    subtitle: 'Forui 바깥 라이브러리 데모',
    collapsible: true,
    collapsibleMenuLabel: '라이브러리',
    collapsibleMenuIcon: FIcons.package,
    categories: [
      GalleryMenuCategory(
        title: '리치 텍스트',
        items: [
          GalleryMenuItem(
            path: '/packages/flutter-quill',
            title: 'flutter_quill',
            icon: FIcons.filePen,
          ),
        ],
      ),
      GalleryMenuCategory(
        title: '상태',
        items: [
          GalleryMenuItem(
            path: '/packages/riverpod',
            title: 'Riverpod',
            icon: FIcons.braces,
          ),
        ],
      ),
    ],
  ),
  GalleryMenuSection(
    title: 'Forui',
    subtitle: 'UI 컴포넌트 갤러리',
    collapsible: true,
    collapsibleMenuLabel: '컴포넌트',
    collapsibleMenuIcon: FIcons.layers,
    categories: [
      GalleryMenuCategory(
        title: '개념',
        items: [
          GalleryMenuItem(path: '/concepts/theme', title: '테마', icon: FIcons.palette),
          GalleryMenuItem(
            path: '/concepts/customizing-themes',
            title: '테마 커스터마이징',
            icon: FIcons.paintbrush,
          ),
          GalleryMenuItem(path: '/concepts/localization', title: '로컬라이제이션', icon: FIcons.globe),
          GalleryMenuItem(path: '/concepts/responsive', title: '반응형', icon: FIcons.monitorSmartphone),
        ],
      ),
      GalleryMenuCategory(
        title: 'Layout',
        items: [
          GalleryMenuItem(path: '/layout/divider', title: 'Divider', icon: FIcons.minus),
          GalleryMenuItem(path: '/layout/scaffold', title: 'Scaffold', icon: FIcons.panelLeft),
          GalleryMenuItem(path: '/layout/resizable', title: 'Resizable', icon: FIcons.columns2),
        ],
      ),
      GalleryMenuCategory(
        title: 'Form',
        items: [
          GalleryMenuItem(path: '/form/button', title: 'Button', icon: FIcons.squareMousePointer),
          GalleryMenuItem(path: '/form/text-field', title: 'Text field', icon: FIcons.textCursorInput),
          GalleryMenuItem(path: '/form/label', title: 'Label', icon: FIcons.tag),
          GalleryMenuItem(path: '/form/switch', title: 'Switch', icon: FIcons.toggleLeft),
          GalleryMenuItem(path: '/form/checkbox', title: 'Checkbox', icon: FIcons.squareCheck),
          GalleryMenuItem(path: '/form/radio', title: 'Radio', icon: FIcons.circleDot),
          GalleryMenuItem(path: '/form/slider', title: 'Slider', icon: FIcons.slidersHorizontal),
          GalleryMenuItem(path: '/form/multi-select', title: 'Multi select', icon: FIcons.listChecks),
          GalleryMenuItem(path: '/form/picker', title: 'Picker', icon: FIcons.gripVertical),
          GalleryMenuItem(path: '/form/autocomplete', title: 'Autocomplete', icon: FIcons.textSearch),
        ],
      ),
      GalleryMenuCategory(
        title: 'Data',
        items: [
          GalleryMenuItem(path: '/data/card', title: 'Card', icon: FIcons.squareStack),
          GalleryMenuItem(path: '/data/accordion', title: 'Accordion', icon: FIcons.chevronDown),
          GalleryMenuItem(path: '/data/avatar', title: 'Avatar', icon: FIcons.user),
          GalleryMenuItem(path: '/data/badge', title: 'Badge', icon: FIcons.badgeCheck),
          GalleryMenuItem(path: '/data/calendar', title: 'Calendar', icon: FIcons.calendar),
          GalleryMenuItem(path: '/data/line-calendar', title: 'Line calendar', icon: FIcons.calendarDays),
          GalleryMenuItem(path: '/data/item', title: 'Item', icon: FIcons.list),
          GalleryMenuItem(path: '/data/item-group', title: 'Item group', icon: FIcons.layoutList),
        ],
      ),
      GalleryMenuCategory(
        title: 'Tile',
        items: [
          GalleryMenuItem(path: '/tile/tile', title: 'Tile', icon: FIcons.rows3),
          GalleryMenuItem(path: '/tile/tile-group', title: 'Tile group', icon: FIcons.squareStack),
          GalleryMenuItem(path: '/tile/select-tile-group', title: 'Select tile group', icon: FIcons.listChecks),
          GalleryMenuItem(path: '/tile/select-menu-tile', title: 'Select menu tile', icon: FIcons.listChevronsUpDown),
        ],
      ),
      GalleryMenuCategory(
        title: 'Navigation',
        items: [
          GalleryMenuItem(path: '/navigation/tabs', title: 'Tabs', icon: FIcons.layoutPanelTop),
          GalleryMenuItem(path: '/navigation/breadcrumb', title: 'Breadcrumb', icon: FIcons.chevronRight),
          GalleryMenuItem(path: '/navigation/pagination', title: 'Pagination', icon: FIcons.chevronsLeftRight),
          GalleryMenuItem(path: '/navigation/header', title: 'Header', icon: FIcons.panelTop),
          GalleryMenuItem(path: '/navigation/bottom-nav', title: 'Bottom nav', icon: FIcons.panelBottom),
        ],
      ),
      GalleryMenuCategory(
        title: 'Feedback',
        items: [
          GalleryMenuItem(path: '/feedback/alert', title: 'Alert', icon: FIcons.circleAlert),
          GalleryMenuItem(path: '/feedback/progress', title: 'Progress', icon: FIcons.loader),
        ],
      ),
      GalleryMenuCategory(
        title: 'Overlay',
        items: [
          GalleryMenuItem(path: '/overlay/dialog', title: 'Dialog', icon: FIcons.messageSquare),
          GalleryMenuItem(path: '/overlay/sheet', title: 'Sheet', icon: FIcons.panelBottomOpen),
          GalleryMenuItem(path: '/overlay/popover', title: 'Popover', icon: FIcons.squareMousePointer),
          GalleryMenuItem(path: '/overlay/toast', title: 'Toast', icon: FIcons.bell),
          GalleryMenuItem(path: '/overlay/tooltip', title: 'Tooltip', icon: FIcons.info),
        ],
      ),
      GalleryMenuCategory(
        title: 'Foundation',
        items: [
          GalleryMenuItem(path: '/foundation/collapsible', title: 'Collapsible', icon: FIcons.chevronsDownUp),
        ],
      ),
      GalleryMenuCategory(
        title: 'Reference',
        items: [
          GalleryMenuItem(path: '/reference/icons', title: 'Icons (FIcons)', icon: FIcons.sparkles),
        ],
      ),
    ],
  ),
];

String titleForPath(String path) {
  for (final section in appMenuSections) {
    for (final category in section.categories) {
      for (final item in category.items) {
        if (item.path == path) {
          return item.title;
        }
      }
    }
  }
  return '플러터 샌드박스';
}
