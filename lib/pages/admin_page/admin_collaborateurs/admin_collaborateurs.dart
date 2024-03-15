import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/police.dart';
import '../../../widgets/custom_text.dart';
import 'widget_exercice_collaborateur.dart';
import 'widget_tous_collaborateur.dart';

class TableauCollaborateur extends StatefulWidget {
  const TableauCollaborateur({super.key});

  @override
  State<TableauCollaborateur> createState() => _TableauCollaborateurState();
}

class _TableauCollaborateurState extends State<TableauCollaborateur> {

  int currentNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buttonAdminPoste(title: "Tous",number: 0),
            SizedBox(width: 20,),
            buttonAdminPoste(title: "2023",number: 1),
          ],
        ),
        SizedBox(height: 10,),
        Expanded(child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryColor)
          ),
          child: Column(
            children: [
              Expanded(child: currentNumber == 0 ? const WidgetTousCollaborateur() : WidgetExerciceCollaborateur(
                number: currentNumber,
              ) )
            ],
          ),
        ),)
      ],
    );
  }

  Widget buttonAdminPoste({required String title,required int number}) {
    return OutlinedButton(style: currentNumber == number ?  OutlinedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white
    ) : null ,onPressed: (){
      setState(() {
        currentNumber = number;
      });
    }, child: SizedBox(
      width: 50,
      height: 30,
      child: Center(child: CustomText(text: "${title}",fontSize: policeSousTitre,)),
    ));
  }

}
