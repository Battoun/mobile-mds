import '../data/sensors.dart';
import '../models/sensor.dart';
import 'sensor_repository.dart';

class FakeSensorRepository implements SensorRepository {
  FakeSensorRepository({
    this.data = kSensors,
    this.latency = const Duration(seconds: 2),
    this.shouldThrow = false,
  });

  final List<Sensor> data;
  final Duration latency;
  final bool shouldThrow;

  @override
  Future<List<Sensor>> fetchAll() async {
    await Future.delayed(latency);
    if (shouldThrow) {
      throw Exception('Impossible de récupérer les capteurs.');
    }
    return List.of(data);
  }
}
