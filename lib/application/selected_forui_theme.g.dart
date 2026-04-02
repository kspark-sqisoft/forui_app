// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_forui_theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 현재 선택된 Forui 테마 키. [keepAlive]로 앱 전역에서 한 번 유지합니다.
///
/// 실제 [FThemeData]는 [resolvedForuiThemeProvider]에서 [AppForuiThemeId]에 맞게 매핑합니다.

@ProviderFor(SelectedForuiTheme)
final selectedForuiThemeProvider = SelectedForuiThemeProvider._();

/// 현재 선택된 Forui 테마 키. [keepAlive]로 앱 전역에서 한 번 유지합니다.
///
/// 실제 [FThemeData]는 [resolvedForuiThemeProvider]에서 [AppForuiThemeId]에 맞게 매핑합니다.
final class SelectedForuiThemeProvider
    extends $NotifierProvider<SelectedForuiTheme, AppForuiThemeId> {
  /// 현재 선택된 Forui 테마 키. [keepAlive]로 앱 전역에서 한 번 유지합니다.
  ///
  /// 실제 [FThemeData]는 [resolvedForuiThemeProvider]에서 [AppForuiThemeId]에 맞게 매핑합니다.
  SelectedForuiThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedForuiThemeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedForuiThemeHash();

  @$internal
  @override
  SelectedForuiTheme create() => SelectedForuiTheme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppForuiThemeId value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppForuiThemeId>(value),
    );
  }
}

String _$selectedForuiThemeHash() =>
    r'fd70bdfd7dccc3a8fb34608801d385f54c681158';

/// 현재 선택된 Forui 테마 키. [keepAlive]로 앱 전역에서 한 번 유지합니다.
///
/// 실제 [FThemeData]는 [resolvedForuiThemeProvider]에서 [AppForuiThemeId]에 맞게 매핑합니다.

abstract class _$SelectedForuiTheme extends $Notifier<AppForuiThemeId> {
  AppForuiThemeId build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppForuiThemeId, AppForuiThemeId>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppForuiThemeId, AppForuiThemeId>,
              AppForuiThemeId,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// [MaterialApp]의 `theme`와 동기화할 [FThemeData].
///
/// [FTheme] 위젯의 `data`로도 동일 인스턴스를 넘겨야 Forui 위젯과 Material 위젯 색이 어긋나지 않습니다.

@ProviderFor(resolvedForuiTheme)
final resolvedForuiThemeProvider = ResolvedForuiThemeProvider._();

/// [MaterialApp]의 `theme`와 동기화할 [FThemeData].
///
/// [FTheme] 위젯의 `data`로도 동일 인스턴스를 넘겨야 Forui 위젯과 Material 위젯 색이 어긋나지 않습니다.

final class ResolvedForuiThemeProvider
    extends $FunctionalProvider<FThemeData, FThemeData, FThemeData>
    with $Provider<FThemeData> {
  /// [MaterialApp]의 `theme`와 동기화할 [FThemeData].
  ///
  /// [FTheme] 위젯의 `data`로도 동일 인스턴스를 넘겨야 Forui 위젯과 Material 위젯 색이 어긋나지 않습니다.
  ResolvedForuiThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resolvedForuiThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resolvedForuiThemeHash();

  @$internal
  @override
  $ProviderElement<FThemeData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FThemeData create(Ref ref) {
    return resolvedForuiTheme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FThemeData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FThemeData>(value),
    );
  }
}

String _$resolvedForuiThemeHash() =>
    r'7fa07bd3e482cbbd078f9fd9540308a7227b7649';
