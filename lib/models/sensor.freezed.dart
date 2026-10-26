// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Sensor {

 String get id; String get name; double get temperature; int get humidity; bool get isOnline; int get battery; String get state; String get lastMeasurement;
/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorCopyWith<Sensor> get copyWith => _$SensorCopyWithImpl<Sensor>(this as Sensor, _$identity);

  /// Serializes this Sensor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Sensor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sensor&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.temperature, _this.temperature) || other.temperature == _this.temperature)&&(identical(other.humidity, _this.humidity) || other.humidity == _this.humidity)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.battery, _this.battery) || other.battery == _this.battery)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.lastMeasurement, _this.lastMeasurement) || other.lastMeasurement == _this.lastMeasurement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Sensor;
  return Object.hash(runtimeType,_this.id,_this.name,_this.temperature,_this.humidity,_this.isOnline,_this.battery,_this.state,_this.lastMeasurement);
}

@override
String toString() {
  final _this = this as Sensor;
  return 'Sensor(id: ${_this.id}, name: ${_this.name}, temperature: ${_this.temperature}, humidity: ${_this.humidity}, isOnline: ${_this.isOnline}, battery: ${_this.battery}, state: ${_this.state}, lastMeasurement: ${_this.lastMeasurement})';
}


}

/// @nodoc
abstract mixin class $SensorCopyWith<$Res>  {
  factory $SensorCopyWith(Sensor value, $Res Function(Sensor) _then) = _$SensorCopyWithImpl;
@useResult
$Res call({
 String id, String name, double temperature, int humidity, bool isOnline, int battery, String state, String lastMeasurement
});




}
/// @nodoc
class _$SensorCopyWithImpl<$Res>
    implements $SensorCopyWith<$Res> {
  _$SensorCopyWithImpl(this._self, this._then);

  final Sensor _self;
  final $Res Function(Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? temperature = null,Object? humidity = null,Object? isOnline = null,Object? battery = null,Object? state = null,Object? lastMeasurement = null,}) {
  return _then(Sensor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,lastMeasurement: null == lastMeasurement ? _self.lastMeasurement : lastMeasurement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Sensor].
extension SensorPatterns on Sensor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sensor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sensor value)  $default,){
final _that = this;
switch (_that) {
case _Sensor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sensor value)?  $default,){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double temperature,  int humidity,  bool isOnline,  int battery,  String state,  String lastMeasurement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.name,_that.temperature,_that.humidity,_that.isOnline,_that.battery,_that.state,_that.lastMeasurement);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double temperature,  int humidity,  bool isOnline,  int battery,  String state,  String lastMeasurement)  $default,) {final _that = this;
switch (_that) {
case _Sensor():
return $default(_that.id,_that.name,_that.temperature,_that.humidity,_that.isOnline,_that.battery,_that.state,_that.lastMeasurement);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double temperature,  int humidity,  bool isOnline,  int battery,  String state,  String lastMeasurement)?  $default,) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.name,_that.temperature,_that.humidity,_that.isOnline,_that.battery,_that.state,_that.lastMeasurement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Sensor implements Sensor {
  const _Sensor({required this.id, required this.name, required this.temperature, required this.humidity, required this.isOnline, required this.battery, required this.state, required this.lastMeasurement});
  factory _Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

@override final  String id;
@override final  String name;
@override final  double temperature;
@override final  int humidity;
@override final  bool isOnline;
@override final  int battery;
@override final  String state;
@override final  String lastMeasurement;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorCopyWith<_Sensor> get copyWith => __$SensorCopyWithImpl<_Sensor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sensor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.battery, battery) || other.battery == battery)&&(identical(other.state, state) || other.state == state)&&(identical(other.lastMeasurement, lastMeasurement) || other.lastMeasurement == lastMeasurement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,temperature,humidity,isOnline,battery,state,lastMeasurement);
}

@override
String toString() {
    return 'Sensor(id: $id, name: $name, temperature: $temperature, humidity: $humidity, isOnline: $isOnline, battery: $battery, state: $state, lastMeasurement: $lastMeasurement)';
}


}

/// @nodoc
abstract mixin class _$SensorCopyWith<$Res> implements $SensorCopyWith<$Res> {
  factory _$SensorCopyWith(_Sensor value, $Res Function(_Sensor) _then) = __$SensorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double temperature, int humidity, bool isOnline, int battery, String state, String lastMeasurement
});




}
/// @nodoc
class __$SensorCopyWithImpl<$Res>
    implements _$SensorCopyWith<$Res> {
  __$SensorCopyWithImpl(this._self, this._then);

  final _Sensor _self;
  final $Res Function(_Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? temperature = null,Object? humidity = null,Object? isOnline = null,Object? battery = null,Object? state = null,Object? lastMeasurement = null,}) {
  return _then(_Sensor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,lastMeasurement: null == lastMeasurement ? _self.lastMeasurement : lastMeasurement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
