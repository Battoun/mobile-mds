// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Sensor _$SensorFromJson(Map<String, dynamic> json) => _Sensor(
  id: json['id'] as String,
  name: json['name'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
  isOnline: json['isOnline'] as bool,
  battery: (json['battery'] as num).toInt(),
  state: json['state'] as String,
  lastMeasurement: json['lastMeasurement'] as String,
);

Map<String, dynamic> _$SensorToJson(_Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'temperature': instance.temperature,
  'humidity': instance.humidity,
  'isOnline': instance.isOnline,
  'battery': instance.battery,
  'state': instance.state,
  'lastMeasurement': instance.lastMeasurement,
};
