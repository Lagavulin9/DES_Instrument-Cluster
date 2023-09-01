import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';

class CANService {
  late final DBusClient client;
  late final DBusRemoteObject object;

  CANService() {
    _initializeDBus();
  }

  void _initializeDBus() {
    client = DBusClient.session();
    object = DBusRemoteObject(client,
        name: 'com.example.canService',
        path: DBusObjectPath('/com/example/canService'));
    // Your initialization code here
  }

  Future<int> getSpeed() async {
    int rpm = 0;
    int speed = -1;

    try {
      var recv =
          await object.callMethod("com.example.canService", "getRPM", []);
      int result = (recv.returnValues[0] as DBusInt32).value;
      rpm = result;
      speed = (rpm.toDouble() * 0.03).round();
      debugPrint("RPM: $rpm, speed: $speed");
    } on DBusServiceUnknownException {
      debugPrint('CAN service not available');
    }
    return speed;
  }
}
