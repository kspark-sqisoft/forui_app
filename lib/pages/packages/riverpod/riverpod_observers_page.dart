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

  /// 이 페이지 전용 [ProviderScope] 아래에서만 쓰이므로, 이벤트가 거의 카운터뿐입니다.
  /// `print`는 Windows `flutter run` 터미널에도 그대로 나갑니다(debugPrint·logger보다 확실).
  void _emit(String event, ProviderObserverContext context, String detail) {
    final id = context.provider.name ?? context.provider.toString();
    final mark = _isDemoCounter(context) ? '[counter] ' : '';
    final line = 'RiverpodObserver $event $mark($id) $detail';
    // ignore: avoid_print
    print(line);
    debugPrint(line);
    AppLog.d(line);
  }

  bool _isDemoCounter(ProviderObserverContext context) {
    if (identical(context.provider, _obsCounterProvider)) return true;
    return context.provider.name == _counterName;
  }

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    _emit('didAddProvider', context, 'value=$value');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    _emit('didUpdateProvider', context, '$previousValue → $newValue');
  }
}

class RiverpodObserversPage extends StatelessWidget {
  const RiverpodObserversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: const [_LogRiverpodObserver()],
      // 중첩 Scope에 overrides가 하나도 없으면 부모와 동일한 PointerManager를 쓰고,
      // 프로바이더가 루트 컨테이너에만 마운트됩니다. 그러면 이 Scope의 observers는
      // didAdd/didUpdate를 받지 못합니다. 데모 카운터만 override 해 자식 컨테이너에 올립니다.
      overrides: [
        _obsCounterProvider.overrideWith(_ObsCounter.new),
      ],
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
          body:               '로깅·분석·디버그용으로 [ProviderObserver]를 [ProviderScope(observers: …)]에 넘깁니다. '
              '중첩 Scope에는 반드시 [overrides]가 있어야(여기서는 카운터만 override) '
              '상태가 그 Scope의 [ProviderContainer]에 마운트되고, 그때 이 Scope에 넘긴 observers가 호출됩니다. '
              'overrides 없이 observers만 두면 상태가 루트에만 올라가 observer가 한 번도 불리지 않을 수 있습니다.\n\n'
              '카운터에는 `name: obs_demo_counter`를 달아 로그에 식별자로 씁니다. '
              '페이지 진입 시 didAddProvider, +1 시 didUpdateProvider가 터미널(print)에도 찍힙니다.\n\n'
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
