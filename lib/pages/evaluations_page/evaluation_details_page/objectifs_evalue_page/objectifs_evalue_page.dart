import 'package:flutter/material.dart';
import 'element_identification.dart';
import 'objectif_section.dart';

class ObjectifsEvaluePage extends StatefulWidget {
  const ObjectifsEvaluePage({super.key});

  @override
  State<ObjectifsEvaluePage> createState() => _ObjectifsEvaluePageState();
}

class _ObjectifsEvaluePageState extends State<ObjectifsEvaluePage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            ElementIdentification(),
            SizedBox(height: 10,),
            ObjectifSection(),
          ],
        ),
      ),
    );
  }
}



