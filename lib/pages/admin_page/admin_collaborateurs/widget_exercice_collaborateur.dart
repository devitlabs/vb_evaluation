import 'package:flutter/material.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class WidgetExerciceCollaborateur extends StatefulWidget {
  final int number;
  const WidgetExerciceCollaborateur({super.key, required this.number});

  @override
  State<WidgetExerciceCollaborateur> createState() => _WidgetExerciceCollaborateurState();
}

class _WidgetExerciceCollaborateurState extends State<WidgetExerciceCollaborateur> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: "${widget.number}",fontSize: policeGrandTitre,),
    );
  }
}
