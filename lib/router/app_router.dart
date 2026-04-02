import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/concepts/localization_page.dart';
import '../pages/concepts/responsive_page.dart';
import '../pages/concepts/customizing_themes_page.dart';
import '../pages/concepts/theme_page.dart';
import '../pages/data/accordion_page.dart';
import '../pages/data/avatar_page.dart';
import '../pages/data/badge_page.dart';
import '../pages/data/calendar_page.dart';
import '../pages/data/card_page.dart';
import '../pages/data/item_group_page.dart';
import '../pages/data/item_page.dart';
import '../pages/data/line_calendar_page.dart';
import '../pages/feedback/alert_page.dart';
import '../pages/feedback/progress_page.dart';
import '../pages/form/autocomplete_page.dart';
import '../pages/form/button_page.dart';
import '../pages/form/checkbox_page.dart';
import '../pages/form/label_page.dart';
import '../pages/form/multi_select_page.dart';
import '../pages/form/picker_page.dart';
import '../pages/form/quill_rich_text_page.dart';
import '../pages/packages/riverpod/riverpod_async_lifecycle_page.dart';
import '../pages/packages/riverpod/riverpod_auto_dispose_page.dart';
import '../pages/packages/riverpod/riverpod_consumers_page.dart';
import '../pages/packages/riverpod/riverpod_dummyjson_posts_page.dart';
import '../pages/packages/riverpod/riverpod_dummyjson_todos_page.dart';
import '../pages/packages/riverpod/riverpod_family_page.dart';
import '../pages/packages/riverpod/riverpod_mutations_page.dart';
import '../pages/packages/riverpod/riverpod_offline_persist_page.dart';
import '../pages/packages/riverpod/riverpod_observers_page.dart';
import '../pages/packages/riverpod/riverpod_overrides_page.dart';
import '../pages/packages/riverpod/riverpod_providers_page.dart';
import '../pages/packages/riverpod/riverpod_refs_page.dart';
import '../pages/packages/riverpod/riverpod_select_page.dart';
import '../pages/packages/riverpod/riverpod_scope_page.dart';
import '../pages/packages/riverpod/riverpod_scoping_page.dart';
import '../pages/packages/riverpod/riverpod_retry_page.dart';
import '../pages/packages/riverpod/riverpod_supplemental_pages.dart';
import '../pages/packages/riverpod_lab_page.dart';
import '../pages/form/radio_page.dart';
import '../pages/form/slider_page.dart';
import '../pages/form/switch_page.dart';
import '../pages/form/text_field_page.dart';
import '../pages/home/home_page.dart';
import '../pages/layout/divider_page.dart';
import '../pages/layout/resizable_page.dart';
import '../pages/layout/scaffold_page.dart';
import '../pages/navigation/bottom_nav_page.dart';
import '../pages/navigation/breadcrumb_page.dart';
import '../pages/navigation/header_page.dart';
import '../pages/navigation/pagination_page.dart';
import '../pages/navigation/tabs_page.dart';
import '../pages/foundation/collapsible_page.dart';
import '../pages/overlay/dialog_page.dart';
import '../pages/overlay/popover_page.dart';
import '../pages/overlay/sheet_page.dart';
import '../pages/overlay/toast_page.dart';
import '../pages/overlay/tooltip_page.dart';
import '../pages/reference/icons_page.dart';
import '../pages/tile/select_menu_tile_page.dart';
import '../pages/tile/select_tile_group_page.dart';
import '../pages/tile/tile_group_page.dart';
import '../pages/tile/tile_only_page.dart';
import '../shell/app_shell.dart';

