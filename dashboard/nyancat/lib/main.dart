import 'dart:async';
import 'package:flutter/material.dart';
import 'battery.dart';
import 'nyan_cat.dart';
import 'can.service.dart';
import 'piracer.service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Dashboard', home: Dashboard());
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  Timer? _timer;
  final can_interface = CANService();
  final piracer_interface = PiracerService();
  int speed = 0;
  int rpm = 0;
  int battery_percentage = 0;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is first created
    _startTimer();
  }

  void _startTimer() {
    // Create a timer that triggers every 1 second
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // Call the updateSpeed() function here
      fetch();
    });
  }

  void fetch() async {
    // Add your code here to update the speed or do any other tasks
    speed = await can_interface.getSpeed();
    battery_percentage = await piracer_interface.getBattery();

    setState(() {});
  }

  @override
  void dispose() {
    // Make sure to cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: 1280,
            height: 400,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),
            child: NyanCat(
              speed: speed,
            )),
        Positioned(
            top: 20,
            right: 30,
            child: BatteryIcon(battery_level: battery_percentage)),
      ],
    ));
  }
}
