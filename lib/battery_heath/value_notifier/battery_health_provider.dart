import 'package:flutter/material.dart';

enum BatteryHealth {
  emergency,
  poor,
  good,
  full,
  saver,
}

final batteryHealthProvider = ValueNotifier<BatteryHealth>(BatteryHealth.saver);
