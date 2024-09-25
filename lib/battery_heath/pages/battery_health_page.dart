import 'package:bettery_health/battery_heath/value_notifier/battery_health_provider.dart';
import 'package:flutter/material.dart';

class BatteryHealthPage extends StatefulWidget {
  const BatteryHealthPage({super.key});

  @override
  State<BatteryHealthPage> createState() => _BatteryHealthPageState();
}

class _BatteryHealthPageState extends State<BatteryHealthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Health'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              _getIcon(batteryHealthProvider.value),
              size: 300,
              color: _getColor(batteryHealthProvider.value),
            ),
          ),
          Text(
            '100%',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: _getColor(batteryHealthProvider.value),
                ),
          ),
        ],
      ),
    );
  }

  Color? _getColor(BatteryHealth batteryHealth) {
    if (batteryHealth == BatteryHealth.emergency) {
      return Colors.red;
    } else if (batteryHealth == BatteryHealth.good ||
        batteryHealth == BatteryHealth.full) {
      return Colors.green;
    } else if (batteryHealth == BatteryHealth.poor) {
      return Colors.yellow;
    } else if (batteryHealth == BatteryHealth.saver) {
      return Colors.orange;
    } else {
      return null;
    }
  }

  IconData _getIcon(BatteryHealth value) {
    switch (value) {
      case BatteryHealth.emergency:
        return Icons.battery_0_bar_rounded;
      case BatteryHealth.good:
        return Icons.battery_3_bar_rounded;
      case BatteryHealth.full:
        return Icons.battery_full_rounded;
      case BatteryHealth.poor:
        return Icons.battery_2_bar_rounded;
      case BatteryHealth.saver:
        return Icons.battery_saver_rounded;
    }
  }
}
