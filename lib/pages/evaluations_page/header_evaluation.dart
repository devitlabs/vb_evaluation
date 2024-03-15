import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/police.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_text.dart';

class HeaderEvaluation extends StatefulWidget {
  const HeaderEvaluation({super.key});

  @override
  State<HeaderEvaluation> createState() => _HeaderEvaluationState();
}

class _HeaderEvaluationState extends State<HeaderEvaluation> {

  final sectionTitle = {
    "objectifs":"Objectifs",
    "evaluation-mi-parcours":"Evaluation à m-parcours",
    "evaluation-finale":"Evaluation finale",
    "performances":"Performances"
  };

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final listString = location.split("/");
    return  SizedBox(
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          Icon(Icons.sticky_note_2,size: policeGrandTitre,color: primaryBoldColor,),
          const SizedBox(width: 10,),
          TextButton(onPressed: (){
            context.go("/espace/mes-evaluations");
          }, child:  CustomText(text: "Exercices d'évaluation",fontSize: policeGrandTitre,isBold: true,),),
          const SizedBox(width: 5,),
          if (listString.length > 4 ) Expanded(
            child: Row(
             children: [
              Row(
                children: [
                  const CustomText(text: "/",fontSize: 20,),
                  const SizedBox(width: 5,),
                  const CustomText(text: "2024",fontSize: 20,),
                  const SizedBox(width: 5,),
                  const CustomText(text: "/",fontSize: 20,),
                  const SizedBox(width: 5,),
                  const CustomText(text: "S. Bamba",fontSize: 20,),
                  const SizedBox(width: 5,),
                  const CustomText(text: "/",fontSize: 20,),
                  const SizedBox(width: 5,),
                  CustomText(text: "${sectionTitle[listString.last]}",fontSize: 20,),
                ],
              ),
             ],
            ),
          ),
        ],
      ),
    );
  }
}
