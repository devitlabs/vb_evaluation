import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/police.dart';

import '../../../constants/colors.dart';
import '../../../widgets/custom_text.dart';

class CardExerciceEvaluation extends StatefulWidget {
  const CardExerciceEvaluation({super.key});

  @override
  State<CardExerciceEvaluation> createState() => _CardExerciceEvaluationState();
}

class _CardExerciceEvaluationState extends State<CardExerciceEvaluation> {

  double titleSize = 16;
  double contenuSize = policeNormal;

  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value){
        setState(() {
          _isHovering = value;
        });
      },
      onTap: (){},
      child: Card(
        color: Colors.white,
        elevation: _isHovering ? 5 : 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/evaluation.png",height: 25,width: 25,),
                    const SizedBox(width: 10,),
                    CustomText(text: "Exercice d’évaluation 2024",isBold: true,fontSize: policeSousTitre,)
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    CustomText(text: "Période : ",fontSize: contenuSize,),
                    CustomText(text: "01/01/2024 - 31/12/2024",fontSize: contenuSize,),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    CustomText(text: "Phase : ",fontSize: contenuSize,),
                    CustomText(text: "Fixation d’objectifs",fontSize: contenuSize,color: Color(0xFF686BB9),),
                    CustomText(text: " -  ",fontSize: contenuSize,),
                    CustomText(text: "Terminé",fontSize: contenuSize,color: Colors.green,),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    CustomText(text: "Evalué : S. Bamba" ,fontSize: contenuSize,),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    CustomText(text: "Statut de l’évalué : ",fontSize: contenuSize,),
                    CustomText(text: " Objectifs fixés",fontSize: contenuSize,color: Colors.green,),
                  ],
                ),
                const SizedBox(height: 15,),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: primaryColor
                  ),
                  onPressed: (){
                    context.go("/espace/mes-evaluations/objectifs");
                  },
                  child: CustomText(text: "Consulter votre évaluation",fontSize: contenuSize,color: Colors.white,),
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
