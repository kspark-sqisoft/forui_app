import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../application/app_locale.dart';
import '../common/doc_example_block.dart';
import '../common/page_intro.dart';

/// Forui **로컬라이제이션** 개념 페이지.
///
/// 1. [MaterialApp]에 `FLocalizations.localizationsDelegates`와 `supportedLocales`를 등록합니다.
/// 2. 위젯 트리 안에서는 `FLocalizations.of(context)`로 문자열을 가져옵니다(없으면 [FDefaultLocalizations]).
/// 3. [FTabs] 등 일부 위젯은 [MaterialLocalizations]도 필요해 `GlobalMaterialLocalizations.delegate`를 함께 씁니다.
///
/// 이 앱의 `locale`은 [appLocaleProvider]와 연결되어 있어, 버튼으로 ko/en/ja를 바꿔 볼 수 있습니다.
class LocalizationConceptPage extends ConsumerWidget {
  const LocalizationConceptPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final loc = FLocalizations.of(context);
    final localeCtrl = ref.read(appLocaleProvider.notifier);

    // Forui가 번역해 둔 예시 문자열 (로케일에 따라 달라짐)
    final sampleSelectHint = loc?.selectHint ?? '(FLocalizations 없음)';
    final sampleDateHint = loc?.dateFieldHint ?? '';
    final sampleProgress = loc?.progressSemanticsLabel ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: '로컬라이제이션 (FLocalizations)',
          body: 'MaterialApp.locale이 바뀌면 Forui ARB가 선택됩니다. '
              '지원 목록은 FLocalizations.supportedLocales 를 열어보면 됩니다.',
        ),
        DocExampleBlock(
          title: 'Locale 전환',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재 Locale: ${locale.toLanguageTag()}', style: context.theme.typography.sm),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FButton(
                    variant: locale.languageCode == 'ko' ? FButtonVariant.primary : FButtonVariant.outline,
                    onPress: localeCtrl.useKorean,
                    child: const Text('한국어'),
                  ),
                  FButton(
                    variant: locale.languageCode == 'en' ? FButtonVariant.primary : FButtonVariant.outline,
                    onPress: localeCtrl.useEnglish,
                    child: const Text('English'),
                  ),
                  FButton(
                    variant: locale.languageCode == 'ja' ? FButtonVariant.primary : FButtonVariant.outline,
                    onPress: localeCtrl.useJapanese,
                    child: const Text('日本語'),
                  ),
                ],
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'FLocalizations 샘플',
          child: FCard(
            title: const Text('동일 getter, 로케일만 변경'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('selectHint → $sampleSelectHint', style: context.theme.typography.sm),
                Text('dateFieldHint → $sampleDateHint', style: context.theme.typography.sm),
                Text('progressSemanticsLabel → $sampleProgress', style: context.theme.typography.sm),
              ],
            ),
          ),
        ),
        DocExampleBlock(
          title: 'pubspec 의존성',
          child: const DocCallout(
            title: 'dependencies',
            child: Text(
              'dependencies:\n'
              '  flutter_localizations:\n'
              '    sdk: flutter',
            ),
          ),
        ),
      ],
    );
  }
}
