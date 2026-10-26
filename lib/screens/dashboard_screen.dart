import 'package:flutter/material.dart';

import '../router/app_router.dart';
import '../view_models/dashboard_view_model.dart';
import '../widgets/sensor_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final sensors = viewModel.sensors;
    return Scaffold(
      appBar: AppBar(title: const Text('SensorHub')),
      body: ListView.builder(
        itemCount: sensors.length,
        itemBuilder: (context, index) {
          final sensor = sensors[index];
          return SensorCard(
            sensor: sensor,
            onTap: () => SensorDetailRoute(sensor.id).go(context),
          );
        },
      ),
    );
  }
}
