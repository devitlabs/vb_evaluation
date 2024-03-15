import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class EvaluationMiParcours extends StatefulWidget {
  const EvaluationMiParcours({super.key});

  @override
  State<EvaluationMiParcours> createState() => _EvaluationMiParcoursState();
}

class _EvaluationMiParcoursState extends State<EvaluationMiParcours> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElementsIdentification(),
            SizedBox(height: 10,),
            ResumeObjectifs(),
            SizedBox(height: 10,),
            EvaluationGlobaleProgres(),
            SizedBox(height: 10,),
            BesoinsEnDevelopement(),
            SizedBox(height: 10,),
            ObservationsGenerales(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class ElementsIdentification extends StatefulWidget {
  const ElementsIdentification({super.key});

  @override
  State<ElementsIdentification> createState() => _ElementsIdentificationState();
}

class _ElementsIdentificationState extends State<ElementsIdentification> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: Color(0xFF808080),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(text: "ELEMENTS D'IDENTIFICATION",fontSize: 18,color: Colors.white,isBold: true,),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText(text: "Nom du Collaborateur :",fontSize: 16,),
                    SizedBox(width: 5,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      width: 500,
                      child: CustomText(text: "HOUESSOU HUEHANOU FABRICE",fontSize: 18,isBold: true,),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(text: "Poste :",fontSize: 16),
                              SizedBox(width: 10,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: CustomText(text: "Ingénieur Informatique",fontSize: 18,isBold: true,),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              CustomText(text: "Direction :",fontSize: 16,),
                              SizedBox(width: 10,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: CustomText(text: "DRS",fontSize: 18,isBold: true,),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            children: [
                              CustomText(text: "Date de l'entretien :",fontSize: 16),
                              SizedBox(width: 10,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: CustomText(text: "22/02/2024",fontSize: 18,isBold: true,),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              CustomText(text: "Période évaluée :",fontSize: 16,),
                              SizedBox(width: 10,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: CustomText(text: "01/03/2024",fontSize: 18,isBold: true,),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ResumeObjectifs extends StatefulWidget {
  const ResumeObjectifs({super.key});

  @override
  State<ResumeObjectifs> createState() => _ResumeObjectifsState();
}

class _ResumeObjectifsState extends State<ResumeObjectifs> {

  final List<Map<String,dynamic>> objectifs = [
    {
      "#":"1",
      "description":"Realiser au 31 decembre 2024 100% des projets  assignés",
      "elements-de-mesure":"Taux de réalisation  d'un projet achevé =100%, taux de de projet achevé >90%, % de projets documentés, membre equipe projet, auteur des livrables"
    },
    {
      "#":"2",
      "description":"Renforcer l'automatisation au 31 decembre 2024 des processus metiers manuels",
      "elements-de-mesure":"nombre d'automatisations nouvelles>4"
    },
    {
      "#":"3",
      "description":"Renforcer l'automatisation au 31 decembre 2024 des processus metiers manuels",
      "elements-de-mesure":"nombre d'automatisations nouvelles>4"
    },
    {
      "#":"4",
      "description":"Realiser au 31 decembre 2024 100% des projets  assignés",
      "elements-de-mesure":"Taux de réalisation  d'un projet achevé =100%, taux de de projet achevé >90%, % de projets documentés, membre equipe projet, auteur des livrables"
    },

  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: Color(0xFF808080),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(text: "RESUME DES OBJECTIFS",fontSize: 18,color: Colors.white,isBold: true,),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: objectifs.map((objectif){
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "${objectif["#"]} - ",fontSize: 16,),
                      Expanded(flex: 4,child: CustomText(text: "${objectif["description"]}",fontSize: 16,isBold: true,)),
                      SizedBox(width: 5,),
                      Expanded(flex: 6,child: CustomText(text: "${objectif["elements-de-mesure"]}",fontSize: 16,))
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}


class EvaluationGlobaleProgres extends StatefulWidget {
  const EvaluationGlobaleProgres({super.key});

  @override
  State<EvaluationGlobaleProgres> createState() => _EvaluationGlobaleProgresState();
}

class _EvaluationGlobaleProgresState extends State<EvaluationGlobaleProgres> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          width: double.infinity,
          color: Color(0xFF808080),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CustomText(text: "EVALUATION GLOBALE DES PROGRES",fontSize: 18,color: Colors.white,isBold: true,),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
            border: Border.all(color: Colors.black)
          ),
          child: Row(
            children: [
              const SizedBox(
                height: double.infinity,
                width: 50,
                child: Center(child: Icon(Icons.check_box,color: Colors.green,size: 30,)),
              ),
              const SizedBox(width: 10,),
              Container(
                height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              Container(width: 250,child: CustomText(text: "Bon, répond aux attentes",fontSize: 16,isBold: true,)),
              SizedBox(width: 10,),
              Container(
                height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              CustomText(text: "La mesure de ses performances révèle des réalisations cohérentes à l’égard de l’atteinte des objectifs fixés ",
              fontSize: 16,isItalic: true,)
            ],
          ),
        ),
        SizedBox(height: 1,),
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border.all(color: Colors.black)
          ),
          child: Row(
            children: [
              const SizedBox(
                height: double.infinity,
                width: 50,
                child: Center(child: Icon(Icons.check_box_outline_blank,color: Colors.black,size: 30,)),
              ),
              const SizedBox(width: 10,),
              Container(
                height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              Container(width: 250,child: CustomText(text: "Acceptable, mais doit mieux faire",fontSize: 16,isBold: true,)),
              SizedBox(width: 10,),
              Container(
                height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              Flexible(
                child: CustomText(text: "La mesure des performances révèle quelques réalisations incohérentes à l’égard des exigences de l’emploi et des objectifs fixés ; une amélioration de la performance est requise",
                  fontSize: 16,isItalic: true,),
              )
            ],
          ),
        ),
        SizedBox(height: 1,),
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black)
          ),
          child: Row(
            children: [
              const SizedBox(
                height: double.infinity,
                width: 50,
                child: Center(child: Icon(Icons.check_box_outline_blank,color: Colors.black,size: 30,)),
              ),
              const SizedBox(width: 10,),
              Container(
                height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              Container(width: 250,child: CustomText(text: "Ne répond pas aux attentes",fontSize: 16,isBold: true,)),
              SizedBox(width: 10,),
              Container(
                height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              Flexible(
                child: CustomText(text: "La mesure des performances révèle des lacunes qui entravent sérieusement l’atteinte des exigences du poste et des objectifs fixés",
                  fontSize: 16,isItalic: true,),
              )
            ],
          ),
        ),
      ],
    );
  }
}


class BesoinsEnDevelopement extends StatefulWidget {
  const BesoinsEnDevelopement({super.key});

  @override
  State<BesoinsEnDevelopement> createState() => _BesoinsEnDevelopementState();
}

class _BesoinsEnDevelopementState extends State<BesoinsEnDevelopement> {
  @override
  Widget build(BuildContext context) {
    String besoins = """
      1- Créer une application web sécurisée pour gérer efficacement les données clients et optimiser les processus de gestion des commandes.
      2- Développer un système de suivi en temps réel pour surveiller les performances des serveurs et détecter les anomalies rapidement.
      3- Concevoir une interface utilisateur intuitive et responsive pour une expérience utilisateur fluide sur divers appareils et plateformes.
      3- Intégrer des fonctionnalités d'intelligence artificielle pour analyser les données et fournir des insights précieux pour la prise de décision.
      4- Assurer la scalabilité et la robustesse du système pour accompagner la croissance de l'entreprise et garantir une disponibilité continue des services.
    """;

    return Card(
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: const Color(0xFF808080),
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: CustomText(text: "Besoins de développement : ",fontSize: 18,color: Colors.white,),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: besoins,
              fontSize: 16,isItalic: true,
            ),
          ),
        ],
      ),
    );
  }
}


class ObservationsGenerales extends StatefulWidget {
  const ObservationsGenerales({super.key});

  @override
  State<ObservationsGenerales> createState() => _ObservationsGeneralesState();
}

class _ObservationsGeneralesState extends State<ObservationsGenerales> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: const Color(0xFF808080),
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: CustomText(text: "Observations Générales : ",fontSize: 18,color: Colors.white,),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: CustomText(
              text: "RAS",
              fontSize: 16,isItalic: true,
            ),
          ),
        ],
      ),
    );
  }
}



