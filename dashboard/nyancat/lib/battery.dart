import 'package:flutter/material.dart';

class BatteryIcon extends StatefulWidget {
  final int battery_level;

  BatteryIcon({required this.battery_level});

  @override
  State<BatteryIcon> createState() => _BatteryIconState();
}

class _BatteryIconState extends State<BatteryIcon> {
  final Image icon = const Image(
    width: 50,
    image: AssetImage('images/heart2.png'),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.battery_level > 70
          ? [icon, icon, icon]
          : widget.battery_level > 40
              ? [icon, icon]
              : [icon],
    );
  }
}
