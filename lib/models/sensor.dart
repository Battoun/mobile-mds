import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor.freezed.dart';
part 'sensor.g.dart';

@freezed
abstract class Sensor with _$Sensor {
  const factory Sensor({
    required String id,
    required String name,
    required double temperature,
    required int humidity,
    required bool isOnline,
    required int battery,
    required String state,
    required String lastMeasurement,
  }) = _Sensor;

  factory Sensor.fromJson(Map<String, dynamic> json) =>
      _$SensorFromJson(json);
}
