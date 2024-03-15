import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/police.dart';
import '../../../widgets/custom_text.dart';
import '../../evaluations_page/evaluation_details_page/objectifs_evalue_page/element_identification.dart';

class TeamCollaborateurPage extends StatefulWidget {
  const TeamCollaborateurPage({super.key});

  @override
  State<TeamCollaborateurPage> createState() => _TeamCollaborateurPageState();
}

class _TeamCollaborateurPageState extends State<TeamCollaborateurPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TabBar(
              indicatorColor: primaryColor,
              labelPadding: const EdgeInsets.only(left: 10, right: 10),
              indicatorWeight: 3.0,
              isScrollable: true,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4,
                    color: primaryColor,
                  ),
                  insets: EdgeInsets.only(
                      left: 0,
                      right: 8,
                      bottom: 4)
              ),
              tabAlignment: TabAlignment.start,
              controller: _tabController,
              labelStyle : TextStyle(color: Colors.black,fontSize: policeMedium,fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "Fixation des objectifs"),
                Tab(text: "Evaluation à mi-parcours",),
                Tab(text: "Evaluation finale"),
                Tab(text: "Performances"),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Contenu pour l'onglet "Exercices d'évaluation"
              TeamCollaborateurObjectifs(),
              // Contenu pour l'onglet "Collaborateurs"
              Container(),
              // Contenu pour l'onglet "Postes"
              Container(),
              // Contenu pour l'onglet "Application"
              Container(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}


class TeamCollaborateurObjectifs extends StatefulWidget {
  const TeamCollaborateurObjectifs({super.key});

  @override
  State<TeamCollaborateurObjectifs> createState() => _TeamCollaborateurObjectifsState();
}

class _TeamCollaborateurObjectifsState extends State<TeamCollaborateurObjectifs> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            ElementIdentification(),
            SizedBox(height: 20,),
            Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      CustomText(text: "Workflow des objectifs",color: primaryBoldColor,isBold: true,fontSize: policeSousTitre,),
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.yellow,
                        child: Center(child: CustomText(text: "En attente de soumission",fontSize: policeSousTitre,color: Colors.black,)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                CustomText(text: "Liste des objectifs 2024",color: primaryBoldColor,isBold: true,fontSize: policeSousTitre,),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 200,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

