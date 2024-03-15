import 'package:flutter/material.dart';

import 'card_exercice_evaluation.dart';

class ExercicesPage extends StatefulWidget {
  const ExercicesPage({super.key});

  @override
  State<ExercicesPage> createState() => _ExercicesPageState();
}

class _ExercicesPageState extends State<ExercicesPage> {
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 10,
      alignment: WrapAlignment.start,
      children: [
        CardExerciceEvaluation(),
        CardExerciceEvaluation(),
        CardExerciceEvaluation(),
      ],
    );
  }
}
