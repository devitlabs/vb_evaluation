import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class AdminApplication extends StatefulWidget {
  const AdminApplication({super.key});

  @override
  State<AdminApplication> createState() => _AdminApplicationState();
}

class _AdminApplicationState extends State<AdminApplication> {

  bool estMaintenance = false;
  bool bloqueUserNonAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            child: Container(
              height: 150,
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        CustomText(text: "Mettre l'application en maintenance",fontSize: policeSousTitre,),
                        Expanded(child: Container()),
                        CupertinoSwitch(value: estMaintenance, onChanged: (value){
                          setState(() {
                            estMaintenance = value;
                          });
                        },activeColor: Colors.red,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        CustomText(text: "Bloquer les utilisateurs non administrateurs",fontSize: policeSousTitre,),
                        Expanded(child: Container()),
                        CupertinoSwitch(value: bloqueUserNonAdmin, onChanged: (value){
                          setState(() {
                            bloqueUserNonAdmin = value;
                          });
                        },activeColor: Colors.red,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
