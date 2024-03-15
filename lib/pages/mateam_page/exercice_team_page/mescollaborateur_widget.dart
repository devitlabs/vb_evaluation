import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/colors.dart';

import '../../../constants/police.dart';
import '../../../widgets/custom_text.dart';

class MesCollaborateursWidget extends StatefulWidget {
  const MesCollaborateursWidget({super.key});

  @override
  State<MesCollaborateursWidget> createState() => _MesCollaborateursWidgetState();
}

class _MesCollaborateursWidgetState extends State<MesCollaborateursWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(20)
      ),
      child:  Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 400,
                  height: 40,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Nom du collaborateur",
                      labelText: "Recherche",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: secondaryColor),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                CustomText(text: "10 Collabotrateurs N-1",fontSize: policeMedium,color: primaryColor,),
                SizedBox(width: 20,),
                OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: secondaryColor,foregroundColor: Colors.white),onPressed: (){}, child:
                Container(height: 40,child: Center(child: CustomText(text: "Ajouter",fontSize: policeSousTitre,))))
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: Container(
            alignment: Alignment.topLeft,
            child: DataTable2Demo(),
          ))
        ],
      ),
    );
  }
}

class DataTable2Demo extends StatefulWidget {
  const DataTable2Demo({super.key});

  @override
  DataTable2DemoState createState() => DataTable2DemoState();
}

class DataTable2DemoState extends State<DataTable2Demo> {


  @override
  Widget build(BuildContext context) {
    return DataTable2(
      isHorizontalScrollBarVisible: true,
      isVerticalScrollBarVisible: true,
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 900,
      border: TableBorder(
          top: BorderSide(color: Colors.grey[300]!),
          bottom: BorderSide(color: Colors.grey[300]!),
          left: BorderSide(color: Colors.grey[300]!),
          right: BorderSide(color: Colors.grey[300]!),
          horizontalInside: BorderSide(color: Colors.grey[300]!)),
      columns: const [
        DataColumn2(
          label: const Text('#'),
          size: ColumnSize.S,
          // example of fixed 1st row
          fixedWidth: 100
        ),
        DataColumn2(
          label: const Text('Matricule'),
          size: ColumnSize.S,
          fixedWidth: 100
        ),
        DataColumn2(
          label: const Text('Nom & Prénom(s)'),
          size: ColumnSize.S, fixedWidth: 250
        ),
        DataColumn2(
          label: const Text('Email'),
          size: ColumnSize.S,
            fixedWidth: 200
        ),
        DataColumn2(
          label: const Text('Direction/Département/Service-Cellule'),
          size: ColumnSize.S,
            fixedWidth: 100
        ),
        DataColumn2(
          label: const Text("Fixation d'objectifs"),
          size: ColumnSize.S,
            fixedWidth: 150
        ),
        DataColumn2(
          label: const Text('Calcium (%)'),
          size: ColumnSize.S,
          numeric: true,
        ),
        DataColumn2(
          label: const Text('Iron (%)'),
          size: ColumnSize.S,
          numeric: true,
        ),
      ],
      empty: Center(
          child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.grey[200],
              child: const Text('Aucune donnée'))
      ),
      rows: [
        DataRow2(cells: [
          DataCell(Text("Orange")),
          DataCell(Text("Orange")),
          DataCell(Text("Orange")),
          DataCell(Text("Orange")),
          DataCell(Text("Orange")),
          DataCell(Text("Orange")),
          DataCell(Text("Orange")),
          DataCell(IconButton(splashRadius: 20,onPressed: (){
            context.go("/espace/ma-team/exercices/2024/collaborateurs-n-1/sbamba");
          },icon: Icon(Icons.edit),)),
        ])
      ],
    );
  }
}

