import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_demo_state.freezed.dart';

/// 갤러리 폼·네비게이션 데모용 불변 상태 (Switch / Checkbox / Radio / Slider / Pagination).
@freezed
abstract class GalleryDemoState with _$GalleryDemoState {
  const factory GalleryDemoState({
    @Default(true) bool notificationsEnabled,
    @Default(false) bool termsAccepted,
    @Default(0) int planIndex,
    @Default(0.35) double sliderFraction,
    @Default(0) int paginationPageIndex,
  }) = _GalleryDemoState;
}
