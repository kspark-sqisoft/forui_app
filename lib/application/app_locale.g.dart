// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_locale.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// [MaterialApp.router]의 `locale`에 바인딩되는 앱 로케일.
///
/// Forui 문자열은 [FLocalizations]가 [Locale]에 맞는 ARB를 고릅니다.
/// `supportedLocales`에는 반드시 [FLocalizations.supportedLocales]를 넘기고,
/// 여기서는 그 중에서 **ko / en / ja**만 버튼으로 빠르게 전환하는 예시를 둡니다.
///
/// 참고: https://forui.dev/docs (Localization)

@ProviderFor(AppLocale)
final appLocaleProvider = AppLocaleProvider._();

/// [MaterialApp.router]의 `locale`에 바인딩되는 앱 로케일.
///
/// Forui 문자열은 [FLocalizations]가 [Locale]에 맞는 ARB를 고릅니다.
/// `supportedLocales`에는 반드시 [FLocalizations.supportedLocales]를 넘기고,
/// 여기서는 그 중에서 **ko / en / ja**만 버튼으로 빠르게 전환하는 예시를 둡니다.
///
/// 참고: https://forui.dev/docs (Localization)
final class AppLocaleProvider extends $NotifierProvider<AppLocale, Locale> {
  /// [MaterialApp.router]의 `locale`에 바인딩되는 앱 로케일.
  ///
  /// Forui 문자열은 [FLocalizations]가 [Locale]에 맞는 ARB를 고릅니다.
  /// `supportedLocales`에는 반드시 [FLocalizations.supportedLocales]를 넘기고,
  /// 여기서는 그 중에서 **ko / en / ja**만 버튼으로 빠르게 전환하는 예시를 둡니다.
  ///
  /// 참고: https://forui.dev/docs (Localization)
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$appLocaleHash() => r'9358f8537b1c92276cb3b0b46ee246abfd9521a6';

/// [MaterialApp.router]의 `locale`에 바인딩되는 앱 로케일.
///
/// Forui 문자열은 [FLocalizations]가 [Locale]에 맞는 ARB를 고릅니다.
/// `supportedLocales`에는 반드시 [FLocalizations.supportedLocales]를 넘기고,
/// 여기서는 그 중에서 **ko / en / ja**만 버튼으로 빠르게 전환하는 예시를 둡니다.
///
/// 참고: https://forui.dev/docs (Localization)

abstract class _$AppLocale extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
