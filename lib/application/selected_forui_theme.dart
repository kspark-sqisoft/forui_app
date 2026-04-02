import 'package:forui/forui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_forui_theme.g.dart';

/// Forui [FThemes]에 있는 팔레트 전부 × light/dark.
///
/// 각 팔레트는 [FPlatformThemeData]로 `light` / `dark`를 가집니다. 이 앱은 학습용으로 **desktop**
/// (`*.desktop`)만 [resolvedForuiThemeProvider]에 연결합니다.
///
/// **터치 밀도(`*.touch`)를 쓰려면:** 여기에 enum 값을 늘리거나 별도 플래그를 두고
/// `FThemes.*.light.touch` 등으로 매핑을 추가하면 됩니다.
///
/// 참고: https://forui.dev/docs (Themes)
enum AppForuiThemeId {
  neutralLight,
  neutralDark,
  zincLight,
  zincDark,
  slateLight,
  slateDark,
  blueLight,
  blueDark,
  greenLight,
  greenDark,
  orangeLight,
  orangeDark,
  redLight,
  redDark,
  roseLight,
  roseDark,
  violetLight,
  violetDark,
  yellowLight,
  yellowDark,
}

/// [AppForuiThemeId] → [FThemeData] (desktop).
extension AppForuiThemeIdDesktop on AppForuiThemeId {
  FThemeData get desktopFThemeData => switch (this) {
        AppForuiThemeId.neutralLight => FThemes.neutral.light.desktop,
        AppForuiThemeId.neutralDark => FThemes.neutral.dark.desktop,
        AppForuiThemeId.zincLight => FThemes.zinc.light.desktop,
        AppForuiThemeId.zincDark => FThemes.zinc.dark.desktop,
        AppForuiThemeId.slateLight => FThemes.slate.light.desktop,
        AppForuiThemeId.slateDark => FThemes.slate.dark.desktop,
        AppForuiThemeId.blueLight => FThemes.blue.light.desktop,
        AppForuiThemeId.blueDark => FThemes.blue.dark.desktop,
        AppForuiThemeId.greenLight => FThemes.green.light.desktop,
        AppForuiThemeId.greenDark => FThemes.green.dark.desktop,
        AppForuiThemeId.orangeLight => FThemes.orange.light.desktop,
        AppForuiThemeId.orangeDark => FThemes.orange.dark.desktop,
        AppForuiThemeId.redLight => FThemes.red.light.desktop,
        AppForuiThemeId.redDark => FThemes.red.dark.desktop,
        AppForuiThemeId.roseLight => FThemes.rose.light.desktop,
        AppForuiThemeId.roseDark => FThemes.rose.dark.desktop,
        AppForuiThemeId.violetLight => FThemes.violet.light.desktop,
        AppForuiThemeId.violetDark => FThemes.violet.dark.desktop,
        AppForuiThemeId.yellowLight => FThemes.yellow.light.desktop,
        AppForuiThemeId.yellowDark => FThemes.yellow.dark.desktop,
      };

  /// 갤러리 «테마» 페이지 버튼에 쓰는 짧은 한글 라벨.
  String get galleryLabel => switch (this) {
        AppForuiThemeId.neutralLight => 'Neutral 밝음',
        AppForuiThemeId.neutralDark => 'Neutral 어두움',
        AppForuiThemeId.zincLight => 'Zinc 밝음',
        AppForuiThemeId.zincDark => 'Zinc 어두움',
        AppForuiThemeId.slateLight => 'Slate 밝음',
        AppForuiThemeId.slateDark => 'Slate 어두움',
        AppForuiThemeId.blueLight => 'Blue 밝음',
        AppForuiThemeId.blueDark => 'Blue 어두움',
        AppForuiThemeId.greenLight => 'Green 밝음',
        AppForuiThemeId.greenDark => 'Green 어두움',
        AppForuiThemeId.orangeLight => 'Orange 밝음',
        AppForuiThemeId.orangeDark => 'Orange 어두움',
        AppForuiThemeId.redLight => 'Red 밝음',
        AppForuiThemeId.redDark => 'Red 어두움',
        AppForuiThemeId.roseLight => 'Rose 밝음',
        AppForuiThemeId.roseDark => 'Rose 어두움',
        AppForuiThemeId.violetLight => 'Violet 밝음',
        AppForuiThemeId.violetDark => 'Violet 어두움',
        AppForuiThemeId.yellowLight => 'Yellow 밝음',
        AppForuiThemeId.yellowDark => 'Yellow 어두움',
      };
}

/// 현재 선택된 Forui 테마 키. [keepAlive]로 앱 전역에서 한 번 유지합니다.
///
/// 실제 [FThemeData]는 [resolvedForuiThemeProvider]에서 [AppForuiThemeId]에 맞게 매핑합니다.
@Riverpod(keepAlive: true)
class SelectedForuiTheme extends _$SelectedForuiTheme {
  @override
  AppForuiThemeId build() => AppForuiThemeId.zincLight;

  /// UI(예: 테마 학습 페이지의 버튼)에서 호출해 팔레트를 바꿉니다.
  void pick(AppForuiThemeId id) => state = id;
}

/// [MaterialApp]의 `theme`와 동기화할 [FThemeData].
///
/// [FTheme] 위젯의 `data`로도 동일 인스턴스를 넘겨야 Forui 위젯과 Material 위젯 색이 어긋나지 않습니다.
@riverpod
FThemeData resolvedForuiTheme(Ref ref) {
  return ref.watch(selectedForuiThemeProvider).desktopFThemeData;
}
