import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGaugeWidget extends StatefulWidget {
  final double min, max, speed;

  RadialGaugeWidget(
      {required this.min, required this.max, required this.speed});

  @override
  _RadialGaugeWidgetState createState() => _RadialGaugeWidgetState();
}

class _RadialGaugeWidgetState extends State<RadialGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: widget.min,
          maximum: widget.max,
          interval: 20,
          labelOffset: 30,
          showFirstLabel: true,
          showLastLabel: true,
          majorTickStyle: const MajorTickStyle(
              length: 15, thickness: 5, color: Colors.white),
          minorTickStyle: const MinorTickStyle(
              length: 10, thickness: 4, color: Colors.white),
          axisLabelStyle: const GaugeTextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: widget.min,
              endValue: widget.max,
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.03,
              endWidth: 0.03,
              gradient: const SweepGradient(
                  colors: <Color>[Colors.green, Colors.yellow, Colors.red],
                  stops: <double>[0.0, 0.5, 1]),
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: widget.speed,
              enableAnimation: true,
              needleColor: Colors.red,
              needleEndWidth: 8,
              needleLength: 0.8,
              gradient: const LinearGradient(colors: <Color>[
                Color(0xFFFF6B78),
                Color(0xFFFF6B78),
                Color(0xFFE20A22),
                Color(0xFFE20A22)
              ], stops: <double>[
                0,
                0.5,
                0.5,
                1
              ]),
              knobStyle:
                  const KnobStyle(knobRadius: 0.03, color: Color(0xff111111)),
              tailStyle: const TailStyle(
                width: 8,
                length: 0.15,
                gradient: LinearGradient(colors: <Color>[
                  Color(0xFFFF6B78),
                  Color(0xFFFF6B78),
                  Color(0xFFE20A22),
                  Color(0xFFE20A22)
                ], stops: <double>[
                  0,
                  0.5,
                  0.5,
                  1
                ]),
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                widget.speed.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              angle: 90,
              positionFactor: 0.45,
            ),
            const GaugeAnnotation(
              widget: Text(
                "km/h",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              angle: 90,
              positionFactor: 0.6,
            ),
          ],
        ),
      ],
    );
  }
}
