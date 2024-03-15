import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class ElementIdentification extends StatefulWidget {
  const ElementIdentification({super.key});

  @override
  State<ElementIdentification> createState() => _ElementIdentificationState();
}

class _ElementIdentificationState extends State<ElementIdentification> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Eléments d'identification",color: primaryBoldColor,isBold: true,fontSize: policeSousTitre,),
        SizedBox(height: 10,),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(text: "Nom et prénom (s)  : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "HOUESSOU HUEHANOU FABRICE",isBold: true,fontSize: policeNormal,)
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Matricule : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "394",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Libellé du poste ou de l'emploi  : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "Ingénieur Informatique",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Classification : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "CLASS III",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Supérieur hiérarchique direct (N+1) : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "Adams TOURE",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                    ],
                  )),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(text: "Profil  : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "Collaborateur",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Date d'entrée à Versus Bank : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "09/10/2024",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Date d'entrée dans le poste : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "09/10/2024",isBold: true,fontSize: 16)
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Direction-entité : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "DRS",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                      SizedBox(height: 3,),
                      Row(
                        children: [
                          CustomText(text: "Supérieur hiérarchique (N+2) : ",fontSize: policeNormal,),
                          const SizedBox(width: 10,),
                          CustomText(text: "Edi ESSO",isBold: true,fontSize: policeNormal)
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
