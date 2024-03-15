import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class NoteGlobale extends StatefulWidget {
  const NoteGlobale({super.key});

  @override
  State<NoteGlobale> createState() => _NoteGlobaleState();
}

class _NoteGlobaleState extends State<NoteGlobale> {

  double _currentValue = 4.5;
  double _annotationFontSize = 25;


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 350,
          width: double.infinity,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                axisLineStyle: const AxisLineStyle(
                    thickness: 0.2,
                    thicknessUnit: GaugeSizeUnit.factor),
                showTicks: false,
                minimum: 0,
                maximum: 5,
                interval: 0.5,
                showLastLabel: true,
                pointers: <GaugePointer>[
                  RangePointer(
                      enableAnimation: true,
                      animationDuration: 3000,
                      color: const Color(0xFFFEB800),
                      value: _currentValue,
                      enableDragging: true,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        ' ${_currentValue} / 5',
                        style: TextStyle(
                            fontSize: policeGrandTitre,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.bold,
                            color: primaryBoldColor),
                      )
                    ],
                  ), positionFactor: 0.13, angle: 0)
                ])
          ]),
        ),
        CustomText(text: "Note Globale",fontSize: 25,isBold: true,)
      ],
    );
  }

}
