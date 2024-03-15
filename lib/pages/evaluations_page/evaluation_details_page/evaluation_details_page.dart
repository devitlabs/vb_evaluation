import 'package:flutter/material.dart';
import 'onglet_card_evaluation.dart';

class EvaluationDetailsPage extends StatefulWidget {
  final Widget child;
  const EvaluationDetailsPage({super.key, required this.child});

  @override
  State<EvaluationDetailsPage> createState() => _EvaluationDetailsPageState();
}

class _EvaluationDetailsPageState extends State<EvaluationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OngletExercice(),
        SizedBox(height: 10,),
        Expanded(child: widget.child )
      ],
    );
  }
}
