import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class NoteObjectifs extends StatefulWidget {
  const NoteObjectifs({super.key});

  @override
  State<NoteObjectifs> createState() => _NoteObjectifsState();
}

class _NoteObjectifsState extends State<NoteObjectifs> {

  double progressValue = 20;
  double _size = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _widgetNoteObjectifs(),
          SizedBox(width: 20,),
          CustomText(text: "Note d'évaluation des objectifs",fontSize: policeSousTitre,isBold: true,)
        ],
      ),
    );
  }

  Widget _widgetNoteObjectifs() {
    return SizedBox(
        height: _size,
        width: _size,
        child: SfRadialGauge(axes: <RadialAxis>[
          // Create primary radial axis
          RadialAxis(
            interval: 25,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.85,
            axisLineStyle:  AxisLineStyle(
              thickness: 0.2,
              color: Color(0xFFFEB800).withOpacity(0.3),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  value: progressValue,
                  width: 0.05,
                  color: Color(0xFFFEB800),
                  pointerOffset: 0.07,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 30,
                  animationType: AnimationType.linear)
            ],
          ),
          // Create secondary radial axis for segmented line
          RadialAxis(
            interval: 25,
            showLabels: false,
            showAxisLine: false,
            tickOffset: -0.05,
            offsetUnit: GaugeSizeUnit.factor,
            minorTicksPerInterval: 0,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.85,
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.1,
                  widget: Text("4 / 5 ",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Calibri',
                          fontWeight: FontWeight.bold,
                          fontSize: policeSousTitre)))
            ],
            majorTickStyle: const MajorTickStyle(
                length: 0.3,
                thickness: 3,
                lengthUnit: GaugeSizeUnit.factor,
                color: Colors.white,
          ))
        ])
    );
  }
}
