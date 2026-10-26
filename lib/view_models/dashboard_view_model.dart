import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/sensor.dart';
import '../repositories/sensor_repository.dart';
import 'async_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({
    required SensorRepository repository,
    this.staleAfter = const Duration(seconds: 30),
    DateTime Function()? clock,
  })  : _repository = repository,
        _clock = clock ?? DateTime.now;

  final SensorRepository _repository;
  final DateTime Function() _clock;

  /// Au-delà de cette durée sans succès, les données sont jugées anciennes.
  final Duration staleAfter;

  AsyncState<Sensor> _state = const Loading<Sensor>();
  AsyncState<Sensor> get state => _state;

  // Garde anti-superposition : tant qu'un chargement est en cours, les
  // nouveaux appels à load() sont ignorés. Le drapeau est mis à jour avant
  // chaque notification pour que la View lise toujours une valeur cohérente.
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Seule une réussite met cette date à jour ; une erreur la conserve.
  DateTime? _lastSuccessAt;
  DateTime? get lastSuccessAt => _lastSuccessAt;

  Timer? _staleTimer;

  void _setState(AsyncState<Sensor> value) {
    _state = value;
    notifyListeners();
  }

  Future<void> load() async {
    if (_isLoading) return;
    _isLoading = true;
    _setState(const Loading<Sensor>());
    try {
      final sensors = await _repository.fetchAll();
      _lastSuccessAt = _clock();
      _scheduleStaleNotification();
      _isLoading = false;
      _setState(Content<Sensor>(sensors));
    } catch (error) {
      _isLoading = false;
      _setState(Failure<Sensor>(error.toString()));
    }
  }

  // Prévient la View au moment où les données deviennent anciennes, pour
  // qu'elle se reconstruise sans attendre une autre notification.
  void _scheduleStaleNotification() {
    _staleTimer?.cancel();
    _staleTimer = Timer(staleAfter, notifyListeners);
  }

  String get lastRefreshLabel {
    final lastSuccessAt = _lastSuccessAt;
    if (lastSuccessAt == null) return 'Aucune actualisation réussie';
    return 'Dernière actualisation : ${_formatTime(lastSuccessAt)}';
  }

  bool get isStale {
    final lastSuccessAt = _lastSuccessAt;
    if (lastSuccessAt == null) return false;
    return _clock().difference(lastSuccessAt) >= staleAfter;
  }

  static String _formatTime(DateTime time) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${twoDigits(time.hour)}:${twoDigits(time.minute)}:'
        '${twoDigits(time.second)}';
  }

  List<Sensor> get sensors => switch (_state) {
        Content(:final values) => List.unmodifiable(values),
        Loading() || Failure() => const [],
      };

  int get sensorCount => sensors.length;
  int get onlineCount => sensors.where((sensor) => sensor.isOnline).length;
  bool get hasOfflineSensors => sensors.any((sensor) => !sensor.isOnline);

  @override
  void dispose() {
    _staleTimer?.cancel();
    super.dispose();
  }
}
