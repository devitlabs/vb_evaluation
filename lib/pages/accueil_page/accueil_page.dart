import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    initialisation();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final storage = const FlutterSecureStorage();
  String? _token;

  void initialisation() async {
    String? value = await storage.read(key: "token");
    if (value != null ) {
      setState(() {
        _token = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgScafoldColor,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Accueil",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.visibility,color: Colors.grey,),
                )
              ],
            ),
          ),
          Expanded(child: Scrollbar(
            controller: _scrollController,
            thickness: 10,
            radius: Radius.circular(3),
            trackVisibility: true,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                color: bgScafoldColor,
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(child: Container(
                            height: 100,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                      color: Color(0xFF000000).withOpacity(0.25)
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFCFE8FF),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  width: 60,
                                  height: 60,
                                  child: Center(
                                    child: Icon(Icons.event_note_outlined,color: Color(0xFF3C91E6),),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("2023",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    SizedBox(height: 5,),
                                    Text("Exercice d'évaluation actuel",style: TextStyle(fontSize: 14),)
                                  ],
                                )
                              ],
                            ),
                          )),
                          SizedBox(width: 20,),
                          Expanded(child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                      color: Color(0xFF000000).withOpacity(0.25)
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFEE7AA),
                                      borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 60,
                                  height: 60,
                                  child: Center(
                                    child: Icon(Icons.sticky_note_2_rounded,color: Color(0xFF774A18),),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("4.4/5",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    SizedBox(height: 5,),
                                    Text("Note d'évaluation finale",style: TextStyle(fontSize: 14),)
                                  ],
                                )
                              ],
                            ),
                          )),
                          SizedBox(width: 20,),
                          Expanded(child: Container(
                            height: 100,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                      color: Color(0xFF000000).withOpacity(0.25)
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFA9EBBB),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  width: 60,
                                  height: 60,
                                  child: const Center(
                                    child: Icon(Icons.my_location_rounded,color: Color(0xFF229342),),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("3",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    SizedBox(height: 5,),
                                    Text("Nombre total des objectifs",style: TextStyle(fontSize: 14),)
                                  ],
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container(
                          height: 600,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                    color: Color(0xFF000000).withOpacity(0.25)
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Exercices d'évaluation",fontSize: policeSousTitre,isBold: true,),
                              SizedBox(height: 20,),
                              Expanded(child: DataTable2(
                                columns: [
                                  DataColumn2(label: Text("Execice d'évaluation")),
                                  DataColumn2(label: Text("Période",),fixedWidth: 150),
                                  DataColumn2(label: Text("Statut",),fixedWidth: 100)
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(Text("Exerice 1")),
                                    DataCell(Text("Exerice 1")),
                                    DataCell(Text("Exerice 1"))
                                  ])
                                ],
                                empty:  CustomText(text: "Aucune donnée",),
                              ))
                            ],
                          ),
                        )),
                        SizedBox(width: 20,),
                        Expanded(child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                    color: Color(0xFF000000).withOpacity(0.25)
                                )
                              ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Objectifs 2023",fontSize: policeSousTitre,isBold: true,),
                              SizedBox(height: 20,),
                              Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                    left: BorderSide(
                                      color: primaryColor,
                                      width: 10
                                    )
                                  )
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text("#1 Superviser et contrôler (capacité à s’assurer de la bonne réalisation des tâches et activité de l’équipe)",
                                      overflow: TextOverflow.ellipsis,),
                                    ),
                                    SizedBox(width: 5,),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,size: 20,))
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border(
                                        left: BorderSide(
                                            color: primaryColor,
                                            width: 10
                                        )
                                    )
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text("#1 Superviser et contrôler (capacité à s’assurer de la bonne réalisation des tâches et activité de l’équipe)",
                                        overflow: TextOverflow.ellipsis,),
                                    ),
                                    SizedBox(width: 5,),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,size: 20,))
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border(
                                        left: BorderSide(
                                            color: primaryColor,
                                            width: 10
                                        )
                                    )
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text("#1 Superviser et contrôler (capacité à s’assurer de la bonne réalisation des tâches et activité de l’équipe)",
                                        overflow: TextOverflow.ellipsis,),
                                    ),
                                    SizedBox(width: 5,),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,size: 20,))
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border(
                                        left: BorderSide(
                                            color: primaryColor,
                                            width: 10
                                        )
                                    )
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text("#1 Superviser et contrôler (capacité à s’assurer de la bonne réalisation des tâches et activité de l’équipe)",
                                        overflow: TextOverflow.ellipsis,),
                                    ),
                                    SizedBox(width: 5,),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,size: 20,))
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
