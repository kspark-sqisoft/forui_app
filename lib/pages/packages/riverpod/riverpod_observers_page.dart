import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../core/logging/app_log.dart';
import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// [name]으로 observer에서 식별합니다. (Riverpod 3: 무명 provider의 `==`는 `identical`만 true라
/// `context.provider == _obsCounterProvider` 비교가 observer 쪽에서 실패할 수 있음.)
final _obsCounterProvider = NotifierProvider.autoDispose<_ObsCounter, int>(
  _ObsCounter.new,
  name: 'obs_demo_counter',
);

class _ObsCounter extends Notifier<int> {
  @override
  int build() => 0;

  void inc() => state++;
}

final class _LogRiverpodObserver extends ProviderObserver {
  const _LogRiverpodObserver();

  static const _counterName = 'obs_demo_counter';

  bool _isDemoCounter(ProviderObserverContext context) =>
      context.provider.name == _counterName;

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    if (!_isDemoCounter(context)) return;
    final line = 'ProviderObserver didAddProvider (counter): $value';
    debugPrint(line);
    AppLog.d(line);
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (!_isDemoCounter(context)) return;
    final line = 'ProviderObserver didUpdateProvider (counter): $previousValue → $newValue';
    debugPrint(line);
    AppLog.d(line);
  }
}

class RiverpodObserversPage extends StatelessWidget {
  const RiverpodObserversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: const [_LogRiverpodObserver()],
      child: const _RiverpodObserversBody(),
    );
  }
}

class _RiverpodObserversBody extends ConsumerWidget {
  const _RiverpodObserversBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(_obsCounterProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'ProviderObservers',
          body: '로깅·분석·디버그용으로 [ProviderObserver]를 [ProviderScope(observers: …)]에 넘깁니다. '
              '카운터 provider에는 `name: obs_demo_counter`를 달아 observer에서 식별합니다 '
              '(무명 provider는 Riverpod 3에서 `==`가 identical만 되어 observer 안에서 전역 참조와 맞추기 어렵습니다). '
              '페이지 진입 시 didAddProvider, +1 시 didUpdateProvider가 호출되며 '
              'debugPrint와 AppLog 둘 다 출력됩니다.\n\n'
              '공식: riverpod.dev — Concepts — ProviderObservers',
        ),
        DocExampleBlock(
          title: 'didUpdateProvider → AppLog',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('값: $n', style: context.theme.typography.sm),
              const SizedBox(width: 12),
              FButton(
                size: FButtonSizeVariant.sm,
                onPress: () => ref.read(_obsCounterProvider.notifier).inc(),
                child: const Text('+1'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
