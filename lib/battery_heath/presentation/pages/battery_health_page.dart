import 'package:bettery_health/battery_heath/presentation/value_notifier/battery_health_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryHealthPage extends StatefulWidget {
  const BatteryHealthPage({super.key});

  @override
  State<BatteryHealthPage> createState() => _BatteryHealthPageState();
}

class _BatteryHealthPageState extends State<BatteryHealthPage> {
  static const platform =
      MethodChannel('com.example.verygoodcore.bettery_health/batteryHealth');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Health'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Icon(
                  _getIcon(batteryHealthProvider.value),
                  size: MediaQuery.of(context).size.height * .2,
                  color: _getColor(batteryHealthProvider.value),
                ),
              ),
              Text(
                _getText(batteryHealthProvider.value),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: _getColor(batteryHealthProvider.value),
                    ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final result =
                        await platform.invokeMethod('getBatteryLevel');

                    if (result.runtimeType != double) {
                      throw Exception(result);
                    }

                    final percentage = result as double;

                    _showSnackBar(
                      context,
                      'Battery level: $percentage%',
                      Colors.green,
                    );

                    updateBatteryHealth(percentage);
                    setState(() {});
                  } catch (e) {
                    final error = e as PlatformException;
                    _showSnackBar(context, error.message!, Colors.red);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Get Battery Health',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String e, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            e,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
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
    }
  }

  String _getText(BatteryHealth value) {
    switch (value) {
      case BatteryHealth.emergency:
        return 'Emergency';
      case BatteryHealth.good:
        return 'Good';
      case BatteryHealth.full:
        return 'Full';
      case BatteryHealth.poor:
        return 'Poor';
    }
  }
}
