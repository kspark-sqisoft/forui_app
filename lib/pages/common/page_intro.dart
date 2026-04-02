import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// 갤러리 페이지 상단에 쓰는 제목 + 본문 블록.
///
/// Forui [context.theme] 타이포와 muted 색을 써서 본문을 시각적으로 낮춥니다.
class PageIntro extends StatelessWidget {
  const PageIntro({
    required this.title,
    required this.body,
    super.key,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.typography.xl.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// 코드·문서 인용을 강조할 때 사용하는 카드형 블록.
class DocCallout extends StatelessWidget {
  const DocCallout({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.typography.sm.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            DefaultTextStyle(
              style: theme.typography.xs.copyWith(
                color: theme.colors.foreground,
                fontFamily: 'monospace',
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
