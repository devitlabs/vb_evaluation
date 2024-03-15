import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/pages/evaluations_page/evaluation_details_page/onglet_card_evaluation.dart';
import 'package:vb_performance/widgets/custom_text.dart';

import 'exercices_page/card_exercice_evaluation.dart';
import 'header_evaluation.dart';

class EvaluationsPage extends StatefulWidget {
  final Widget child;
  const EvaluationsPage({super.key, required this.child});

  @override
  State<EvaluationsPage> createState() => _EvaluationsPageState();
}

class _EvaluationsPageState extends State<EvaluationsPage> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return  Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderEvaluation(),
            SizedBox(height: 10,),
            Expanded(child: widget.child),
          ],
        ),
      );
  }
}
