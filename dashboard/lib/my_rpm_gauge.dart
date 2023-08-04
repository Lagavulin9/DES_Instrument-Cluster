import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RPMGaugeWidget extends StatefulWidget {
  final double min, max, rpm;

  RPMGaugeWidget({required this.min, required this.max, required this.rpm});

  @override
  _RPMGaugeWidgetState createState() => _RPMGaugeWidgetState();
}

class _RPMGaugeWidgetState extends State<RPMGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 120,
          endAngle: 240,
          minimum: widget.min,
          maximum: widget.max,
          showFirstLabel: true,
          showLastLabel: true,
          interval: 1,
          labelOffset: 25,
          majorTickStyle: const MajorTickStyle(
              length: 15, thickness: 5, color: Colors.white),
          // minorTickStyle:
          //   MinorTickStyle(length: 10, thickness: 2, color: Colors.white),
          axisLabelStyle: const GaugeTextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: widget.min,
              endValue: widget.max,
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.01,
              endWidth: 0.068,
              gradient: const SweepGradient(
                  colors: <Color>[Colors.green, Colors.yellow, Colors.red],
                  stops: <double>[0.0, 0.5, 1]),
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: widget.rpm / 1000,
              enableAnimation: true,
              needleColor: Colors.red,
              needleEndWidth: 5,
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
            ),
          ],
          annotations: const <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                "x1000",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              angle: 60,
              positionFactor: 0.5,
            ),
            GaugeAnnotation(
              widget: Text(
                "rpm",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              angle: 67,
              positionFactor: 0.65,
            ),
          ],
        ),
      ],
    );
  }
}
