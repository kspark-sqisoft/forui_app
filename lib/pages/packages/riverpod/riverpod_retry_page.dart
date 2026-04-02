import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// 데모용: 세션마다 처음 두 번은 예외, 그다음 성공 (자동 재시도로 통과).
var _studyFlakyFailsRemaining = 2;

final _retryStudyLogProvider =
    NotifierProvider<_RetryStudyLog, List<String>>(_RetryStudyLog.new);

class _RetryStudyLog extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void addLine(String line) => state = [...state, line];

  void clear() => state = [];
}

/// 문서 예시와 유사: 지수 백오프·상한에서 중단.
/// (문서처럼 `error is ProviderException`이면 `null`을 반환하는 패턴도 자주 씁니다.)
Duration? _studyFlakyRetry(int retryCount, Object error) {
  if (retryCount >= 8) return null;
  return Duration(milliseconds: 200 * (1 << retryCount.clamp(0, 6)));
}

String _studyClock() {
  final n = DateTime.now();
  return '${n.hour.toString().padLeft(2, '0')}:'
      '${n.minute.toString().padLeft(2, '0')}:'
      '${n.second.toString().padLeft(2, '0')}.'
      '${n.millisecond.toString().padLeft(3, '0')}';
}

/// [Automatic retry](https://riverpod.dev/ko/docs/concepts2/retry) 데모용 [FutureProvider].
final studyFlakyDataProvider = FutureProvider.autoDispose<String>(
  (ref) async {
    ref.read(_retryStudyLogProvider.notifier).addLine(
          '[${_studyClock()}] 계산 시작 (남은 의도 실패: $_studyFlakyFailsRemaining)',
        );
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (_studyFlakyFailsRemaining > 0) {
      _studyFlakyFailsRemaining--;
      throw Exception('의도적 실패 ($_studyFlakyFailsRemaining번 더 실패 후 성공)');
    }
    ref.read(_retryStudyLogProvider.notifier).addLine('[${_studyClock()}] 성공');
    return '로드 완료';
  },
  retry: _studyFlakyRetry,
);

/// 내부: 재시도 2회만 — 빠르게 소진 후 [AsyncError].
final _studyInnerFailProvider = FutureProvider.autoDispose<String>(
  (ref) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    throw Exception('내부 provider 실패');
  },
  retry: (c, _) => c < 2 ? const Duration(milliseconds: 120) : null,
);

/// 외부: 내부 [ref.watch(inner.future)] — 실패 시 [ProviderException]. 재시도해도 내부가 고쳐지지 않음.
final _studyOuterDependProvider = FutureProvider.autoDispose<String>(
  (ref) => ref.watch(_studyInnerFailProvider.future),
);

/// [Error]는 기본 재시도 정책에서 재시도하지 않음 ([ProviderContainer.defaultRetry]).
final _studyThrowsErrorProvider = FutureProvider.autoDispose<int>(
  (ref) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    throw AssertionError('버그에 가까운 Error — 재시도 없음');
  },
);

