import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// forui.dev 문서처럼 **소제목 + 예시**를 묶습니다. 한 페이지에 여러 패턴을 나열할 때 사용합니다.
class DocExampleBlock extends StatelessWidget {
  const DocExampleBlock({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.typography.sm.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colors.foreground,
          ),
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 24),
      ],
    );
  }
}
