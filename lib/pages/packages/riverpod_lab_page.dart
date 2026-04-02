import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../common/doc_example_block.dart';
import '../common/page_intro.dart';
import 'riverpod/riverpod_lab_weather_providers.dart';

IconData _labWeatherIcon(LabWeatherKind k) {
  return switch (k) {
    LabWeatherKind.clear => FIcons.sun,
    LabWeatherKind.cloudy => FIcons.cloudy,
    LabWeatherKind.rain => FIcons.cloudRain,
    LabWeatherKind.snow => FIcons.cloudSnow,
    LabWeatherKind.fog => FIcons.cloudFog,
    LabWeatherKind.thunder => FIcons.cloudLightning,
  };
}

/// [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) — 문서 [시작하기](https://riverpod.dev/ko/docs/introduction/getting_started)에 맞춘 학습 허브.
class RiverpodLabPage extends ConsumerWidget {
  const RiverpodLabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final weather = ref.watch(weatherProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Riverpod — 시작하기',
          body:
              '앱 루트는 이미 [ProviderScope]로 감싸져 있습니다(lib/main.dart).\n\n'
              '왼쪽 메뉴 **패키지 실험 → Riverpod** 아래 항목은 riverpod.dev 한국어 문서의 '
              '「기본 개념」 순서를 따릅니다. 각 페이지에서 Forui 위젯으로 짧은 데모를 실행해 볼 수 있습니다.\n\n'
              '공식 문서: https://riverpod.dev/ko/docs/introduction/getting_started',
        ),
        DocExampleBlock(
          title: '학습 순서 (기본 개념)',
          child: Text(
            '1. Providers\n'
            '2. Consumers\n'
            '3. ProviderScope / ProviderContainer\n'
            '4. Refs\n'
            '5. AsyncValue · Ref 라이프사이클 (onDispose 등)\n'
            '6. Todos (DummyJSON) — AsyncNotifier + 네트워크\n'
            '7. Posts (DummyJSON) — Freezed · Repository · FDialog\n'
            '8. Automatic disposal · Family · select(리빌드 최소화)\n'
            '9. Overrides · Scoping · Observers\n'
            '10. Retry / Mutations / Offline / 코드 생성 / hooks (문서·메모)',
            style: theme.typography.sm.copyWith(
              color: theme.colors.mutedForeground,
              height: 1.45,
            ),
          ),
        ),
        DocExampleBlock(
          title: '시뮬: cityProvider → weatherProvider (FutureProvider, 1초)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '`weatherProvider`는 `FutureProvider.autoDispose`이고, 빌드 안에서 `cityProvider`를 '
                '`watch`합니다. 도시(`cityProvider`)가 바뀌면 의존성이 달라진 것으로 처리되어 '
                '이전 `weatherProvider` 상태는 dispose되고, 프로바이더가 다시 생성·실행되며 '
                '새 `Future`(여기서는 1초 딜레이 후 무작위 맑음·흐림 등)가 돌아갑니다.',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final c in LabCity.values)
                    FButton(
                      size: FButtonSizeVariant.sm,
                      variant: ref.watch(cityProvider) == c
                          ? FButtonVariant.primary
                          : FButtonVariant.outline,
                      onPress: () => ref.read(cityProvider.notifier).select(c),
                      child: Text(c.label),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              weather.when(
                skipLoadingOnReload: false,
                data: (result) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      _labWeatherIcon(result.kind),
                      size: 26,
                      color: theme.colors.foreground,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        result.line,
                        style: theme.typography.sm.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                loading: () => const Row(
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: FCircularProgress.loader(),
                    ),
                    SizedBox(width: 10),
                    Text('날씨 불러오는 중…'),
                  ],
                ),
                error: (e, _) => SelectableText(
                  '$e',
                  style: theme.typography.sm.copyWith(
                    color: theme.colors.destructive,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
