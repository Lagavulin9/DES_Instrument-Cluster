import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

class NyanCat extends StatefulWidget {
  final int speed;

  NyanCat({required this.speed});

  @override
  State<NyanCat> createState() => _NyanCatState();
}

class _NyanCatState extends State<NyanCat> with TickerProviderStateMixin {
  var frameTime = 10000;
  late FlutterGifController controller, reverseController;

  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    controller.stop();
    reverseController = FlutterGifController(vsync: this);
    reverseController.repeat(
        min: 0, max: 11, period: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NyanCat oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.speed != widget.speed) {
      if (widget.speed > 0) {
        frameTime = (10000 - 705 * log(10000 * widget.speed + 1)).round();

        controller.repeat(
          min: 0,
          max: 11,
          period: Duration(milliseconds: frameTime),
        );
      } else {
        controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 50,
            height: 200,
            width: 600,
            child: GifImage(
              image: const AssetImage("images/nyancat.gif"),
              controller: controller,
            )),
        Positioned(
          top: 270,
          child: Text(
            widget.speed.toString(),
            style: const TextStyle(
                fontFamily: "Minecraft", fontSize: 80, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        const Positioned(
          top: 350,
          child: Text(
            "km/h",
            style: TextStyle(
                fontFamily: "Minecraft", fontSize: 40, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
