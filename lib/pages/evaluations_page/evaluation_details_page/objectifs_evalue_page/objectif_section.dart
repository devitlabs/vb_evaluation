import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vb_performance/constants/police.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/custom_text.dart';
import 'objectif_item_card.dart';

class ObjectifSection extends StatefulWidget {
  const ObjectifSection({super.key});

  @override
  State<ObjectifSection> createState() => _ObjectifSectionState();
}

class _ObjectifSectionState extends State<ObjectifSection> {
  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(text: "Objectifs 2024",color: primaryBoldColor,isBold: true,fontSize: policeSousTitre,),
            const SizedBox(width: 10,),
            Expanded(child: Container(),),
            CustomText(text: "Statut : ",fontSize: policeSousTitre),
            const SizedBox(width: 10,),
            CustomText(text: "Validé",fontSize: policeSousTitre,color: Colors.green,isBold: true,),
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFB0903D),
          ),
          child: Row(
            children: [
              Container(
                child: const CustomText(text: "#",fontSize: 18,color:Colors.white,),
                width: 30,
                margin: const EdgeInsets.symmetric(horizontal: 5),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const CustomText(text: "Description de l'objectif à atteindre",fontSize: 18,color:Colors.white),
                width: 450,
              ),
              Expanded(child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const CustomText(text: "Eléments de mesure",fontSize: 18,color:Colors.white),
              )),
              Container(width: 50),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        const ObjectifItem(),
        const SizedBox(height: 10,),
        const ObjectifItem(),
        const SizedBox(height: 10,),
        const ObjectifItem(),
        const SizedBox(height: 10,),
        const ObjectifItem(),
        const SizedBox(height: 10,),
      ],
    );
  }
}
