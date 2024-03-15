import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/widgets/custom_text.dart';

import '../../constants/police.dart';
import 'infos_hierarchie.dart';
import 'infos_personnelles.dart';
import 'sessions_connexion.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person,size: policeGrandTitre,color: primaryBoldColor,),
              const SizedBox(width: 10,),
              CustomText(text: "Profil",fontSize: policeGrandTitre,isBold: true,color: primaryBoldColor,),
            ],
          ),
          const SizedBox(height: 10,),
          // Add Tabs There
          const Expanded(child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfosPersonnelles(),
                  SizedBox(height: 20,),
                  InfosHierarchie(),
                  SizedBox(height: 20,),
                  SessionsConnexion()
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
