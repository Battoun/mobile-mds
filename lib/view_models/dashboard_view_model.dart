import 'package:flutter/foundation.dart';

import '../models/sensor.dart';
import '../repositories/sensor_repository.dart';
import 'async_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required SensorRepository repository})
      : _repository = repository;

  final SensorRepository _repository;

  AsyncState<Sensor> _state = const Loading<Sensor>();
  AsyncState<Sensor> get state => _state;

  void _setState(AsyncState<Sensor> value) {
    _state = value;
    notifyListeners();
  }

  Future<void> load() async {
    _setState(const Loading<Sensor>());
    try {
      final sensors = await _repository.fetchAll();
      _setState(Content<Sensor>(sensors));
    } catch (error) {
      _setState(Failure<Sensor>(error.toString()));
    }
  }

  // Compatibilité avec la View actuelle (dashboard_screen.dart) : elle lit
  // encore une liste "à plat", dérivée ici de l'état plutôt que stockée en
  // double. Aucun widget n'est modifié à cette étape.
  List<Sensor> get sensors => switch (_state) {
        Content(:final values) => List.unmodifiable(values),
        Loading() || Failure() => const [],
      };

  int get sensorCount => sensors.length;
  int get onlineCount => sensors.where((sensor) => sensor.isOnline).length;
  bool get hasOfflineSensors => sensors.any((sensor) => !sensor.isOnline);
}
