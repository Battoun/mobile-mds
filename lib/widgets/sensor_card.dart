import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/sensor.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({super.key, required this.sensor, this.onTap});

  final Sensor sensor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = sensor.isOnline ? Colors.green : Colors.grey;
    final String statusLabel = sensor.isOnline ? 'En ligne' : 'Hors ligne';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sensor.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${sensor.temperature} °   •   ${sensor.humidity} %',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.circle_fill, color: statusColor, size: 8),
                  const SizedBox(width: 6),
                  Text(
                    statusLabel,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Icon(
                CupertinoIcons.chevron_forward,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
