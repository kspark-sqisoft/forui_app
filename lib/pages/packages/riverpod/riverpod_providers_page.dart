import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

// —— 기존: Provider + NotifierProvider ——

final _studyDoubledProvider = Provider<int>((ref) {
  final base = ref.watch(_studyBaseProvider);
  return base * 2;
});

final _studyBaseProvider = NotifierProvider<_StudyBase, int>(_StudyBase.new);

class _StudyBase extends Notifier<int> {
  @override
  int build() => 3;

  void setBase(int v) => state = v;
}

// —— FutureProvider ——

final _studyFutureProvider = FutureProvider.autoDispose<String>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));
  return 'FutureProvider 완료';
});

// —— StreamProvider ——

final _studyStreamProvider = StreamProvider.autoDispose<int>((ref) async* {
  for (var i = 1; i <= 5; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    yield i;
  }
});

// —— AsyncNotifierProvider ——

final _studyAsyncNotifierProvider =
    AsyncNotifierProvider.autoDispose<_StudyAsyncCounter, int>(
      _StudyAsyncCounter.new,
    );

class _StudyAsyncCounter extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    return 1;
  }

  Future<void> increment() async {
    final cur = await future;
    state = const AsyncLoading<int>();
    await Future<void>.delayed(const Duration(milliseconds: 250));
    state = AsyncData(cur + 1);
  }
}

// —— StreamNotifierProvider ——

final _studyStreamNotifierProvider =
    StreamNotifierProvider.autoDispose<_StudyStreamTicks, int>(
      _StudyStreamTicks.new,
    );

class _StudyStreamTicks extends StreamNotifier<int> {
  @override
  Stream<int> build() async* {
    for (var i = 1; i <= 5; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      yield i;
    }
  }
}

// —— Legacy: StateProvider ——

final _studyLegacyStateProvider = StateProvider.autoDispose<int>((ref) => 0);

// —— Legacy: ChangeNotifierProvider ——

final _studyLegacyChangeNotifierProvider =
    ChangeNotifierProvider.autoDispose<_StudyLegacyCn>(
      (ref) => _StudyLegacyCn(),
    );

class _StudyLegacyCn extends ChangeNotifier {
  int _n = 0;
  int get n => _n;

  void bump() {
    _n++;
    notifyListeners();
  }
}

// —— Legacy: StateNotifierProvider ——

final _studyLegacyStateNotifierProvider =
    StateNotifierProvider.autoDispose<_StudyLegacySn, int>(
      (ref) => _StudyLegacySn(),
    );

class _StudyLegacySn extends StateNotifier<int> {
  _StudyLegacySn() : super(10);

  void addThree() => state = state + 3;
}

class RiverpodProvidersPage extends ConsumerWidget {
  const RiverpodProvidersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final base = ref.watch(_studyBaseProvider);
    final doubled = ref.watch(_studyDoubledProvider);
    final futureAsync = ref.watch(_studyFutureProvider);
    final streamAsync = ref.watch(_studyStreamProvider);
    final asyncN = ref.watch(_studyAsyncNotifierProvider);
    final streamN = ref.watch(_studyStreamNotifierProvider);
    final legacyState = ref.watch(_studyLegacyStateProvider);
    final legacyCn = ref.watch(_studyLegacyChangeNotifierProvider);
    final legacySn = ref.watch(_studyLegacyStateNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Providers',
          body:
              'Riverpod 3에서 자주 쓰는 프로바이더 종류를 한 화면에 모았습니다. '
              '`FutureProvider`·`StreamProvider`·`NotifierProvider` 계열은 메인 API이고, '
              '`StateProvider`·`ChangeNotifierProvider`·`StateNotifierProvider`는 '
              '`package:flutter_riverpod/legacy.dart`에서 가져옵니다(문서에서도 legacy로 안내).\n\n'
              '공식: riverpod.dev — Concepts — Providers',
        ),
        DocExampleBlock(
          title: 'NotifierProvider + 파생 Provider',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'base = $base → doubled = $doubled',
                style: theme.typography.sm,
              ),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: () =>
                    ref.read(_studyBaseProvider.notifier).setBase(base + 1),
                child: const Text('base +1'),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'FutureProvider.autoDispose',
          child: futureAsync.when(
            data: (s) => Text(s, style: theme.typography.sm),
            loading: () => const SizedBox(
              width: 20,
              height: 20,
              child: FCircularProgress.loader(),
            ),
            error: (e, _) => Text('$e', style: theme.typography.sm),
          ),
        ),
        DocExampleBlock(
          title: 'StreamProvider.autoDispose (1…5 이벤트 후 완료)',
          child: streamAsync.when(
            data: (n) => Text('마지막 값: $n', style: theme.typography.sm),
            loading: () => Text('스트림 대기…', style: theme.typography.xs),
            error: (e, _) => Text('$e', style: theme.typography.sm),
          ),
        ),
        DocExampleBlock(
          title: 'AsyncNotifierProvider.autoDispose',
          child: asyncN.when(
            data: (n) => Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('값: $n', style: theme.typography.sm),
                FButton(
                  size: FButtonSizeVariant.sm,
                  variant: FButtonVariant.outline,
                  onPress: () => ref
                      .read(_studyAsyncNotifierProvider.notifier)
                      .increment(),
                  child: const Text('+1 (비동기)'),
                ),
              ],
            ),
            loading: () => const SizedBox(
              width: 20,
              height: 20,
              child: FCircularProgress.loader(),
            ),
            error: (e, _) => Text('$e', style: theme.typography.sm),
          ),
        ),
        DocExampleBlock(
          title: 'StreamNotifierProvider.autoDispose',
          child: streamN.when(
            data: (n) => Text('최근 값: $n', style: theme.typography.sm),
            loading: () => Text('스트림 대기…', style: theme.typography.xs),
            error: (e, _) => Text('$e', style: theme.typography.sm),
          ),
        ),
        DocExampleBlock(
          title: 'StateProvider (legacy)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('값: $legacyState', style: theme.typography.sm),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: () => ref
                    .read(_studyLegacyStateProvider.notifier)
                    .update((s) => s + 1),
                child: const Text('+1'),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'ChangeNotifierProvider (legacy)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'notifyListeners: n = ${legacyCn.n}',
                style: theme.typography.sm,
              ),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: legacyCn.bump,
                child: const Text('bump'),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'StateNotifierProvider (legacy · package:state_notifier)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('값: $legacySn', style: theme.typography.sm),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.outline,
                onPress: () => ref
                    .read(_studyLegacyStateNotifierProvider.notifier)
                    .addThree(),
                child: const Text('+3'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
