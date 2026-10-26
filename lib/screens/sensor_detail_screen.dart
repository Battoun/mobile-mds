import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/sensor.dart';

class SensorDetailScreen extends StatelessWidget {
  const SensorDetailScreen({super.key, required this.sensor});

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = sensor.isOnline ? Colors.green : Colors.grey;
    final String statusLabel = sensor.isOnline ? 'En ligne' : 'Hors ligne';

    return Scaffold(
      appBar: AppBar(title: Text('Capteur du ${sensor.name.toLowerCase()}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Icon(CupertinoIcons.circle_fill, color: statusColor, size: 10),
                const SizedBox(width: 6),
                Text(
                  statusLabel,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  _DetailRow(
                    label: 'Température',
                    value:
                        '${sensor.temperature.toStringAsFixed(1).replaceAll('.', ',')} °C',
                  ),
                  const Divider(height: 1),
                  _DetailRow(label: 'Humidité', value: '${sensor.humidity} %'),
                  const Divider(height: 1),
                  _DetailRow(label: 'Batterie', value: '${sensor.battery} %'),
                  const Divider(height: 1),
                  _DetailRow(label: 'État', value: sensor.state),
                  const Divider(height: 1),
                  _DetailRow(
                    label: 'Dernière mesure',
                    value: sensor.lastMeasurement,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
