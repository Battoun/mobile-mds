import 'package:flutter/foundation.dart';

import '../data/sensors.dart';
import '../models/sensor.dart';
import 'sensor_repository.dart';

class FakeSensorRepository implements SensorRepository {
  FakeSensorRepository({
    this.data = kSensors,
    this.latency = const Duration(seconds: 2),
    this.failingCalls = const {},
  });

  final List<Sensor> data;
  final Duration latency;

  // Numéros d'appels (à partir de 1) qui échouent. Ex. {1, 3} : le premier
  // chargement échoue, le deuxième réussit, le troisième échoue à nouveau…
  final Set<int> failingCalls;

  // Observation uniquement : nombre de chargements réellement exécutés.
  int _callCount = 0;
  int get callCount => _callCount;

  @override
  Future<List<Sensor>> fetchAll() async {
    final call = ++_callCount;
    debugPrint('[FakeSensorRepository] fetchAll #$call');
    await Future.delayed(latency);
    if (failingCalls.contains(call)) {
      throw Exception('Impossible de récupérer les capteurs.');
    }
    return List.of(data);
  }
}
