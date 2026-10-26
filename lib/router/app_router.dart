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
//
// Scénario de démonstration : réponse lente (3 s), 1er appel en erreur,
// 2e en succès, 3e en erreur (l'heure du dernier succès est conservée), puis
// succès. Seuil « données anciennes » réduit à 10 s pour la démo.
final SensorRepository sensorRepository = FakeSensorRepository(
  latency: const Duration(seconds: 3),
  failingCalls: {1, 3},
);
final DashboardViewModel dashboardViewModel = DashboardViewModel(
  repository: sensorRepository,
  staleAfter: const Duration(seconds: 10),
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
