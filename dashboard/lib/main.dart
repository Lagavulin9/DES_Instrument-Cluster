import 'package:flutter/material.dart';
import 'dart:async';
import 'my_radial_gauge.dart';
import 'my_rpm_gauge.dart';
import 'my_fuel_gauge.dart';
import 'my_engine_gauge.dart';
import 'package:dbus/dbus.dart';

class DBusService {
  late final DBusClient client;
  late final DBusRemoteObject object;

  DBusService() {
    _initializeDBus();
  }

  void _initializeDBus() {
    client = DBusClient.session();
    object = DBusRemoteObject(client,
        name: 'com.example.dbusService',
        path: DBusObjectPath('/com/example/dbusService'));
    // Your initialization code here
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  double speed = 0;
  double rpm = 0;
  final interface = DBusService();

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is first created
    _startTimer();
  }

  @override
  void dispose() {
    // Make sure to cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Create a timer that triggers every 1 second
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // Call the updateSpeed() function here
      updateSpeed();
    });
  }

  // The function you want to trigger every 1 second
  void updateSpeed() async {
    // Add your code here to update the speed or do any other tasks

    try {
      var reply = await interface.object
          .callMethod("com.example.dbusService", "getRPM", []);
      int result = (reply.returnValues[0] as DBusInt32).value;
      if (result != -1) {
        rpm = result.toDouble();
        speed = rpm * 0.03;
        // print("RPM: $rpm, speed: $speed");
      }
    } on DBusServiceUnknownException {
      debugPrint('Notification service not available');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color(0xff01010c),
          body: Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 150),
              height: 1000,
              child: Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: FuelGaugeWidget(
                        min: 0,
                        max: 100,
                        fuel: 70,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: EngineGaugeWidget(
                        min: 0,
                        max: 100,
                        temp: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: 500,
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 80),
                child: RadialGaugeWidget(
                  min: 0,
                  max: 200,
                  speed: speed,
                )),
            SizedBox(
              width: 300,
              height: 300,
              child: RPMGaugeWidget(
                min: 0,
                max: 5,
                rpm: rpm,
              ),
            )
          ]))),
    );
  }
}