class RiverpodRetryPage extends ConsumerWidget {
  const RiverpodRetryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final flaky = ref.watch(studyFlakyDataProvider);
    final log = ref.watch(_retryStudyLogProvider);
    final outer = ref.watch(_studyOuterDependProvider);
    final errProv = ref.watch(_studyThrowsErrorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageIntro(
          title: 'Automatic retry',
          body: '비동기 provider 계산 중 예외가 나면 Riverpod이 **자동으로 재시도**합니다. '
              '기본값은 최대 10회, 200ms~6.4s 지수 백오프입니다. '
              '`Duration? Function(int retryCount, Object error)`를 반환해 지연을 주고, '
              '`null`이면 재시도를 멈춥니다.\n\n'
              '`ProviderScope(retry: …)`로 전역 설정하거나, provider 생성자의 `retry:`로 개별 설정할 수 있습니다. '
              '기본 구현은 Dart의 Error와 ProviderException은 재시도하지 않습니다 '
              '(버그·다른 provider 전파는 재시도해도 의미가 없기 때문).\n\n'
              '`await ref.watch(myProvider.future)`는 중간 실패를 건너뛰고, '
              '성공하거나 재시도를 모두 소진할 때까지 기다립니다.\n\n'
              '공식: https://riverpod.dev/ko/docs/concepts2/retry',
        ),
        DocExampleBlock(
          title: '데모: 의도적 실패 2회 후 성공 + 커스텀 retry',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '`FutureProvider.autoDispose`에 `retry: _studyFlakyRetry`를 붙였습니다. '
                '로그에 같은 세션에서 여러 번 "계산 시작"이 찍히면 재시도가 동작한 것입니다.',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FButton(
                    size: FButtonSizeVariant.sm,
                    variant: FButtonVariant.outline,
                    onPress: () {
                      _studyFlakyFailsRemaining = 2;
                      ref.read(_retryStudyLogProvider.notifier).clear();
                      ref.invalidate(studyFlakyDataProvider);
                    },
                    child: const Text('다시 2회 실패 후 성공'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _AsyncLine(label: '결과', async: flaky, theme: theme),
              const SizedBox(height: 8),
              Text('실행 로그', style: theme.typography.sm),
              const SizedBox(height: 4),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 140),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colors.muted.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: log.length,
                    itemBuilder: (context, i) => Text(
                      log[i],
                      style: theme.typography.xs.copyWith(
                        fontFamily: 'monospace',
                        height: 1.35,
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'ProviderException: 의존한 provider가 실패한 경우',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '외부 provider가 내부 `ref.watch(inner.future)`만 쓰면, 내부 오류는 '
                'ProviderException으로 감싸집니다. 기본 재시도는 이 경우 외부를 반복하지 않습니다 '
                '(문서 예시와 동일한 이유).',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              _AsyncLine(label: 'outer(내부 실패)', async: outer, theme: theme),
              const SizedBox(height: 8),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.ghost,
                onPress: () {
                  ref.invalidate(_studyInnerFailProvider);
                  ref.invalidate(_studyOuterDependProvider);
                },
                child: const Text('inner / outer 다시 실행'),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: 'Error (예: AssertionError): 재시도 없음',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '기본 정책은 Error(예: AssertionError)를 재시도하지 않습니다.',
                style: theme.typography.xs.copyWith(
                  color: theme.colors.mutedForeground,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              _AsyncLine(label: 'throws Error', async: errProv, theme: theme),
              const SizedBox(height: 8),
              FButton(
                size: FButtonSizeVariant.sm,
                variant: FButtonVariant.ghost,
                onPress: () => ref.invalidate(_studyThrowsErrorProvider),
                child: const Text('다시 실행'),
              ),
            ],
          ),
        ),
        DocExampleBlock(
          title: '전역 / 재시도 끄기 (문서 코드)',
          child: Text(
            'Duration? myRetry(int retryCount, Object error) {\n'
            '  if (retryCount >= 5) return null;\n'
            '  if (error is ProviderException) return null;\n'
            '  return Duration(milliseconds: 200 * (1 << retryCount));\n'
            '}\n\n'
            '// Flutter\n'
            'ProviderScope(\n'
            '  retry: myRetry, // 또는 전부 끄기:\n'
            '  // retry: (retryCount, error) => null,\n'
            '  child: MyApp(),\n'
            ');\n\n'
            '// 개별 provider\n'
            'final x = FutureProvider<String>(\n'
            '  (ref) async => fetch(),\n'
            '  retry: myRetry,\n'
            ');\n\n'
            '// @Riverpod(retry: myRetry) … (riverpod_generator)',
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

class _AsyncLine extends StatelessWidget {
  const _AsyncLine({
    required this.label,
    required this.async,
    required this.theme,
  });

  final String label;
  final AsyncValue<dynamic> async;
  final FThemeData theme;

  @override
  Widget build(BuildContext context) {
    return async.when(
      data: (d) => Text(
        '$label: $d',
        style: theme.typography.sm,
      ),
      loading: () => Text(
        '$label: loading…',
        style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground),
      ),
      error: (e, _) => Text(
        '$label: error — $e',
        style: theme.typography.sm.copyWith(color: theme.colors.destructive),
      ),
    );
  }
}
