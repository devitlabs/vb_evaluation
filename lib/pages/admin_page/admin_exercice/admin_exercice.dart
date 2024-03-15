import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

import '../../../config/config.dart';
import '../../../constants/colors.dart';
import '../../../models/exercice_model.dart';
import 'package:http/http.dart' as http;


class ExerciceController extends GetxController {
  final exercices = <ExerciceModel>[].obs;
  final isLoading = false.obs;

  Future<void> getAllExercices() async {
    isLoading.value = true;
    final String apiUrl = "${BASE_URL}/exercices/read-all";
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<ExerciceModel> exerciceList =
        jsonData.map((data) => ExerciceModel.fromJson(data)).toList();
        exercices.value = exerciceList;
      }
    } catch (e) {
      print('Error fetching exercises: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createExercice({required ExerciceModel exerciceModel}) async {
    final String apiUrl = "${BASE_URL}/exercices/create";
    final requestBodyJson = json.encode(exerciceModel.toJson());

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: requestBodyJson,
      );
      if (response.statusCode == 200) {
        await getAllExercices();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> deleteExercice({required String annee}) async {
    final String apiUrl = "${BASE_URL}/exercices/delete/$annee";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        await getAllExercices();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateExercice({required ExerciceModel exerciceModel}) async {
    final String apiUrl = "${BASE_URL}/exercices/update/${exerciceModel.ANNEE}";
    final requestBodyJson = json.encode(exerciceModel.toJson());

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: requestBodyJson,
      );
      if (response.statusCode == 200) {
        await getAllExercices();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}

class AdminExercice extends StatefulWidget {
  const AdminExercice({super.key});

  @override
  State<AdminExercice> createState() => _AdminExerciceState();
}

class _AdminExerciceState extends State<AdminExercice> {

  final ExerciceController exerciceController = Get.put(ExerciceController());

  @override
  void initState() {
    exerciceController.getAllExercices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(text: "Nombre total : ${exerciceController.exercices.length}",fontSize: policeSousTitre,isBold: true,),
            Expanded(child: Container()),
            SizedBox(width: 10,),
            IconButton(focusColor: Colors.amber,onPressed: (){
              exerciceController.getAllExercices();
            }, icon: Icon(Icons.refresh)),
            SizedBox(width: 10,),
            OutlinedButton(onPressed: (){}, style: OutlinedButton.styleFrom(backgroundColor: secondaryColor,foregroundColor: Colors.white),child: Padding(
              padding:  EdgeInsets.all(4.0),
              child: CustomText(text: "Ajouter un nouvel exercice",fontSize: policeMedium,),
            ))
          ],
        ),
        SizedBox(height: 10,),
        exerciceController.isLoading.value ? const Expanded(
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          ),
        ) :
        Expanded(child: exerciceController.exercices.length == 0 ? Center(child: CustomText(text: "Aucune donnée" ,fontSize: 20,))  : SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: exerciceController.exercices.map(
                    (exercice) =>  ExerciceWidget(exercice: exercice,),
              ).toList(),
            ),
          ),
        ))
      ],
    ));
  }
}


class ExerciceWidget extends StatefulWidget {
  final ExerciceModel exercice;
  const ExerciceWidget({super.key, required this.exercice});

  @override
  State<ExerciceWidget> createState() => _ExerciceWidgetState();
}

class _ExerciceWidgetState extends State<ExerciceWidget> {

  final ExerciceController exerciceController = Get.find();


