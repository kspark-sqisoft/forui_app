import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';
import 'f_icons_catalog.g.dart';

/// Forui / Lucide 아이콘 — https://forui.dev/docs/reference/icon-library
///
/// [FIconsCatalog]는 `dart run tool/generate_f_icons_catalog.dart`로 갱신합니다(forui_assets 업그레이드 시).
class IconsGalleryPage extends StatefulWidget {
  const IconsGalleryPage({super.key});

  @override
  State<IconsGalleryPage> createState() => _IconsGalleryPageState();
}

class _IconsGalleryPageState extends State<IconsGalleryPage> {
  String _appliedQuery = '';

  List<String> get _visibleNames {
    final q = _appliedQuery;
    if (q.isEmpty) {
      return FIconsCatalog.names;
    }
    return FIconsCatalog.names.where((n) => _iconNameMatchesQuery(n, q)).toList();
  }

  /// camelCase 이름·띄어쓴 단어(예: `arrow` + `down`) 모두 고려.
  static bool _iconNameMatchesQuery(String iconName, String rawQuery) {
    final q = rawQuery.trim().toLowerCase();
    if (q.isEmpty) {
      return true;
    }
    final name = iconName.toLowerCase();
    if (name.contains(q)) {
      return true;
    }
    final spaced = _camelToSpacedWords(iconName);
    final tokens = q.split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (tokens.isEmpty) {
      return true;
    }
    return tokens.every((t) => name.contains(t) || spaced.contains(t));
  }

  static String _camelToSpacedWords(String s) {
    final out = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final c = s[i];
      if (i > 0 && c == c.toUpperCase() && c != c.toLowerCase()) {
        out.write(' ');
      }
      out.write(c);
    }
    return out.toString().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final typo = context.theme.typography;
    final colors = context.theme.colors;
    final visible = _visibleNames;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageIntro(
          title: 'FIcons (forui_assets)',
          body:
              'Forui Assets는 Lucide 기반 아이콘 글리프를 제공합니다. 아래는 **패키지에 포함된 ${FIconsCatalog.count}개** 전부입니다.\n\n'
              '문서: https://forui.dev/docs/reference/icon-library\n'
              'Lucide 검색: https://lucide.dev/icons/\n\n'
              '`import \'package:forui_assets/forui_assets.dart\';` 후 `Icon(FIcons.이름)` — 이름은 camelCase(예: `dog`, `chevronDown`).\n\n'
              'forui_assets 버전을 올렸으면 프로젝트 루트에서 `dart run tool/generate_f_icons_catalog.dart` 로 목록을 다시 생성하세요.',
        ),
        DocExampleBlock(
          title: '기본 사용',
          child: Row(
            children: [
              Icon(FIcons.dog, size: 28, color: colors.primary),
              const SizedBox(width: 12),
              Icon(FIcons.cat, size: 28, color: colors.foreground),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Icon(FIcons.dog, size: 28, color: …)',
                  style: typo.sm,
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '검색 · 전체 목록',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _IconSearchField(
                debounce: const Duration(milliseconds: 350),
                onApply: (q) => setState(() => _appliedQuery = q),
              ),
              const SizedBox(height: 12),
              Text(
                _appliedQuery.isEmpty
                    ? '전체 ${visible.length}개 표시 중'
                    : '“$_appliedQuery” → ${visible.length}개',
                style: typo.sm.copyWith(color: colors.mutedForeground),
              ),
              if (visible.isEmpty) ...[
                const SizedBox(height: 16),
                Text('일치하는 아이콘이 없습니다.', style: typo.sm),
              ] else ...[
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const cellMin = 96.0;
                    final cols = (constraints.maxWidth / cellMin).floor().clamp(2, 12);
                    final rows = (visible.length / cols).ceil();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rows,
                      itemBuilder: (context, row) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var c = 0; c < cols; c++)
                                Expanded(
                                  child: _cellForIndex(
                                    context,
                                    visible,
                                    row * cols + c,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _cellForIndex(
    BuildContext context,
    List<String> visible,
    int index,
  ) {
    if (index >= visible.length) {
      return const SizedBox.shrink();
    }
    final name = visible[index];
    final typo = context.theme.typography;
    final fg = context.theme.colors.foreground;
    final data = FIconsCatalog.iconByName(name);
    return Tooltip(
      message: 'FIcons.$name',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(data, size: 26, color: fg),
            const SizedBox(height: 4),
            Text(
              name,
              style: typo.xs,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _IconSearchField extends StatefulWidget {
  const _IconSearchField({
    required this.debounce,
    required this.onApply,
  });

  final Duration debounce;
  final ValueChanged<String> onApply;

  @override
  State<_IconSearchField> createState() => _IconSearchFieldState();
}

class _IconSearchFieldState extends State<_IconSearchField> {
  static const _spellOff = SpellCheckConfiguration.disabled();

  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(widget.debounce, () {
      if (!mounted) {
        return;
      }
      widget.onApply(_controller.text.trim());
    });
  }

  void _applyImmediately() {
    _debounce?.cancel();
    widget.onApply(_controller.text.trim());
  }

  void _clear() {
    _debounce?.cancel();
    _controller.clear();
    widget.onApply('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;

    return FTextField(
      control: FTextFieldControl.managed(controller: _controller),
      label: const Text('아이콘 검색'),
      hint: '예: dog, arrow, chevron down',
      description: Text(
        '입력 후 ${widget.debounce.inMilliseconds}ms 뒤 자동 검색됩니다. '
        '${hasText ? '오른쪽 X로 지우면 전체 목록으로 돌아갑니다. ' : ''}'
        'Enter로 즉시 검색할 수 있습니다.',
      ),
      spellCheckConfiguration: _spellOff,
      autocorrect: false,
      enableSuggestions: false,
      onSubmit: (_) => _applyImmediately(),
      suffixBuilder: hasText
          ? (ctx, style, variants) {
              final iconData = style.iconStyle.resolve(variants);
              return Tooltip(
                message: '지우고 전체 보기',
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 4),
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    style: IconButton.styleFrom(
                      foregroundColor: iconData.color,
                    ),
                    icon: Icon(FIcons.x, size: 18),
                    onPressed: _clear,
                  ),
                ),
              );
            }
          : null,
    );
  }
}
