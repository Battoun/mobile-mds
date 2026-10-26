import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/sensors.dart';
import '../repositories/fake_sensor_repository.dart';
import '../repositories/sensor_repository.dart';
import '../screens/dashboard_screen.dart';
import '../screens/sensor_detail_screen.dart';
import '../view_models/dashboard_view_model.dart';

part 'app_router.g.dart';

// Choix de l'implémentation : pour l'instant le Fake, une vraie API viendra
// remplacer cette ligne sans que le ViewModel n'ait à changer.
final SensorRepository sensorRepository = FakeSensorRepository();
final DashboardViewModel dashboardViewModel = DashboardViewModel(
  repository: sensorRepository,
);

@TypedGoRoute<DashboardRoute>(
  path: '/',
  routes: [
    TypedGoRoute<SensorDetailRoute>(path: 'sensor/:id'),
  ],
)
class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DashboardScreen(viewModel: dashboardViewModel);
}

class SensorDetailRoute extends GoRouteData with $SensorDetailRoute {
  const SensorDetailRoute(this.id);

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final sensor = findSensorById(id);
    if (sensor == null) {
      return const Scaffold(
        body: Center(child: Text('Capteur introuvable')),
      );
    }
    return SensorDetailScreen(sensor: sensor);
  }
}

final GoRouter appRouter = GoRouter(routes: $appRoutes);
