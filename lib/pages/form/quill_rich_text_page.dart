// Rich paste·클립보드 툴바는 flutter_quill의 실험 API를 샌드박스에서 그대로 노출합니다.
// ignore_for_file: experimental_member_use

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:forui/forui.dart';

import '../../bootstrap/app_fonts.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';
import 'quill_learning_sample_document.dart';

/// [flutter_quill](https://pub.dev/packages/flutter_quill) 패키지 실험 페이지(라우트: `/packages/flutter-quill`).
///
/// [QuillController] · [QuillSimpleToolbar] · [QuillEditor] · Delta JSON · 읽기 전용 전환을 한 화면에서 봅니다.
class QuillRichTextPage extends StatefulWidget {
  const QuillRichTextPage({super.key});

  @override
  State<QuillRichTextPage> createState() => _QuillRichTextPageState();
}

class _QuillRichTextPageState extends State<QuillRichTextPage> {
  late final QuillController _controller;
  late final FocusNode _editorFocusNode;
  late final ScrollController _editorScrollController;

  static bool get _isDesktop {
    if (kIsWeb) return false;
    return switch (defaultTargetPlatform) {
      TargetPlatform.linux || TargetPlatform.macOS || TargetPlatform.windows => true,
      _ => false,
    };
  }

  @override
  void initState() {
    super.initState();
    _editorFocusNode = FocusNode();
    _editorScrollController = ScrollController();
    _controller = QuillController.basic(
      config: const QuillControllerConfig(
        clipboardConfig: QuillClipboardConfig(
          enableExternalRichPaste: true,
        ),
      ),
    );
    _controller.document = Document.fromJson(quillLearningSampleOps());
  }

  @override
  void dispose() {
    _controller.dispose();
    _editorFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  void _refocusEditor() {
    if (_isDesktop) {
      _editorFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final quillL10n = FlutterQuillLocalizations.of(context)!;
    final toolbarConfig = QuillSimpleToolbarConfig(
      multiRowsDisplay: true,
      showAlignmentButtons: true,
      showLineHeightButton: true,
      showDirection: true,
      showSmallButton: true,
      showClipboardCut: true,
      showClipboardCopy: true,
      showClipboardPaste: true,
      buttonOptions: QuillSimpleToolbarButtonOptions(
        base: QuillToolbarBaseButtonOptions(
          afterButtonPressed: _refocusEditor,
        ),
        linkStyle: QuillToolbarLinkStyleButtonOptions(
          validateLink: (_) => true,
        ),
        fontFamily: QuillToolbarFontFamilyButtonOptions(
          items: {
            'Sans Serif': 'sans-serif',
            'Serif': 'serif',
            'Monospace': 'monospace',
            'Noto Sans KR': kBundledKoreanFontFamily,
            'Nanum Gothic': kBundledNanumGothicFontFamily,
            'Ibarra Real Nova': 'ibarra-real-nova',
            'SquarePeg': 'square-peg',
            'Nunito': 'nunito',
            'Pacifico': 'pacifico',
            'Roboto Mono': 'roboto-mono',
            quillL10n.clear: 'Clear',
          },
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Rich text (flutter_quill)',
          body: 'Quill Delta 기반 WYSIWYG 에디터입니다. pub.dev: https://pub.dev/packages/flutter_quill\n\n'
              '• 상단 툴바: 서식·블록·목록·정렬·들여쓰기·링크·검색·히스토리·클립보드\n'
              '• 에디터: [QuillEditor] + [QuillController]; 본문은 고정 높이 영역 안에서 스크롤합니다(바깥 [SingleChildScrollView]와 충돌 방지).\n'
              '• 앱 루트에 [FlutterQuillLocalizations.delegate]를 등록해야 툴바·다이얼로그 문자열이 정상 로드됩니다.\n'
              '• 글꼴 메뉴: [pubspec]에 등록한 이름(예: Noto Sans KR)을 [items]에 넣어야 에디터에 반영됩니다. 기본 항목(nunito 등)은 앱에 해당 폰트가 없으면 시스템 대체로 보일 수 있습니다.\n'
              '• 이미지/동영상 임베드는 flutter_quill_extensions 등 추가 설정이 필요합니다.',
        ),
        DocExampleBlock(
          title: '툴바 + 에디터 (대부분의 기본 기능)',
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.border),
              borderRadius: BorderRadius.circular(8),
              color: theme.colors.background,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 440,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Material(
                      color: theme.colors.muted.withValues(alpha: 0.25),
                      child: QuillSimpleToolbar(
                        controller: _controller,
                        config: toolbarConfig,
                      ),
                    ),
                    Expanded(
                      child: QuillEditor(
                        controller: _controller,
                        focusNode: _editorFocusNode,
                        scrollController: _editorScrollController,
                        config: QuillEditorConfig(
                          placeholder: '여기에 입력하거나 위 샘플을 수정해 보세요…',
                          padding: const EdgeInsets.all(12),
                          scrollPhysics: const ClampingScrollPhysics(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        DocExampleBlock(
          title: '읽기 전용 · Delta JSON',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FSwitch(
                label: const Text('편집 허용'),
                description: const Text('끄면 읽기 전용(선택은 가능)으로 전환합니다.'),
                value: !_controller.readOnly,
                onChange: (v) {
                  setState(() => _controller.readOnly = !v);
                },
              ),
              const SizedBox(height: 10),
              FButton(
                variant: .outline,
                mainAxisSize: MainAxisSize.min,
                onPress: () {
                  final json = jsonEncode(_controller.document.toDelta().toJson());
                  debugPrint('Quill Delta JSON:\n$json');
                },
                child: const Text('Delta를 콘솔에 출력'),
              ),
              const SizedBox(height: 12),
              Text(
                'document.toDelta().toJson() — 저장·동기화 시 이 형태를 서버로 보내는 경우가 많습니다.',
                style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
              ),
              const SizedBox(height: 8),
              ListenableBuilder(
                listenable: _controller,
                builder: (context, _) {
                  final pretty = const JsonEncoder.withIndent('  ')
                      .convert(_controller.document.toDelta().toJson());
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colors.muted.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SelectableText(
                        pretty,
                        style: theme.typography.xs.copyWith(
                          fontFamily: 'monospace',
                          color: theme.colors.foreground,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
