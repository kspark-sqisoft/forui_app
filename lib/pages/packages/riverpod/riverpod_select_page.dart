import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// 데모용 불변 상태. 필드별로 바뀔 때 `select`가 이전/이후를 `==`로 비교합니다.
class ProductShelfState {
  const ProductShelfState({required this.title, required this.stock});

  final String title;
  final int stock;

  ProductShelfState copyWith({String? title, int? stock}) {
    return ProductShelfState(
      title: title ?? this.title,
      stock: stock ?? this.stock,
    );
  }

  Map<String, Object?> toJson() => {'title': title, 'stock': stock};
}

String _prettyShelfJson(ProductShelfState s) {
  return const JsonEncoder.withIndent('  ').convert(s.toJson());
}

final _shelfProvider = NotifierProvider<_ShelfNotifier, ProductShelfState>(_ShelfNotifier.new);

class _ShelfNotifier extends Notifier<ProductShelfState> {
  @override
  ProductShelfState build() => const ProductShelfState(title: '샘플 상품', stock: 10);

  void incrementStock() => state = state.copyWith(stock: state.stock + 1);

  void tweakTitle() => state = state.copyWith(title: '${state.title}*');
}

class RiverpodSelectPage extends ConsumerWidget {
  const RiverpodSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final shelf = ref.watch(_shelfProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageIntro(
          title: 'Provider.select — 리빌드 최소화',
          body: '상태가 객체일 때 ref.watch(provider)만 쓰면 객체 안 어떤 필드라도 바뀔 때마다 '
              '위젯이 다시 빌드됩니다.\n\n'
              'ref.watch(provider.select((state) => state.someField))처럼 필요한 값만 고르면, '
              'Riverpod은 선택한 값의 이전·다음을 비교해 같으면 리스너에게 알리지 않아 rebuild를 줄일 수 있습니다.\n\n'
              '아래에서 재고만 올리면 `제목만 select` 타일의 build 횟수는 그대로인지 확인해 보세요.\n\n'
              '공식: https://riverpod.dev/docs/concepts2/refs — Ref.watch와 select 설명.\n'
              'API: https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ProviderListenable/select.html',
        ),
        DocExampleBlock(
          title: '현재 상태 객체 (JSON)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '`ref.watch(shelfProvider)`로 전체 객체를 구독한 블록입니다. '
                '재고·제목 중 무엇이 바뀌든 아래 JSON이 즉시 갱신됩니다.',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colors.muted.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SelectableText(
                    _prettyShelfJson(shelf),
                    style: theme.typography.xs.copyWith(
                      fontFamily: 'monospace',
                      height: 1.45,
                      color: theme.colors.foreground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '버튼: 재고만 / 제목만 변경',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FButton(
                size: FButtonSizeVariant.sm,
                onPress: () => ref.read(_shelfProvider.notifier).incrementStock(),
                child: const Text('재고 +1'),
              ),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: () => ref.read(_shelfProvider.notifier).tweakTitle(),
                child: const Text('제목에 * 추가'),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '전체 watch vs select(제목) vs select(재고)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '각 카드는 `ConsumerStatefulWidget`으로 build 횟수를 셉니다. '
                '재고만 바꿀 때는 가운데 카드(제목만 select)의 횟수가 늘지 않아야 합니다.',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  final narrow = constraints.maxWidth < 520;
                  final tiles = [
                    _WatchFullTile(theme: theme),
                    _WatchTitleSelectTile(theme: theme),
                    _WatchStockSelectTile(theme: theme),
                  ];
                  if (narrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var i = 0; i < tiles.length; i++) ...[
                          if (i > 0) const SizedBox(height: 10),
                          tiles[i],
                        ],
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: tiles[0]),
                      const SizedBox(width: 10),
                      Expanded(child: tiles[1]),
                      const SizedBox(width: 10),
                      Expanded(child: tiles[2]),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '코드 패턴',
          child: Text(
            '// 전체 객체 — 어떤 필드든 변경 시 rebuild\n'
            'final m = ref.watch(shelfProvider);\n\n'
            '// 제목만 — stock 변경 시 이 위젯은 rebuild 안 함\n'
            'final title = ref.watch(\n'
            '  shelfProvider.select((s) => s.title),\n'
            ');\n\n'
            '// 재고만\n'
            'final stock = ref.watch(\n'
            '  shelfProvider.select((s) => s.stock),\n'
            ');',
            style: theme.typography.xs.copyWith(
              fontFamily: 'monospace',
              height: 1.4,
              color: theme.colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}

class _WatchFullTile extends ConsumerStatefulWidget {
  const _WatchFullTile({required this.theme});

  final FThemeData theme;

  @override
  ConsumerState<_WatchFullTile> createState() => _WatchFullTileState();
}

class _WatchFullTileState extends ConsumerState<_WatchFullTile> {
  int _buildCount = 0;

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    final m = ref.watch(_shelfProvider);
    return _DemoCard(
      theme: widget.theme,
      title: '전체 watch',
      subtitle: 'ref.watch(shelfProvider)',
      buildCount: _buildCount,
      body: Text(
        '제목: ${m.title}\n재고: ${m.stock}',
        style: widget.theme.typography.sm,
      ),
    );
  }
}

class _WatchTitleSelectTile extends ConsumerStatefulWidget {
  const _WatchTitleSelectTile({required this.theme});

  final FThemeData theme;

  @override
  ConsumerState<_WatchTitleSelectTile> createState() => _WatchTitleSelectTileState();
}

class _WatchTitleSelectTileState extends ConsumerState<_WatchTitleSelectTile> {
  int _buildCount = 0;

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    final title = ref.watch(_shelfProvider.select((s) => s.title));
    return _DemoCard(
      theme: widget.theme,
      title: '제목만 select',
      subtitle: '.select((s) => s.title)',
      buildCount: _buildCount,
      body: Text('제목: $title', style: widget.theme.typography.sm),
    );
  }
}

class _WatchStockSelectTile extends ConsumerStatefulWidget {
  const _WatchStockSelectTile({required this.theme});

  final FThemeData theme;

  @override
  ConsumerState<_WatchStockSelectTile> createState() => _WatchStockSelectTileState();
}

class _WatchStockSelectTileState extends ConsumerState<_WatchStockSelectTile> {
  int _buildCount = 0;

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    final stock = ref.watch(_shelfProvider.select((s) => s.stock));
    return _DemoCard(
      theme: widget.theme,
      title: '재고만 select',
      subtitle: '.select((s) => s.stock)',
      buildCount: _buildCount,
      body: Text('재고: $stock', style: widget.theme.typography.sm),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.theme,
    required this.title,
    required this.subtitle,
    required this.buildCount,
    required this.body,
  });

  final FThemeData theme;
  final String title;
  final String subtitle;
  final int buildCount;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border),
        borderRadius: BorderRadius.circular(10),
        color: theme.colors.muted.withValues(alpha: 0.12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.typography.sm.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: theme.typography.xs.copyWith(
                fontFamily: 'monospace',
                color: theme.colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '이 카드 build 횟수: $buildCount',
              style: theme.typography.xs.copyWith(color: theme.colors.primary),
            ),
            const SizedBox(height: 8),
            body,
          ],
        ),
      ),
    );
  }
}
