import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../constants/colors.dart';
import '../../../constants/police.dart';
import '../../../models/service_cellule_model.dart';
import '../../../widgets/custom_dropdown_field.dart';
import '../../../widgets/custom_text.dart';

class ServiceCelluleController extends GetxController {
  final servicesCellules = <ServiceCelluleModel>[].obs;
  final filteredServicesCellules = <ServiceCelluleModel>[].obs;
  final isLoading = false.obs;

  void filterServicesCellules(String filter) {
    if (filter.isEmpty) {
      filteredServicesCellules.value = servicesCellules;
    } else {
      filteredServicesCellules.value = servicesCellules.where((service) {
        return service.libelle.toLowerCase().contains(filter.toLowerCase());
      }).toList();
    }
  }

  Future getAllServicesCellules() async {
    isLoading.value = true;
    final String apiUrl = "${BASE_URL}/postes/read-all-services-cellules";
    try {
      final response = await http.get(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'}
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<ServiceCelluleModel> servicesCellulesList = jsonData.map((data) => ServiceCelluleModel.fromJson(data)).toList();
        servicesCellules.value = servicesCellulesList;
        filteredServicesCellules.value = servicesCellulesList;
        isLoading.value = false;
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false;
    }
  }

  Future<bool> addServiceCellule({required ServiceCelluleModel serviceCelluleModel }) async {
    final String apiUrl = "${BASE_URL}/postes/create-service-cellule";

    String requestBodyJson = json.encode(serviceCelluleModel.toJson());

    try {
      final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: requestBodyJson
      );
      if (response.statusCode == 200) {
        await getAllServicesCellules();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> deleteServiceCellule({required String ID}) async {
    final String apiUrl = "${BASE_URL}/postes/delete-service-cellule/${ID}";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        await getAllServicesCellules();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateServiceCellule({required ServiceCelluleModel serviceCelluleModel }) async {
    final String apiUrl = "${BASE_URL}/postes/update-service-cellule/${serviceCelluleModel.id}";

    try {

      String requestBodyJson = json.encode(serviceCelluleModel.toJson());

      final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: requestBodyJson
      );
      if (response.statusCode == 200) {
        await getAllServicesCellules();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}

class ServiceCelluleWidget extends StatefulWidget {
  const ServiceCelluleWidget({super.key});

  @override
  State<ServiceCelluleWidget> createState() => _ServiceCelluleWidgetState();
}

class _ServiceCelluleWidgetState extends State<ServiceCelluleWidget> {

  final ServiceCelluleController serviceCelluleController = Get.put(ServiceCelluleController());

  void showAddServiceCelluleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Ajouter un service/cellule'),
          contentPadding: EdgeInsets.all(20),
          content: SingleChildScrollView(
              child: FormulaireServiceCellule(typeFormulaire: 'create',id: null,libelle: null,)
          ),
        );
      },
    );
  }

  void showUpdateServiceCelluleDialog(BuildContext context,ServiceCelluleModel serviceCellule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mise à jour - Service/Cellule : ${serviceCellule.id}'),
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
              child: FormulaireServiceCellule(typeFormulaire: 'update',id: serviceCellule.id,libelle: serviceCellule.libelle,type: serviceCellule.type,)
          ),
        );
      },
    );
  }

  @override
  void initState() {
    serviceCelluleController.getAllServicesCellules();
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
                      serviceCelluleController.filterServicesCellules(value);
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
                    serviceCelluleController.servicesCellules.value = [];
                  });
                  await serviceCelluleController.getAllServicesCellules();
                },
                    icon: Icon(Icons.refresh)
                ),
                SizedBox(width: 20,),
                OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: secondaryColor,foregroundColor: Colors.white),onPressed: (){
                  showAddServiceCelluleDialog(context);
                }, child:
                Container(height: 40,child: Center(child: CustomText(text: "Ajouter un service/cellule",fontSize: policeSousTitre,))))
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
                  serviceCelluleController.isLoading == true ? const CircularProgressIndicator() : IconButton(splashRadius: 20,onPressed: () async {
                    await serviceCelluleController.getAllServicesCellules();
                  }, icon: Icon(Icons.refresh))
                ],
              ),
              columns: const [
                DataColumn2(label: Text("#"),fixedWidth: 50),
                DataColumn2(label: Text("Code"),fixedWidth: 150),
                DataColumn2(label: Text("Service/Cellule"),fixedWidth: 150),
                DataColumn2(label: Text("Libéllé")),
                DataColumn2(label: Text("Actions"),fixedWidth: 120)
              ],
              rows: serviceCelluleController.filteredServicesCellules.map((serviceCellule) {
                return  DataRow2(cells: [
                  DataCell(Text("${serviceCelluleController.filteredServicesCellules.indexOf(serviceCellule)+1}")),
                  DataCell(Text("${serviceCellule.id}")),
                  DataCell(Container(
                      width: 100,
                      height:30,
                      decoration : BoxDecoration(
                          color: serviceCellule.type == "Service" ? Color(0xFFB5DBFB) : Color(0xFFA6EAB9) ,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("${serviceCellule.type}")))),
                  DataCell(Text("${serviceCellule.libelle}")),
                  DataCell(Row(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          showUpdateServiceCelluleDialog(context,serviceCellule);
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
                                content: Text("Êtes-vous sûr de vouloir supprimer service/cellule : ${serviceCellule.id} ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                    },
                                    child: Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      serviceCelluleController.deleteServiceCellule(ID: serviceCellule.id);
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

class FormulaireServiceCellule extends StatefulWidget {
  final String? id;
  final String? libelle;
  final String? type;
  final String typeFormulaire ;
  const FormulaireServiceCellule({super.key, required this.typeFormulaire, this.id, this.libelle, this.type});

  @override
  State<FormulaireServiceCellule> createState() => _FormulaireServiceCelluleState();
}

class _FormulaireServiceCelluleState extends State<FormulaireServiceCellule> {

  bool isSubmitting = false;
  String? id = null;
  String? libelle = null;
  String? selectedOption;
  final ServiceCelluleController serviceCelluleController = Get.find();

  final GlobalKey<FormState> _formAddKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      id = widget.id;
      libelle = widget.libelle;
      selectedOption = widget.type;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 350,
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
                labelText: 'Code service/cellule',
                hintText: 'Entrer le code du service/cellule',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                id = value;
              },
            ),
            SizedBox(height: 20,),
            CustomDropDownField(
              items: ['Service', 'Cellule'],
              selectedValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner une option.';
                }
                return null;
              },
              hint: 'Service/Cellule',
            ),
            SizedBox(height: 20,),
            TextFormField(
              initialValue: widget.libelle??"",
              enabled: !isSubmitting,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le libellé';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Libellé service/cellule',
                  hintText: 'Entrez le libellé du service/cellule',
                  border: OutlineInputBorder()
              ),
              onChanged: (value) {
                libelle = value;
              },
            ),
            SizedBox(height: 20,),
            Expanded(child: Container()),
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
                      final _serviceCellule = ServiceCelluleModel(id: id!,type: selectedOption!, libelle: libelle!);
                      if (widget.typeFormulaire == "create") {
                        final result = await serviceCelluleController.addServiceCellule(serviceCelluleModel: _serviceCellule);
                        if (result) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.green,content: Text('Service/Cellule enregistré avec succès')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.red,content: Text("Impossible d'enregistrer le service/cellule.")),
                          );
                        }
                      }
                      else if (widget.typeFormulaire == "update") {
                        final result = await serviceCelluleController.updateServiceCellule(serviceCelluleModel: _serviceCellule);
                        if (result) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.green,content: Text('Service/Cellule modifié avec succès')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.red,content: Text("Impossible de mettre à jour le service/cellule.")),
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


