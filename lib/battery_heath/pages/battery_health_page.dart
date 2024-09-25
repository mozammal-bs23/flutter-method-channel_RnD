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
      body: const Center(
        child: Icon(
          Icons.battery_charging_full_rounded,
          size: 300,
          color: Colors.green,
        ),
      ),
    );
  }
}
