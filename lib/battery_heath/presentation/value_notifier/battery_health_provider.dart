import 'package:flutter/material.dart';

enum BatteryHealth {
  emergency,
  poor,
  good,
  full,
}

final batteryHealthProvider = ValueNotifier<BatteryHealth>(BatteryHealth.good);

void updateBatteryHealth(double percentage) {
  if (percentage == 0) {
    batteryHealthProvider.value = BatteryHealth.emergency;
  } else if (percentage <= 10) {
    batteryHealthProvider.value = BatteryHealth.poor;
  } else if (percentage < 90) {
    batteryHealthProvider.value = BatteryHealth.good;
  } else if (percentage == 100) {
    batteryHealthProvider.value = BatteryHealth.full;
  } else {
    throw Exception('Unexpected battery level: $percentage');
  }
}
