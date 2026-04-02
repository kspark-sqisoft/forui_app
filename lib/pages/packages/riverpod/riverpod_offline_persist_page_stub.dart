import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../common/doc_example_block.dart';
import '../../common/page_intro.dart';

/// 웹: sqflite / `dart:io` 미지원 — 안내만 표시 ([riverpod_offline_persist_page_io] 참고).
class RiverpodOfflinePersistPage extends StatelessWidget {
  const RiverpodOfflinePersistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageIntro(
          title: 'Offline persistence (experimental)',
          body: '이 페이지의 SQLite·`JsonSqFliteStorage` 데모는 웹에서는 동작하지 않습니다. '
              '브라우저에는 로컬 SQLite(sqflite)가 없고, 데스크톱용 `sqflite_common_ffi` 초기화도 '
              '웹 번들에 넣지 않습니다(웹 빌드가 깨지지 않도록 조건부 컴파일로 분리됨).\n\n'
              'Windows·macOS·Linux·Android·iOS 타깃으로 실행하면 프로젝트 폴더의 '
              '`riverpod_persist_demo/` 또는 기기 DB 경로에 저장·복원 데모를 쓸 수 있습니다.\n\n'
              '공식: https://riverpod.dev/ko/docs/concepts2/offline',
        ),
        DocExampleBlock(
          title: 'Web 빌드',
          child: Text(
            '같은 라우트는 IO 플랫폼 빌드에서 전체 데모 UI가 열립니다.',
            style: t.typography.sm.copyWith(
              color: t.colors.mutedForeground,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}
