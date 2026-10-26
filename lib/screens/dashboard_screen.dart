import 'package:flutter/material.dart';

import '../router/app_router.dart';
import '../view_models/async_state.dart';
import '../view_models/dashboard_view_model.dart';
import '../widgets/sensor_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Appelé une seule fois, quand l'écran apparaît (pas à chaque build).
    widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder s'abonne au ViewModel et relance builder à chaque
    // notifyListeners() : l'écran suit Loading → Content / Failure.
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('SensorHub')),
        body: switch (widget.viewModel.state) {
          Loading() => const Center(child: CircularProgressIndicator()),
          Content(values: []) => const Center(child: Text('Aucun capteur')),
          Content(:final values) => ListView.builder(
              itemCount: values.length,
              itemBuilder: (context, index) {
                final sensor = values[index];
                return SensorCard(
                  sensor: sensor,
                  onTap: () => SensorDetailRoute(sensor.id).go(context),
                );
              },
            ),
          Failure(:final message) => Center(child: Text(message)),
        },
      ),
    );
  }
}