  void showUpdateExerciceDialog(BuildContext context, ExerciceModel exercice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mise à jour - Exercice : ${exercice.ANNEE}'),
          contentPadding: const EdgeInsets.all(20),
          content: UpdateExerciceForm(exercice: exercice,),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pObjectifs = widget.exercice.PFIXOBJECTIFS.split("-");
    final pMiParcours = widget.exercice.PEVALMPARCOURS.split("-");
    final pEvalFinale = widget.exercice.PEVALFINALE.split("-");
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset("assets/icons/evaluation.png",height: 30,width: 30,),
                  SizedBox(width: 10,),
                  CustomText(text: "Exercice d'évaluation ${widget.exercice.ANNEE}",fontSize: policeSousTitre,isBold: true,),
                  Expanded(child: Container()),
                  CustomText(text: "${widget.exercice.DATEDEBUT} - ${widget.exercice.DATEFIN}",fontSize: policeMedium,isItalic: true,color: primaryColor,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  CustomText(text: "Etat : ",fontSize: policeMedium,),
                  CustomText(text: "${widget.exercice.ETAT}",fontSize: policeMedium,color: Colors.green,isBold: true,),
                  SizedBox(width: 20,),
                  CustomText(text: "Phase : ",fontSize: policeMedium,),
                  CustomText(text: "${widget.exercice.PHASE}",fontSize: policeMedium,color: primaryBoldColor,isBold: true,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  CustomText(text: "Période de fixation d’objectifs : ",fontSize: policeMedium,),
                  CustomText(text: "${pObjectifs.first} au ${pObjectifs.last}",fontSize: policeMedium,isItalic: true,),
                  SizedBox(width: 20,),
                  CustomText(text: "Période d’évaluation à mi-parcours : ",fontSize: policeMedium,),
                  CustomText(text: "${pMiParcours.first} au ${pMiParcours.last}",fontSize: policeMedium,isItalic: true,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  CustomText(text: "Période d'évaluation finale : ",fontSize: policeMedium,),
                  CustomText(text: "${pEvalFinale.first} au ${pEvalFinale.last}",fontSize: policeMedium,isItalic: true,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  CustomText(text: "Nombre total de collaborateurs : 100 ",fontSize: policeMedium,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  CustomText(text: "Nombre de collaborateurs ayant un objectifs fixés : 100 / 150 ",fontSize: policeMedium,),
                  SizedBox(width: 20,),
                  CustomText(text: "Nombre de collaborateurs ayant un objectifs fixés : 100 / 150 ",fontSize: policeMedium,),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                child: Row(
                  children: [
                    OutlinedButton(onPressed: (){
                      showUpdateExerciceDialog(context,widget.exercice);
                    },style: OutlinedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white
                    ) , child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomText(text: "Modifier",fontSize: policeMedium,),
                    ),),
                    SizedBox(width: 20,),
                    OutlinedButton(onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            title: Text("Confirmation"),
                            content: Text("Êtes-vous sûr de vouloir supprimer l'exercice ${widget.exercice.ANNEE} ? "),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                },
                                child: Text("Annuler"),
                              ),
                              TextButton(
                                onPressed: () {
                                  exerciceController.deleteExercice(annee: '${widget.exercice.ID}');
                                  Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                },
                                child: CustomText(text: "Confirmer",color: Colors.red,),
                              ),
                            ],
                          );
                        },
                      );
                    },style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white
                    ) , child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomText(text: "Supprimer",fontSize: policeMedium,),
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class UpdateExerciceForm extends StatefulWidget {
  final ExerciceModel exercice;

  const UpdateExerciceForm({Key? key, required this.exercice}) : super(key: key);

  @override
  _UpdateExerciceFormState createState() => _UpdateExerciceFormState();
}

class _UpdateExerciceFormState extends State<UpdateExerciceForm> {
  final ExerciceController exerciceController = Get.find();

  late TextEditingController etatController;
  late TextEditingController phaseController;
  late TextEditingController dateDebutController;
  late TextEditingController dateFinController;
  late TextEditingController pFixObjectifsController;
  late TextEditingController pEvalMParcoursController;
  late TextEditingController pEvalFinaleController;

  @override
  void initState() {
    super.initState();
    etatController = TextEditingController(text: widget.exercice.ETAT);
    phaseController = TextEditingController(text: widget.exercice.PHASE);
    dateDebutController = TextEditingController(text: widget.exercice.DATEDEBUT);
    dateFinController = TextEditingController(text: widget.exercice.DATEFIN);
    pFixObjectifsController = TextEditingController(text: widget.exercice.PFIXOBJECTIFS);
    pEvalMParcoursController = TextEditingController(text: widget.exercice.PEVALMPARCOURS);
    pEvalFinaleController = TextEditingController(text: widget.exercice.PEVALFINALE);
  }

  @override
  void dispose() {
    etatController.dispose();
    phaseController.dispose();
    dateDebutController.dispose();
    dateFinController.dispose();
    pFixObjectifsController.dispose();
    pEvalMParcoursController.dispose();
    pEvalFinaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 600,
        height: 400,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: etatController,
                decoration: InputDecoration(labelText: 'État'),
              ),
              TextFormField(
                controller: phaseController,
                decoration: InputDecoration(labelText: 'Phase'),
              ),
              TextFormField(
                controller: dateDebutController,
                decoration: InputDecoration(labelText: 'Date de début'),
              ),
              TextFormField(
                controller: dateFinController,
                decoration: InputDecoration(labelText: 'Date de fin'),
              ),
              TextFormField(
                controller: pFixObjectifsController,
                decoration: InputDecoration(labelText: 'Période de fixation d\'objectifs'),
              ),
              TextFormField(
                controller: pEvalMParcoursController,
                decoration: InputDecoration(labelText: 'Période d\'évaluation à mi-parcours'),
              ),
              TextFormField(
                controller: pEvalFinaleController,
                decoration: InputDecoration(labelText: 'Période d\'évaluation finale'),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fermer la boîte de dialogue
                    },
                    child: CustomText(text: 'Annuler'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      ExerciceModel updatedExercice = ExerciceModel(
                        ID: widget.exercice.ID,
                        ANNEE: widget.exercice.ANNEE,
                        ETAT: etatController.text,
                        PHASE: phaseController.text,
                        DATEDEBUT: dateDebutController.text,
                        DATEFIN: dateFinController.text,
                        PFIXOBJECTIFS: pFixObjectifsController.text,
                        PEVALMPARCOURS: pEvalMParcoursController.text,
                        PEVALFINALE: pEvalFinaleController.text,
                      );
                      exerciceController.updateExercice(exerciceModel: updatedExercice);
                      Navigator.pop(context); // Fermer le formulaire de mise à jour
                    },
                    child: Text('Enregistrer'),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
