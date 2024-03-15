import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../../constants/colors.dart';
import '../../../constants/police.dart';
import '../../../models/departement_model.dart';
import '../../../widgets/custom_text.dart';

class DepartementController extends GetxController{
  final departements = <DepartementModel>[].obs;
  final filteredDepartements = <DepartementModel>[].obs;
  final isLoading = false.obs;

  void filterDepartements(String filter) {
    if (filter.isEmpty) {
      // Si le filtre est vide, affichez toutes les directions
      filteredDepartements.value = departements;
    } else {
      // Sinon, filtrez les directions en fonction du libellé
      filteredDepartements.value = departements.where((direction) {
        return direction.libelle.toLowerCase().contains(filter.toLowerCase());
      }).toList();
    }
  }

  Future getAllDepartements() async {
    isLoading.value = true;
    final String apiUrl = "${BASE_URL}/postes/read-all-departements";
    try {
      final response = await http.get(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'}
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<DepartementModel> directionList = jsonData.map((data) => DepartementModel.fromJson(data)).toList();
        departements.value = directionList;
        filteredDepartements.value = directionList;
        isLoading.value = false;
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false;
    }
  }

  Future<bool> addDepartement({required DepartementModel departementModel }) async {
    final String apiUrl = "${BASE_URL}/postes/create-departement";

    String requestBodyJson = json.encode(departementModel.toJson());

    try {
      final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: requestBodyJson
      );
      if (response.statusCode == 200) {
        await getAllDepartements();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> deleteDepartement({required String ID}) async {
    final String apiUrl = "${BASE_URL}/postes/delete-departement/${ID}";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        await getAllDepartements();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateDepartement({required DepartementModel departementModel }) async {
    final String apiUrl = "${BASE_URL}/postes/update-departement/${departementModel.id}";

    try {

      String requestBodyJson = json.encode(departementModel.toJson());

      final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: requestBodyJson
      );
      if (response.statusCode == 200) {
        await getAllDepartements();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

}

class DepartementWidget extends StatefulWidget {
  const DepartementWidget({super.key});

  @override
  State<DepartementWidget> createState() => _DepartementWidgetState();
}

class _DepartementWidgetState extends State<DepartementWidget> {

  final DepartementController departementController = Get.put(DepartementController());

  void showAddDirectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Ajouter un département'),
          contentPadding: EdgeInsets.all(20),
          content: SingleChildScrollView(
              child: FormulairePoste(typeFormulaire: 'create',id: null,libelle: null,)
          ),
        );
      },
    );
  }

  void showUpdateDirectionDialog(BuildContext context,DepartementModel departement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mise à jour - Département : ${departement.id}'),
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
              child: FormulairePoste(typeFormulaire: 'update',id: departement.id,libelle: departement.libelle)
          ),
        );
      },
    );
  }

  @override
  void initState() {
    departementController.getAllDepartements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Obx(()=> Column(
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Container(
                  width: 400,
                  height: 40,
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      departementController.filterDepartements(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Recherche",
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
                IconButton(
                    splashRadius: 20,onPressed: () async {
                  setState(() {
                    departementController.departements.value = [];
                  });
                  await departementController.getAllDepartements();
                },
                    icon: Icon(Icons.refresh)
                ),
                SizedBox(width: 20,),
                OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: secondaryColor,foregroundColor: Colors.white),onPressed: (){
                  showAddDirectionDialog(context);
                }, child:
                Container(height: 40,child: Center(child: CustomText(text: "Ajouter un département",fontSize: policeSousTitre,))))
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: DataTable2(
              border: const TableBorder(
                  top: BorderSide(color: primaryColor),
                  bottom: BorderSide(color: primaryColor),
                  right: BorderSide(color: primaryColor),
                  left: BorderSide(color: primaryColor)
              ),
              headingTextStyle: const TextStyle(color: Colors.white),
              headingRowDecoration: const BoxDecoration(
                color: primaryColor,
              ),
              columnSpacing: 10,
              empty: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Aucune donnée",),
                  SizedBox(height: 20,),
                  departementController.isLoading == true ? const CircularProgressIndicator() : IconButton(splashRadius: 20,onPressed: () async {
                    await departementController.getAllDepartements();
                  }, icon: Icon(Icons.refresh))
                ],
              ),
              columns: const [
                DataColumn2(label: Text("#"),fixedWidth: 50),
                DataColumn2(label: Text("Code Direction"),fixedWidth: 150),
                DataColumn2(label: Text("Libéllé")),
                DataColumn2(label: Text("Actions"),fixedWidth: 120)
              ],
              rows: departementController.filteredDepartements.map((direction) {
                return  DataRow2(cells: [
                  DataCell(Text("${departementController.filteredDepartements.indexOf(direction)+1}")),
                  DataCell(Text("${direction.id}")),
                  DataCell(Text("${direction.libelle}")),
                  DataCell(Row(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          showUpdateDirectionDialog(context,direction);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.spaceBetween,
                                title: Text("Confirmation"),
                                content: Text("Êtes-vous sûr de vouloir supprimer direction  : ${direction.id} ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                    },
                                    child: Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      departementController.deleteDepartement(ID: direction.id);
                                      Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                    },
                                    child: CustomText(text: "Confirmer",color: Colors.red,),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ))
                ]);
              }).toList()
          ))
        ],
      )),
    );
  }


}


class FormulairePoste extends StatefulWidget {
  final String? id;
  final String? libelle;
  final String typeFormulaire ;
  const FormulairePoste({super.key, required this.typeFormulaire, this.id, this.libelle});

  @override
  State<FormulairePoste> createState() => _FormulairePosteState();
}

class _FormulairePosteState extends State<FormulairePoste> {

  bool isSubmitting = false;
  String? id = null;
  String? libelle = null;
  final DepartementController departementController = Get.find();

  final GlobalKey<FormState> _formAddKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      id = widget.id;
      libelle = widget.libelle;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 220,
      child: Form(
        key: _formAddKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.id??"",
              enabled: !isSubmitting,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le code';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Code département',
                hintText: 'Entrer le code du département',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                id = value;
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              initialValue: widget.libelle??"",
              enabled: !isSubmitting,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le libellé';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Libellé département',
                  hintText: 'Entrez le libellé du département',
                  border: OutlineInputBorder()
              ),
              onChanged: (value) {
                libelle = value;
              },
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer la boîte de dialogue
                  },
                  child: CustomText(text: 'Annuler'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: isSubmitting ? null : () async {
                    if (_formAddKey.currentState!.validate()) {
                      setState(() {
                        isSubmitting = true;
                      });
                      final _direction = DepartementModel(id: id!, libelle: libelle!);
                      if (widget.typeFormulaire == "create") {
                        final result = await departementController.addDepartement(departementModel: _direction);
                        if (result) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.green,content: Text('Département enregistré avec succès')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.red,content: Text("Impossible d'enregistrer la direction.")),
                          );
                        }
                      }
                      else if (widget.typeFormulaire == "update") {
                        final result = await departementController.updateDepartement(departementModel: _direction);
                        if (result) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.green,content: Text('Département modifié avec succès')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.red,content: Text("Impossible de mettre à jour du département.")),
                          );
                        }
                      }
                      await Future.delayed(Duration(milliseconds: 500));
                      setState(() {
                        isSubmitting = false;
                      });
                    }
                  },
                  child: CustomText(text:'Soumettre'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}
