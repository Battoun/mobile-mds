import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/sensor.dart';
import '../router/app_router.dart';
import '../view_models/async_state.dart';
import '../view_models/dashboard_view_model.dart';
import '../widgets/sensor_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder (fourni par Flutter) s'abonne au ChangeNotifier et
    // relance builder à chaque notifyListeners(). Provider viendra plus tard.
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('SensorHub'),
          actions: [
            _RefreshAction(
              isLoading: viewModel.isLoading,
              onRefresh: viewModel.load,
            ),
          ],
        ),
        body: Column(
          children: [
            _LastRefreshBanner(
              label: viewModel.lastRefreshLabel,
              isStale: viewModel.isStale,
            ),
            Expanded(child: _buildBody(context, viewModel.state)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AsyncState<Sensor> state) =>
      switch (state) {
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
        Failure(:final message) => _ErrorView(
            message: message,
            onRetry: viewModel.load,
          ),
      };
}

class _RefreshAction extends StatelessWidget {
  const _RefreshAction({required this.isLoading, required this.onRefresh});

  final bool isLoading;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(14),
        child: SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return IconButton(
      tooltip: 'Actualiser',
      icon: const Icon(CupertinoIcons.arrow_clockwise),
      onPressed: onRefresh,
    );
  }
}

class _LastRefreshBanner extends StatelessWidget {
  const _LastRefreshBanner({required this.label, required this.isStale});

  final String label;
  final bool isStale;

  @override
  Widget build(BuildContext context) {
    final color = isStale ? Colors.orange.shade800 : Colors.grey.shade600;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Row(
        children: [
          Icon(
            isStale
                ? CupertinoIcons.exclamationmark_triangle_fill
                : CupertinoIcons.time,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              isStale ? '$label · données anciennes' : label,
              style: TextStyle(color: color, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.wifi_exclamationmark,
              size: 48,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Réessayer')),
          ],
        ),
      ),
    );
  }
}
