import '../models/sensor.dart';

abstract interface class SensorRepository {
  Future<List<Sensor>> fetchAll();
}
