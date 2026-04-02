import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logging/app_log.dart';

/// Riverpod 랩 페이지 시뮬 — 도시 3곳.
enum LabCity {
  seoul('서울'),
  london('런던'),
  tokyo('도쿄');

  const LabCity(this.label);
  final String label;
}

/// 시뮬 날씨 종류 (아이콘은 UI에서 [FIcons]로 매핑).
enum LabWeatherKind {
  clear('맑음'),
  cloudy('흐림'),
  rain('비'),
  snow('눈'),
  fog('안개'),
  thunder('천둥번개');

  const LabWeatherKind(this.label);
  final String label;
}

/// [cityProvider] + 무작위 [LabWeatherKind].
final class LabWeatherResult {
  const LabWeatherResult({required this.city, required this.kind});

  final LabCity city;
  final LabWeatherKind kind;

  String get line => '${city.label} — ${kind.label}';
}

final cityProvider = NotifierProvider<CityNotifier, LabCity>(CityNotifier.new);

class CityNotifier extends Notifier<LabCity> {
  @override
  LabCity build() {
    AppLog.i("----------------------------->");
    AppLog.i('cityProvider build');
    ref.onDispose(() {
      AppLog.i('cityProvider disposed');
    });
    ref.onCancel(() {
      AppLog.i('cityProvider cancelled');
    });
    ref.onResume(() {
      AppLog.i('cityProvider resumed');
    });
    ref.onAddListener(() {
      AppLog.i('cityProvider added listener');
    });
    ref.onRemoveListener(() {
      AppLog.i('cityProvider removed listener');
    });
    return LabCity.seoul;
  }

  void select(LabCity city) {
    state = city;
    AppLog.i('CityNotifier selected $city');
  }
}

/// [cityProvider]를 watch → 도시가 바뀔 때마다 1초 뒤 무작위 날씨.
final weatherProvider = FutureProvider.autoDispose<LabWeatherResult>((
  ref,
) async {
  final city = ref.watch(cityProvider);
  await Future<void>.delayed(const Duration(seconds: 1));
  final kinds = LabWeatherKind.values;
  final kind = kinds[Random().nextInt(kinds.length)];
  AppLog.i("----------------------------->>>>");
  AppLog.i('weatherProvider build: $city, $kind');
  ref.onDispose(() {
    AppLog.i('weatherProvider disposed');
  });
  ref.onCancel(() {
    AppLog.i('weatherProvider cancelled');
  });
  ref.onResume(() {
    AppLog.i('weatherProvider resumed');
  });
  ref.onAddListener(() {
    AppLog.i('weatherProvider added listener');
  });
  ref.onRemoveListener(() {
    AppLog.i('weatherProvider removed listener');
  });
  return LabWeatherResult(city: city, kind: kind);
});