/// [MaterialPage] 기본 전환(Zoom 등)은 전환 중 라우트 child에 뷰포트 높이로 타이트한 제약을 줘
/// [Column] overflow가 납니다. 셸 내부는 내용만 갈아 끼우면 되므로 전환 없이 둡니다.
NoTransitionPage<void> _shellChildPage(GoRouterState state, Widget child) {
  return NoTransitionPage<void>(key: state.pageKey, child: child);
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  redirect: (BuildContext context, GoRouterState state) {
    if (state.uri.path == '/form/rich-text-editor') {
      return '/packages/flutter-quill';
    }
    return null;
  },
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => _shellChildPage(state, const HomePage()),
        ),
        GoRoute(
          path: '/concepts/theme',
          pageBuilder: (context, state) => _shellChildPage(state, const ThemeConceptPage()),
        ),
        GoRoute(
          path: '/concepts/customizing-themes',
          pageBuilder: (context, state) => _shellChildPage(state, const CustomizingThemesPage()),
        ),
        GoRoute(
          path: '/concepts/localization',
          pageBuilder: (context, state) => _shellChildPage(state, const LocalizationConceptPage()),
        ),
        GoRoute(
          path: '/concepts/responsive',
          pageBuilder: (context, state) => _shellChildPage(state, const ResponsiveConceptPage()),
        ),
        GoRoute(
          path: '/layout/divider',
          pageBuilder: (context, state) => _shellChildPage(state, const DividerPage()),
        ),
        GoRoute(
          path: '/layout/scaffold',
          pageBuilder: (context, state) => _shellChildPage(state, const ScaffoldConceptPage()),
        ),
        GoRoute(
          path: '/layout/resizable',
          pageBuilder: (context, state) => _shellChildPage(state, const ResizablePage()),
        ),
        GoRoute(
          path: '/form/button',
          pageBuilder: (context, state) => _shellChildPage(state, const ButtonPage()),
        ),
        GoRoute(
          path: '/form/text-field',
          pageBuilder: (context, state) => _shellChildPage(state, const TextFieldPage()),
        ),
        GoRoute(
          path: '/form/label',
          pageBuilder: (context, state) => _shellChildPage(state, const LabelPage()),
        ),
        GoRoute(
          path: '/form/switch',
          pageBuilder: (context, state) => _shellChildPage(state, const SwitchPage()),
        ),
        GoRoute(
          path: '/form/checkbox',
          pageBuilder: (context, state) => _shellChildPage(state, const CheckboxPage()),
        ),
        GoRoute(
          path: '/form/radio',
          pageBuilder: (context, state) => _shellChildPage(state, const RadioPage()),
        ),
        GoRoute(
          path: '/form/slider',
          pageBuilder: (context, state) => _shellChildPage(state, const SliderPage()),
        ),
        GoRoute(
          path: '/form/multi-select',
          pageBuilder: (context, state) => _shellChildPage(state, const MultiSelectPage()),
        ),
        GoRoute(
          path: '/form/picker',
          pageBuilder: (context, state) => _shellChildPage(state, const PickerPage()),
        ),
        GoRoute(
          path: '/form/autocomplete',
          pageBuilder: (context, state) => _shellChildPage(state, const AutocompletePage()),
        ),
        GoRoute(
          path: '/packages/flutter-quill',
          pageBuilder: (context, state) => _shellChildPage(state, const QuillRichTextPage()),
        ),
        GoRoute(
          path: '/packages/riverpod',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodLabPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/providers',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodProvidersPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/consumers',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodConsumersPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/scope',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodScopePage()),
        ),
        GoRoute(
          path: '/packages/riverpod/refs',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodRefsPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/async-lifecycle',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodAsyncLifecyclePage()),
        ),
        GoRoute(
          path: '/packages/riverpod/dummyjson-todos',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodDummyJsonTodosPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/dummyjson-posts',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodDummyJsonPostsPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/auto-dispose',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodAutoDisposePage()),
        ),
        GoRoute(
          path: '/packages/riverpod/family',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodFamilyPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/select',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodSelectPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/mutations',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodMutationsPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/offline',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodOfflinePersistPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/retry',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodRetryPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/observers',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodObserversPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/overrides',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodOverridesPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/scoping',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodScopingPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/codegen',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodCodegenPage()),
        ),
        GoRoute(
          path: '/packages/riverpod/hooks',
          pageBuilder: (context, state) => _shellChildPage(state, const RiverpodHooksPage()),
        ),
        GoRoute(
          path: '/data/card',
          pageBuilder: (context, state) => _shellChildPage(state, const CardPage()),
        ),
        GoRoute(
          path: '/data/accordion',
          pageBuilder: (context, state) => _shellChildPage(state, const AccordionPage()),
        ),
        GoRoute(
          path: '/data/avatar',
          pageBuilder: (context, state) => _shellChildPage(state, const AvatarPage()),
        ),
        GoRoute(
          path: '/data/badge',
          pageBuilder: (context, state) => _shellChildPage(state, const BadgePage()),
        ),
        GoRoute(
          path: '/data/calendar',
          pageBuilder: (context, state) => _shellChildPage(state, const CalendarPage()),
        ),
        GoRoute(
          path: '/data/line-calendar',
          pageBuilder: (context, state) => _shellChildPage(state, const LineCalendarPage()),
        ),
        GoRoute(
          path: '/data/item',
          pageBuilder: (context, state) => _shellChildPage(state, const ItemPage()),
        ),
        GoRoute(
          path: '/data/item-group',
          pageBuilder: (context, state) => _shellChildPage(state, const ItemGroupPage()),
        ),
        GoRoute(
          path: '/tile/tile',
          pageBuilder: (context, state) => _shellChildPage(state, const TileOnlyPage()),
        ),
        GoRoute(
          path: '/tile/tile-group',
          pageBuilder: (context, state) => _shellChildPage(state, const TileGroupPage()),
        ),
        GoRoute(
          path: '/tile/select-tile-group',
          pageBuilder: (context, state) => _shellChildPage(state, const SelectTileGroupPage()),
        ),
        GoRoute(
          path: '/tile/select-menu-tile',
          pageBuilder: (context, state) => _shellChildPage(state, const SelectMenuTilePage()),
        ),
        GoRoute(
          path: '/navigation/tabs',
          pageBuilder: (context, state) => _shellChildPage(state, const TabsPage()),
        ),
        GoRoute(
          path: '/navigation/breadcrumb',
          pageBuilder: (context, state) => _shellChildPage(state, const BreadcrumbPage()),
        ),
        GoRoute(
          path: '/navigation/pagination',
          pageBuilder: (context, state) => _shellChildPage(state, const PaginationPage()),
        ),
        GoRoute(
          path: '/navigation/header',
          pageBuilder: (context, state) => _shellChildPage(state, const HeaderDemoPage()),
        ),
        GoRoute(
          path: '/navigation/bottom-nav',
          pageBuilder: (context, state) => _shellChildPage(state, const BottomNavDemoPage()),
        ),
        GoRoute(
          path: '/feedback/alert',
          pageBuilder: (context, state) => _shellChildPage(state, const AlertPage()),
        ),
        GoRoute(
          path: '/feedback/progress',
          pageBuilder: (context, state) => _shellChildPage(state, const ProgressPage()),
        ),
        GoRoute(
          path: '/overlay/dialog',
          pageBuilder: (context, state) => _shellChildPage(state, const DialogPage()),
        ),
        GoRoute(
          path: '/overlay/popover',
          pageBuilder: (context, state) => _shellChildPage(state, const PopoverPage()),
        ),
        GoRoute(
          path: '/overlay/toast',
          pageBuilder: (context, state) => _shellChildPage(state, const ToastPage()),
        ),
        GoRoute(
          path: '/overlay/tooltip',
          pageBuilder: (context, state) => _shellChildPage(state, const TooltipPage()),
        ),
        GoRoute(
          path: '/overlay/sheet',
          pageBuilder: (context, state) => _shellChildPage(state, const SheetPage()),
        ),
        GoRoute(
          path: '/foundation/collapsible',
          pageBuilder: (context, state) => _shellChildPage(state, const CollapsiblePage()),
        ),
        GoRoute(
          path: '/reference/icons',
          pageBuilder: (context, state) => _shellChildPage(state, const IconsGalleryPage()),
        ),
      ],
    ),
  ],
);
