import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/logging/app_log.dart';
import 'gallery_demo_state.dart';

part 'gallery_demo.g.dart';

/// 갤러리 화면을 오갈 때 데모 값이 유지되도록 [keepAlive] 사용.
@Riverpod(keepAlive: true)
class GalleryDemo extends _$GalleryDemo {
  @override
  GalleryDemoState build() {
    AppLog.d('GalleryDemo provider built');
    return const GalleryDemoState();
  }

  void setNotificationsEnabled(bool value) {
    AppLog.d('notificationsEnabled -> $value');
    state = state.copyWith(notificationsEnabled: value);
  }

  void setTermsAccepted(bool value) {
    AppLog.d('termsAccepted -> $value');
    state = state.copyWith(termsAccepted: value);
  }

  void setPlanIndex(int index) {
    AppLog.d('planIndex -> $index');
    state = state.copyWith(planIndex: index);
  }

  void setSliderFraction(double fraction) {
    AppLog.d('sliderFraction -> $fraction');
    state = state.copyWith(sliderFraction: fraction);
  }

  void setPaginationPageIndex(int index) {
    AppLog.d('paginationPageIndex -> $index');
    state = state.copyWith(paginationPageIndex: index);
  }
}
