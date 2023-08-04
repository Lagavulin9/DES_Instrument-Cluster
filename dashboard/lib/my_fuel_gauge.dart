import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FuelGaugeWidget extends StatefulWidget {
  final double min, max, fuel;

  FuelGaugeWidget({required this.min, required this.max, required this.fuel});

  @override
  _FuelGaugeWidgetState createState() => _FuelGaugeWidgetState();
}

class _FuelGaugeWidgetState extends State<FuelGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: widget.min,
          maximum: widget.max,
          startAngle: 210,
          endAngle: 330,
          interval: 50,
          labelOffset: 20,
          showFirstLabel: true,
          showLastLabel: true,
          onLabelCreated: axisLabelCreated,
          majorTickStyle: const MajorTickStyle(
              length: 15, thickness: 3, color: Colors.white),
          minorTickStyle: const MinorTickStyle(
              length: 10, thickness: 2, color: Colors.white),
          axisLabelStyle: const GaugeTextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: widget.min,
              endValue: widget.max,
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.05,
              endWidth: 0.05,
              gradient: const SweepGradient(
                  colors: <Color>[Colors.red, Colors.yellow, Colors.green],
                  stops: <double>[0.0, 0.5, 1]),
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: widget.fuel,
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
              tailStyle: const TailStyle(
                width: 5,
                length: 0.08,
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
              widget: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'images/fuel-gas-station-white-icon-transparent-background.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.4,
            ),
          ],
        ),
      ],
    );
  }

  void axisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '0') {
      args.text = 'E';
    } else if (args.text == '100') {
      args.text = 'F';
    } else {
      args.text = '';
    }
    args.labelStyle = const GaugeTextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFFFFFFFF),
    );
  }
}
