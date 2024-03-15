import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class SectionTeamExercice extends StatefulWidget {
  const SectionTeamExercice({super.key});

  @override
  State<SectionTeamExercice> createState() => _SectionTeamExerciceState();
}

class _SectionTeamExerciceState extends State<SectionTeamExercice> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.start,
      children: [
        widgetCardExerciceItem(),
        widgetCardExerciceItem(),
        widgetCardExerciceItem()
      ],
    );
  }

  Widget widgetCardExerciceItem() {
    return Card(
      child: Container(
        height: 220,
        width: 350,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
              image: AssetImage("assets/images/image_bg_card.png")
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("assets/icons/evaluation.png",height: 30,width: 30,),
                SizedBox(width: 10,),
                CustomText(text: "Exercice d'évaluation 2024",isBold: true,fontSize: policeSousTitre)
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                CustomText(text: "Période : ",fontSize: policeNormal,),
                CustomText(text: "01/01/2024 - 31/12/2024",fontSize: policeNormal,),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                CustomText(text: "Phase actuelle : ",fontSize: policeNormal,),
                CustomText(text: "Fixation d’objectifs",fontSize: policeNormal,color: Color(0xFF686BB9),),
                CustomText(text: " -  ",fontSize: policeNormal,),
                CustomText(text: "Terminé",fontSize: policeNormal,color: Colors.green,),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                CustomText(text: "Collaborateurs N-1 : ",fontSize: policeNormal,),
                CustomText(text: "10",fontSize: policeNormal,color: primaryColor,isBold: true,),
                CustomText(text: "    N-2 : ",fontSize: policeNormal,),
                CustomText(text: "20",fontSize: policeNormal,color: primaryColor,isBold: true,),
              ],
            ),
            const SizedBox(height: 15,),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: primaryColor
              ),
              onPressed: (){
                context.go("/espace/ma-team/exercices/2024");
              },
              child: CustomText(text: "Entrer dans cet espace",fontSize: policeNormal,color: Colors.white,),
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
