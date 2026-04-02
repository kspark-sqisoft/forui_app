// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_demo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 갤러리 화면을 오갈 때 데모 값이 유지되도록 [keepAlive] 사용.

@ProviderFor(GalleryDemo)
final galleryDemoProvider = GalleryDemoProvider._();

/// 갤러리 화면을 오갈 때 데모 값이 유지되도록 [keepAlive] 사용.
final class GalleryDemoProvider
    extends $NotifierProvider<GalleryDemo, GalleryDemoState> {
  /// 갤러리 화면을 오갈 때 데모 값이 유지되도록 [keepAlive] 사용.
  GalleryDemoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'galleryDemoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$galleryDemoHash();

  @$internal
  @override
  GalleryDemo create() => GalleryDemo();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GalleryDemoState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GalleryDemoState>(value),
    );
  }
}

String _$galleryDemoHash() => r'3fe64fc08307477a95ba58a5b1465a7e7df00d13';

/// 갤러리 화면을 오갈 때 데모 값이 유지되도록 [keepAlive] 사용.

abstract class _$GalleryDemo extends $Notifier<GalleryDemoState> {
  GalleryDemoState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GalleryDemoState, GalleryDemoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GalleryDemoState, GalleryDemoState>,
              GalleryDemoState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
