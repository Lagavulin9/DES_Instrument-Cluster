import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PiracerService {
  late final DBusClient client;
  late final DBusRemoteObject object;

  PiracerService() {
    _initializeDBus();
  }

  void _initializeDBus() {
    client = DBusClient.session();
    object = DBusRemoteObject(client,
        name: 'com.example.piracerService',
        path: DBusObjectPath('/com/example/piracerService'));
    // Your initialization code here
  }

  Future<int> getBattery() async {
    double voltage = 0;
    int percentage = -1;

    try {
      var recv = await object
          .callMethod("com.example.piracerService", "getVoltage", []);
      voltage = (recv.returnValues[0] as DBusDouble).value;
      percentage =
          ((0.498 * sin(1.546 * voltage * 0.33 + 1.001) + 0.48) * 100).round();
      if (percentage > 100) {
        percentage = 100;
      } else if (percentage < 0) {
        percentage = 0;
      }
      debugPrint("Voltage: $voltage, percentage: $percentage");
    } on DBusServiceUnknownException {
      debugPrint('Piracer service not available');
    }
    return percentage;
  }
}
