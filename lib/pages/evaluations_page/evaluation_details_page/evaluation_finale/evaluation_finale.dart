import 'package:flutter/material.dart';

import '../objectifs_evalue_page/element_identification.dart';
import 'evaluation_objectifs.dart';

class EvaluationFinale extends StatefulWidget {
  const EvaluationFinale({super.key});

  @override
  State<EvaluationFinale> createState() => _EvaluationFinaleState();
}

class _EvaluationFinaleState extends State<EvaluationFinale> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            ElementIdentification(),
            SizedBox(height: 10,),
            EvaluationObjectifs(),
          ],
        ),
      ),
    );
  }
}
