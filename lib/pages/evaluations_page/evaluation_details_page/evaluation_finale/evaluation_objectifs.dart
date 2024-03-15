import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class EvaluationObjectifs extends StatefulWidget {
  const EvaluationObjectifs({super.key});

  @override
  State<EvaluationObjectifs> createState() => _EvaluationObjectifsState();
}

class _EvaluationObjectifsState extends State<EvaluationObjectifs> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 30,
            padding: const EdgeInsets.only(left: 10),
            color: const Color(0xFFBFBFBF),
            alignment: Alignment.centerLeft,
            child: CustomText(text: "I - Evaluation des objectifs",fontSize: policeSousTitre,isBold: true,),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(width: 80,child: CustomText(text: "Numéro",isBold: true,fontSize: policeMedium,)),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: CustomText(text: "Description de l'objectif à atteindre",isBold: true,fontSize: policeMedium,))),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: CustomText(text: "Eléments de mesure",isBold: true,fontSize: policeMedium,))),
                      const SizedBox(width: 5,),
                      SizedBox(width: 80,child: CustomText(text: "Note",isBold: true,fontSize: policeMedium,)),
                      const SizedBox(width: 5,),
                      SizedBox(width: 250,child: CustomText(text: "Commentaires",isBold: true,fontSize: policeMedium,))
                    ],
                  ),
                ),
                Container(height: 1,width: double.infinity,color: Colors.grey),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                  child: Row(
                    children: [
                      const SizedBox(width: 80,child: CustomText(text: "1")),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: const CustomText(text: "Realiser au 31 decembre 2024 100% des projets  assignés",))),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: const CustomText(text: "Taux de réalisation  d'un projet achevé =100%, taux de de projet achevé >90%, % de projets documentés, membre equipe projet, auteur des livrables"))),
                      const SizedBox(width: 5,),
                      const SizedBox(width: 80,child: CustomText(text: "4.5 / 5")),
                      const SizedBox(width: 5,),
                      const SizedBox(width: 250,child: CustomText(text: "RAS"))
                    ],
                  ),
                ),
                Container(height: 1,width: double.infinity,color: Colors.grey),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                  child: Row(
                    children: [
                      SizedBox(width: 80,child: CustomText(text: "2",fontSize: policeNormal)),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: CustomText(text: "Renforcer l'automatisation au 31 decembre 2024 des processus metiers manuels",fontSize: policeNormal))),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: CustomText(text: "Nombre d'automatisations nouvelles>4",fontSize: policeNormal))),
                      const SizedBox(width: 5,),
                      SizedBox(width: 80,child: CustomText(text: "4.5 / 5",fontSize: policeNormal)),
                      const SizedBox(width: 5,),
                      SizedBox(width: 250,child: CustomText(text: "RAS",fontSize: policeNormal))
                    ],
                  ),
                ),
                Container(height: 1,width: double.infinity,color: Colors.grey),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                  child: Row(
                    children: [
                      const SizedBox(width: 80,child: CustomText(text: "3")),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: const CustomText(text: "Maintenir au 31 decembre 2024 un climat repondant à nos valeurs (DIRE)",))),
                      const SizedBox(width: 5,),
                      Expanded(child: Container(child: const CustomText(text: "Nombre de conflit avéré et non traité =< 1"))),
                      const SizedBox(width: 5,),
                      const SizedBox(width: 80,child: CustomText(text: "4.5 / 5")),
                      const SizedBox(width: 5,),
                      const SizedBox(width: 250,child: CustomText(text: "RAS"))
                    ],
                  ),
                ),
                Container(height: 1,width: double.infinity,color: Colors.grey),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(child: Container(height: 40,color: const Color(0xFFF2F2F2),child: Center(child: CustomText(text: "Note Moyenne après évaluation des objectifs",isBold: true,fontSize: policeMedium)))),
                      const SizedBox(width: 5,),
                      SizedBox(width: 80,child: CustomText(text: "4.5 / 5",fontSize: policeMedium)),
                      const SizedBox(width: 5,),
                      SizedBox(width: 250,child: CustomText(text: "RAS",fontSize: policeMedium,)),
                      const SizedBox(width: 10,),
                    ],
                  ),
                ),
              ],
            ),
          )
    ])
    );
  }
}
