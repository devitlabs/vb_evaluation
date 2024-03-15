import 'package:flutter/material.dart';
import 'package:vb_performance/constants/police.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/custom_text.dart';
import '../objectifs_evalue_page/element_identification.dart';
import 'note_globale.dart';
import 'note_objectifs.dart';
import 'note_tenue_poste.dart';

class PerformancesEvalue extends StatefulWidget {
  const PerformancesEvalue({super.key});

  @override
  State<PerformancesEvalue> createState() => _PerformancesEvalueState();
}

class _PerformancesEvalueState extends State<PerformancesEvalue> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementIdentification(),
          SizedBox(height: 10,),
          PerformanceWidget(),
        ],
      ),
    );
  }
}

class PerformanceWidget extends StatefulWidget {
  const PerformanceWidget({super.key});

  @override
  State<PerformanceWidget> createState() => _PerformanceWidgetState();
}

class _PerformanceWidgetState extends State<PerformanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Notes de l'exercice d'évaluation",color: primaryBoldColor,isBold: true,fontSize: policeSousTitre,),
        const SizedBox(height: 10,),
        Card(
          child: Container(
            height: 410,
            padding: const EdgeInsets.all(10),
            child: const Row(
              children: [
                Expanded(flex: 2,child: NoteGlobale()),
                SizedBox(width: 10,),
                Expanded(flex: 3,child: Column(
                  children: [
                    Expanded(child: NoteObjectifs()),
                    Expanded(child: NoteTenuePoste())
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}

