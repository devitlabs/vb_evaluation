import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vb_performance/widgets/custom_text.dart';

import '../../../models/collaborateur_model.dart';
import 'admin_collaborateur_controller.dart';


class CollaborateurDataSource extends DataGridSource {

  CollaborateurDataSource({required List<CollaborateurModel> collaborateurs}) {
    dataGridRows = collaborateurs
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'matricule', value: dataGridRow.matricule),
      DataGridCell<String>(columnName: 'nom', value: dataGridRow.nom),
      DataGridCell<String>(columnName: 'prenoms', value: dataGridRow.prenoms),
      DataGridCell<String>(columnName: 'email', value: dataGridRow.email),
      DataGridCell<String>(columnName: 'statutProfil', value: dataGridRow.email),
      DataGridCell<String>(columnName: 'dateentreevb', value: dataGridRow.dateentreevb),
      DataGridCell<String>(columnName: 'actions', value: dataGridRow.email),
    ]
    )).toList();
  }

  List<DataGridRow> dataGridRows = [];

  final AdminCollaborateurController adminCollaborateurController = Get.find();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          switch (dataGridCell.columnName) {
            case "actions":
              return ActionWidget(email:dataGridCell.value);
            case "statutProfil":
              return statutProfilWidget(email:dataGridCell.value);
            default :
              return Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Text(
                    "${dataGridCell.value??""}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ));
          }
        }).toList()
    );
  }


  // Widget actionsWidget({required String? email}) {
  //   final collaborateur = adminCollaborateurController.collaborateurs.firstWhere((element) => element.email == email);
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
  //     child: Row(
  //       children: [
  //         collaborateur.estbloque == false ? Icon(Icons.lock_open_outlined,color: Colors.green,) : Icon(Icons.lock_outline,color: Colors.red,),
  //         const SizedBox(width: 10,),
  //         IconButton(
  //             onPressed: (){},
  //             splashRadius: 20,
  //             icon: const Icon(Icons.delete,color: Colors.red,)),
  //       ],
  //     ),
  //   );
  // }

  Widget statutProfilWidget({required String? email}) {
    final collaborateur = adminCollaborateurController.collaborateurs.firstWhere((element) => element.email == email);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              color: collaborateur.isCompleteProfil() ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: CustomText(text: collaborateur.isCompleteProfil() ? "Complet" :"Incomplet",color: Colors.white,)),
          )
        ],
      ),
    );
  }
}


class ActionWidget extends StatefulWidget {
  final String? email;
  const ActionWidget({super.key, this.email});

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  final AdminCollaborateurController adminCollaborateurController = Get.find();

  @override
  Widget build(BuildContext context) {
    final collaborateur = adminCollaborateurController.collaborateurs.firstWhere((element) => element.email == widget.email);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Row(
        children: [
          collaborateur.estbloque == false ? Icon(Icons.lock_open_outlined,color: Colors.green,) : Icon(Icons.lock_outline,color: Colors.red,),
          const SizedBox(width: 10,),
          IconButton(
              onPressed: (){
                _showDeleteConfirmationDialog(context,widget.email??"");
              },
              splashRadius: 20,
              icon: const Icon(Icons.delete,color: Colors.red,)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context,String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Supprimer le collaborateur"),
          content: Text("Êtes-vous sûr de vouloir supprimer ${email} ?"),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: CustomText(text: "Annuler",color: Colors.black,),
            ),
            TextButton(
              onPressed: () async {
                final result = await adminCollaborateurController.deleteCollaborateur(email: email);
                if (result) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(backgroundColor: Colors.green,content: Text('Succès')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(backgroundColor: Colors.red,content: Text('Echec')),
                  );
                }
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: CustomText(text: "Supprimer",color: Colors.red,),
            ),
          ],
        );
      },
    );
  }
}
