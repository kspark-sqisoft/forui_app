import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:forui/forui.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// 데스크톱: `flutter run` 시 [Directory.current] 기준 `riverpod_persist_demo/` 아래.
/// Android·iOS: 기기 앱 DB 디렉터리.
Future<String> _persistDemoDbFilePath() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final root = Directory.current.path;
    final folder = Directory(p.join(root, 'riverpod_persist_demo'));
    if (!folder.existsSync()) {
      await folder.create(recursive: true);
    }
    return p.join(folder.path, 'forui_app_riverpod_persist_demo.db');
  }
  final base = await getDatabasesPath();
  return p.join(base, 'forui_app_riverpod_persist_demo.db');
}

final _persistDemoDbPathProvider = FutureProvider<String>((ref) => _persistDemoDbFilePath());

/// SQFlite [JsonSqFliteStorage] + `Notifier.persist` (실험 API).
///
/// 문서: [Offline persistence](https://riverpod.dev/ko/docs/concepts2/offline)
final _persistDemoStorageProvider = FutureProvider<JsonSqFliteStorage>((ref) async {
  final filePath = await ref.watch(_persistDemoDbPathProvider.future);
  return JsonSqFliteStorage.open(filePath);
});

final _persistedLinesProvider =
    AsyncNotifierProvider<_PersistedLinesNotifier, List<String>>(_PersistedLinesNotifier.new);

class _PersistedLinesNotifier extends AsyncNotifier<List<String>> {
  static const _storageKey = 'persist_demo_lines_v1';

  @override
  Future<List<String>> build() async {
    final persistResult = persist(
      ref.watch(_persistDemoStorageProvider.future),
      key: _storageKey,
      options: const StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: '1',
      ),
      encode: (lines) => jsonEncode(lines),
      decode: (raw) => (jsonDecode(raw) as List<dynamic>).map((e) => e as String).toList(),
    );
    final decodeDone = persistResult.future;
    if (decodeDone != null) {
      await decodeDone;
    }
    return state.value ?? <String>[];
  }

  Future<void> append(String text) async {
    final cur = await future;
    state = AsyncData([...cur, text.trim().isEmpty ? '(빈 줄)' : text.trim()]);
  }

  Future<void> clear() async {
    state = const AsyncData([]);
  }
}

class RiverpodOfflinePersistPage extends ConsumerWidget {
  const RiverpodOfflinePersistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final storageAsync = ref.watch(_persistDemoStorageProvider);
    final linesAsync = ref.watch(_persistedLinesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageIntro(
          title: 'Offline persistence (experimental)',
          body: '`JsonSqFliteStorage`로 로컬 DB에 JSON을 쓰고, `AsyncNotifier.build` 안에서 '
              '`persist(...)`로 복원·저장을 연결합니다. 앱을 완전히 종료했다가 다시 열어도 '
              '같은 키(`persist_demo_lines_v1`)로 목록이 돌아옵니다.\n\n'
              'Windows·Linux·macOS에서는 `main`에서 `sqflite_common_ffi`로 `databaseFactory`를 연결하고, '
              'DB 파일은 프로젝트 루트(실행 시 `Directory.current`) 아래 `riverpod_persist_demo/` 에 둡니다. '
              '모바일은 기기 앱 데이터 경로를 씁니다.\n\n'
              '웹 빌드에서는 이 화면 대신 “웹에서는 테스트 불가” 안내만 표시됩니다.\n\n'
              '실험 API이며, 마이그레이션·암호화 등은 DB 문서와 함께 별도 설계가 필요합니다.\n\n'
              '공식: https://riverpod.dev/ko/docs/concepts2/offline',
        ),
        DocExampleBlock(
          title: '저장소 열기 (FutureProvider)',
          child: storageAsync.when(
            data: (_) {
              final pathAsync = ref.watch(_persistDemoDbPathProvider);
              return pathAsync.when(
                data: (dbPath) => SelectableText(
                  'JsonSqFliteStorage 준비됨.\n$dbPath',
                  style: theme.typography.xs.copyWith(
                    color: theme.colors.mutedForeground,
                    height: 1.4,
                  ),
                ),
                loading: () => Text(
                  '경로 확인 중…',
                  style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground),
                ),
                error: (e, _) => SelectableText('$e'),
              );
            },
            loading: () => const SizedBox(
              width: 22,
              height: 22,
              child: FCircularProgress.loader(),
            ),
            error: (e, _) => SelectableText(
              '$e',
              style: theme.typography.sm.copyWith(color: theme.colors.destructive),
            ),
          ),
        ),
        DocExampleBlock(
          title: '불러오기 · 저장 (persist + 목록 수정)',
          child: linesAsync.when(
            data: (lines) => _PersistLinesBody(lines: lines, theme: theme),
            loading: () => const Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: FCircularProgress.loader(),
                ),
                SizedBox(width: 10),
                Text('persist 디코딩 또는 초기 로드…'),
              ],
            ),
            error: (e, _) => SelectableText(
              '$e',
              style: theme.typography.sm.copyWith(color: theme.colors.destructive),
            ),
          ),
        ),
      ],
    );
  }
}

class _PersistLinesBody extends ConsumerStatefulWidget {
  const _PersistLinesBody({
    required this.lines,
    required this.theme,
  });

  final List<String> lines;
  final FThemeData theme;

  @override
  ConsumerState<_PersistLinesBody> createState() => _PersistLinesBodyState();
}

class _PersistLinesBodyState extends ConsumerState<_PersistLinesBody> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• `build`에서 `persist` 후 `state.value ?? []`로 초기 목록을 잡습니다.\n'
          '• `append` / `clear`로 `state`를 바꾸면 Riverpod이 `encode`로 DB에 다시 씁니다.',
          style: theme.typography.xs.copyWith(
            color: theme.colors.mutedForeground,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        FTextField(
          label: const Text('한 줄 입력'),
          hint: '추가 후 앱 재시작으로 복원 확인',
          spellCheckConfiguration: SpellCheckConfiguration.disabled(),
          autocorrect: false,
          control: FTextFieldControl.managed(controller: _controller),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FButton(
              size: FButtonSizeVariant.sm,
              onPress: () async {
                await ref.read(_persistedLinesProvider.notifier).append(_controller.text);
                if (mounted) _controller.clear();
              },
              child: const Text('줄 추가 (저장)'),
            ),
            FButton(
              size: FButtonSizeVariant.sm,
              variant: FButtonVariant.outline,
              onPress: () => ref.read(_persistedLinesProvider.notifier).clear(),
              child: const Text('목록 비우기'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '현재 ${widget.lines.length}줄',
          style: theme.typography.xs.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        if (widget.lines.isEmpty)
          Text('(비어 있음)', style: theme.typography.xs.copyWith(color: theme.colors.mutedForeground))
        else
          ...widget.lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: SelectableText('· $line', style: theme.typography.sm),
            ),
          ),
      ],
    );
  }
}
