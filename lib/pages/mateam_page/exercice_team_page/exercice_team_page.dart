import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/police.dart';
import '../../../widgets/custom_text.dart';
import 'mescollaborateur_widget.dart';

class ExerciceTeamPage extends StatefulWidget {
  const ExerciceTeamPage({super.key});

  @override
  State<ExerciceTeamPage> createState() => _ExerciceTeamPageState();
}

class _ExerciceTeamPageState extends State<ExerciceTeamPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TabBar(
              indicatorColor: primaryColor,
              onTap: (index){

              },
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
                Tab(text: "Collaborateurs N-1",),
                Tab(text: "Collaborateurs N-2"),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              MesCollaborateursWidget(),
              MesCollaborateursWidget(),
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
