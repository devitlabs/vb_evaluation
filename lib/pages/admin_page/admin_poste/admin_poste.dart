import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';
import 'departement_widget.dart';
import 'direction_widget.dart';
import 'service_cellule_widget.dart';

class AdminPoste extends StatefulWidget {
  const AdminPoste({super.key});

  @override
  State<AdminPoste> createState() => _AdminPosteState();
}

class _AdminPosteState extends State<AdminPoste> {

  int currentNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 200,height: double.infinity,child: Column(
            children: [
              buttonAdminPoste(title: "Direction",number: 0,),
              SizedBox(height: 20,),
              buttonAdminPoste(title: "Département",number: 1,),
              SizedBox(height: 20,),
              buttonAdminPoste(title: "Service/Cellule",number: 2,),
              SizedBox(height: 20,),
            ],
          )),
          const SizedBox(width: 20,),
          Expanded(child: currentNumber == 0 ? const DirectionWidget() :
          currentNumber == 1 ? const DepartementWidget() :
          currentNumber == 2 ? const ServiceCelluleWidget() : Container() )
        ],
      ),
    );
  }

  Widget buttonAdminPoste({required String title,required int number}) {
    return OutlinedButton(style: currentNumber == number ?  OutlinedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white
    ) : null ,onPressed: (){
      setState(() {
        currentNumber = number;
      });
    }, child: SizedBox(
      width: 150,
      height: 30,
      child: Center(child: CustomText(text: "${title}",fontSize: policeSousTitre,)),
    ));
  }
}






