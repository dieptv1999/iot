import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Pages extends StatefulWidget {
  final int type;

  const Pages({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PagesState();
  }
}

class PagesState extends State<Pages> {
  double _volumeValue = 30;

  onVolumeChanged(val) {}

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 1:
        return Container(
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              startAngle: 270,
              endAngle: 270,
              showLabels: true,
              showTicks: true,
              radiusFactor: 0.6,
              labelOffset: -20,
              tickOffset: -10,
              axisLineStyle: AxisLineStyle(
                  cornerStyle: CornerStyle.bothFlat,
                  color: Colors.black12,
                  thickness: 3),
              pointers: <GaugePointer>[
                RangePointer(
                  value: _volumeValue,
                  cornerStyle: CornerStyle.bothFlat,
                  width: 4,
                  sizeUnit: GaugeSizeUnit.logicalPixel,
                  color: Colors.greenAccent,
                ),
                NeedlePointer(
                    value: _volumeValue,
                    enableDragging: true,
                    onValueChanged: onVolumeChanged,
                    needleColor: Colors.greenAccent,
                    needleStartWidth: 1.5,
                    needleEndWidth: 1.5,
                    needleLength: 30,
                    knobStyle: KnobStyle(
                        color: Colors.white,
                        borderColor: Colors.greenAccent,
                        borderWidth: 2,
                        knobRadius: 30,
                        sizeUnit: GaugeSizeUnit.logicalPixel))
              ],
            )
          ]),
        );
      default:
        return Container();
    }
  }
}
