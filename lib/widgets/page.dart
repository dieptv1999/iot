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
        return Stack(
          alignment: Alignment.center,
          overflow: Overflow.clip,
          children: [
            Container(
              height: 300,
              width: 300,
              child: SfRadialGauge(
                axes: <RadialAxis>[
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
                        needleColor: Colors.transparent,
                        needleStartWidth: 1.5,
                        needleEndWidth: 1.5,
                        needleLength: 30,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(70)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '20 \u2103',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Celcius',
                      style: TextStyle(
                        color: Color.fromARGB(100, 0, 0, 0),
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
