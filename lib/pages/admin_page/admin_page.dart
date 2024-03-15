import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

import 'admin_application.dart';
import 'admin_collaborateurs/admin_collaborateurs.dart';
import 'admin_exercice/admin_exercice.dart';
import 'admin_poste/admin_poste.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose only if _tabController is not null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.settings, size: policeGrandTitre, color: primaryBoldColor),
                const SizedBox(width: 10),
                CustomText(text: "Espace d'administration", fontSize: policeGrandTitre, color: primaryBoldColor, isBold: true),
              ],
            ),
            const SizedBox(height: 10),
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
                    Tab(text: "Exercices d'évaluation"),
                    Tab(text: "Collaborateurs",),
                    Tab(text: "Postes"),
                    Tab(text: "Application"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                    // Contenu pour l'onglet "Exercices d'évaluation"
                    AdminExercice(),
                    // Contenu pour l'onglet "Collaborateurs"
                    TableauCollaborateur(),
                    // Contenu pour l'onglet "Postes"
                    AdminPoste(),
                    // Contenu pour l'onglet "Application"
                    AdminApplication(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
