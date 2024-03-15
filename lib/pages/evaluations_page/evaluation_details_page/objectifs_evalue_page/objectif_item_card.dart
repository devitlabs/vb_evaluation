import 'package:flutter/material.dart';
import 'package:vb_performance/constants/police.dart';

import '../../../../widgets/custom_text.dart';

class ObjectifItem extends StatefulWidget {
  const ObjectifItem({super.key});

  @override
  State<ObjectifItem> createState() => _ObjectifItemState();
}

class _ObjectifItemState extends State<ObjectifItem> {

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onHover: (value){
        setState(() {
          _hovering = value;
        });
      },
      onTap: (){},
      child: Card(
        elevation: _hovering ? 5 : 2 ,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 10,right: 10,bottom: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  left: BorderSide(
                    color: Color(0xFFB0903D),
                    width: 10,
                  )
              )
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomText(text: "1",fontSize: policeNormal,),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 450,
                child: CustomText(text: "Realiser au 31 decembre 2024 100% des projets  assignés",fontSize: policeNormal),
              ),
              Expanded(child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomText(text: "Taux de réalisation  d'un projet achevé =100%, taux de de projet achevé >90%, % "
                    "de projets documentés, membre equipe projet, auteur des livrables",fontSize: policeNormal),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
