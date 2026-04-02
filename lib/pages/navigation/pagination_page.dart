import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../features/gallery/gallery_demo.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// [FPagination] — forui.dev/docs/navigation/pagination
///
/// 짧은·긴 목록, [siblings], [showEdges], 커스텀 이전/다음, Riverpod 연동을 한 화면에 둡니다.
class PaginationPage extends ConsumerStatefulWidget {
  const PaginationPage({super.key});

  @override
  ConsumerState<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends ConsumerState<PaginationPage> {
  static const _few = 3;
  static const _many = 12;

  int _fewIndex = 0;
  int _manyIndex = 5;
  int _siblings2Index = 5;
  int _noEdgesIndex = 5;
  int _customNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final typo = context.theme.typography;
    const riverpodTotal = 5;
    final riverpodPage = ref.watch(galleryDemoProvider.select((s) => s.paginationPageIndex));
    final riverpod = ref.read(galleryDemoProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'FPagination',
          body: '페이지 인덱스는 **0 기반**입니다.\n\n'
              '• 짧은 총 페이지면 생략(…) 없이 모두 표시됩니다.\n'
              '• 긴 목록은 양 끝·현재 주변만 보이고 `siblings`로 주변 폭을, `showEdges`로 1·끝 고정을 조절합니다.\n'
              '`previous` / `next`로 화살표 대신 원하는 위젯을 넣을 수 있습니다.',
        ),
        DocExampleBlock(
          title: 'Riverpod — 5페이지 (galleryDemoProvider)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재: ${riverpodPage + 1} / $riverpodTotal', style: typo.sm),
              const SizedBox(height: 12),
              FPagination(
                control: FPaginationControl.lifted(
                  page: riverpodPage,
                  pages: riverpodTotal,
                  onChange: riverpod.setPaginationPageIndex,
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '짧은 목록 — $_few 페이지 (생략 없이 전부)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재: ${_fewIndex + 1} / $_few', style: typo.sm),
              const SizedBox(height: 12),
              FPagination(
                control: FPaginationControl.lifted(
                  page: _fewIndex,
                  pages: _few,
                  onChange: (i) => setState(() => _fewIndex = i),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '긴 목록 — $_many 페이지 · 기본 (siblings 1, showEdges true)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '현재: ${_manyIndex + 1} / $_many — 중간쯤이면 1 … 4 5 6 … 12 형태',
                style: typo.sm,
              ),
              const SizedBox(height: 12),
              FPagination(
                control: FPaginationControl.lifted(
                  page: _manyIndex,
                  pages: _many,
                  onChange: (i) => setState(() => _manyIndex = i),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'siblings: 2 — 현재 양옆 두 페이지씩',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재: ${_siblings2Index + 1} / $_many', style: typo.sm),
              const SizedBox(height: 12),
              FPagination(
                control: FPaginationControl.lifted(
                  page: _siblings2Index,
                  pages: _many,
                  siblings: 2,
                  onChange: (i) => setState(() => _siblings2Index = i),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'showEdges: false — 첫·마지막 번호 고정 칸 없음',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재: ${_noEdgesIndex + 1} / $_many', style: typo.sm),
              const SizedBox(height: 12),
              FPagination(
                control: FPaginationControl.lifted(
                  page: _noEdgesIndex,
                  pages: _many,
                  showEdges: false,
                  onChange: (i) => setState(() => _noEdgesIndex = i),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '커스텀 이전 / 다음 — 한글 라벨',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재: ${_customNavIndex + 1} / $riverpodTotal', style: typo.sm),
              const SizedBox(height: 12),
              FPagination(
                control: FPaginationControl.lifted(
                  page: _customNavIndex,
                  pages: riverpodTotal,
                  onChange: (i) => setState(() => _customNavIndex = i),
                ),
                previous: _PaginationNavChip(
                  label: '이전',
                  icon: FIcons.chevronLeft,
                  onPress: () {
                    if (_customNavIndex > 0) {
                      setState(() => _customNavIndex--);
                    }
                  },
                  enabled: _customNavIndex > 0,
                ),
                next: _PaginationNavChip(
                  label: '다음',
                  icon: FIcons.chevronRight,
                  onPress: () {
                    if (_customNavIndex < riverpodTotal - 1) {
                      setState(() => _customNavIndex++);
                    }
                  },
                  enabled: _customNavIndex < riverpodTotal - 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// [FPagination]의 `previous`/`next`는 내부 [Action]과 동일한 시각을 맞추기 어려워
/// [FPaginationStyle]을 테마에서 읽어 비슷한 패딩·타이포로 맞춥니다.
class _PaginationNavChip extends StatelessWidget {
  const _PaginationNavChip({
    required this.label,
    required this.icon,
    required this.onPress,
    required this.enabled,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPress;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final style = context.theme.paginationStyle;
    return Padding(
      padding: style.itemPadding,
      child: FTappable(
        style: style.actionTappableStyle,
        focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
        semanticsLabel: label,
        onPress: enabled ? onPress : null,
        builder: (context, variants, _) => DecoratedBox(
          decoration: style.itemDecoration.resolve(variants),
          child: ConstrainedBox(
            // 번호 칸과 같은 `itemConstraints`는 가로가 32px로 고정되어
            // 아이콘+한글 라벨 Row가 넘칩니다. 세로·최소 크기만 맞추고 가로는 내용에 맡깁니다.
            constraints: BoxConstraints(
              minWidth: style.itemConstraints.minWidth,
              minHeight: style.itemConstraints.minHeight,
              maxHeight: style.itemConstraints.maxHeight,
              maxWidth: double.infinity,
            ),
            child: DefaultTextStyle(
              style: style.itemTextStyle.resolve(variants),
              child: Center(
                child: IconTheme(
                  data: style.itemIconStyle.resolve(variants),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 16),
                      const SizedBox(width: 4),
                      Text(label),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
