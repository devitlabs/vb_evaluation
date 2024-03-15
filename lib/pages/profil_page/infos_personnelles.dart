import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';

import '../../widgets/custom_text.dart';

class InfosPersonnelles extends StatefulWidget {
  const InfosPersonnelles({super.key});

  @override
  State<InfosPersonnelles> createState() => _InfosPersonnellesState();
}

class _InfosPersonnellesState extends State<InfosPersonnelles> {

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CustomText(text: "Informations Personnelles",fontSize: policeSousTitre,isBold: true,),
                      Expanded(child: Container()),
                      isEditing == false ? OutlinedButton(onPressed: (){
                        setState(() {
                          isEditing = true;
                        });
                      }, child:  Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            CustomText(text: "Modifiier",color: Colors.black,fontSize: policeNormal),
                            const SizedBox(width: 10,),
                            const Icon(Icons.edit,size: 15,color: Colors.black,)
                          ],
                        ),
                      )) : Row(
                        children: [
                          OutlinedButton(onPressed: (){
                            setState(() {
                              isEditing = false;
                            });
                          }, child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                CustomText(text: "Annuler",color: Colors.black,),
                              ],
                            ),
                          )),
                          const SizedBox(width: 10,),
                          OutlinedButton(onPressed: (){
                            setState(() {
                              isEditing = false;
                            });
                          },style: OutlinedButton.styleFrom(
                            backgroundColor: primaryColor
                          ), child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                CustomText(text: "Valider",color: Colors.white,),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                ],
              ),
              isEditing ? FormulaireInfoPersonnelles() : WidgetInfosPersonnelles(),
            ],
          ),
        ),
      ),
    );
  }

}


class WidgetInfosPersonnelles extends StatefulWidget {
  const WidgetInfosPersonnelles({super.key});

  @override
  State<WidgetInfosPersonnelles> createState() => _WidgetInfosPersonnellesState();
}

class _WidgetInfosPersonnellesState extends State<WidgetInfosPersonnelles> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Email",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      _buildText(value: "fabrice.houessou@versusbank.com")
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Nom",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      _buildText(value:  "HOUESSOU")
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Prénom",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      _buildText(value:  "HUEHANOU FABRICE")
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Mote de passe",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      _buildText(value: "*********")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Matricule",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    _buildText(value: "394")
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Libellé du poste",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    _buildText(value: "Ingénieur Développeur d'Applicatifs")
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Date d'entrée à Versus Bank",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    const CustomText(text: "01/10/2023",fontSize: 18,)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Date d'entrée dans le poste",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    const CustomText(text: "01/10/2023",fontSize: 18,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildText({required String value}) {
    return CustomText(text: value,fontSize: policeNormal);
  }

}


class FormulaireInfoPersonnelles extends StatefulWidget {
  const FormulaireInfoPersonnelles({super.key});

  @override
  State<FormulaireInfoPersonnelles> createState() => _FormulaireInfoPersonnellesState();
}

class _FormulaireInfoPersonnellesState extends State<FormulaireInfoPersonnelles> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Email",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        width: 300,
                        height: 35,
                        child: TextFormField(
                          initialValue: "fabrice.houessou@versusbank.com",
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: secondaryColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Nom",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        width: 300,
                        height: 35,
                        child: TextFormField(
                          initialValue: "HOUESSOU",
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: secondaryColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Prénom",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        width: 300,
                        height: 35,
                        child: TextFormField(
                          initialValue: "HUEHANOU FABRICE",
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: secondaryColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomText(text: "Mote de passe",fontSize: policeNormal,isBold: true,),
                      ),
                      const SizedBox(width: 20,),
                      OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white),onPressed: (){}, child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomText(text: "Modifier votre mot de passe"),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Matricule",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      width: 100,
                      height: 35,
                      child: TextFormField(
                        initialValue: "394",
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: secondaryColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Libellé du poste",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      width: 300,
                      height: 35,
                      child: TextFormField(
                        initialValue: "Ingénieur Développeur d'Applicatifs",
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: secondaryColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Date d'entrée à Versus Bank",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    Row(
                      children: [
                        const CustomText(text: "01/10/2023",fontSize: 18,),
                        const SizedBox(width: 10,),
                        IconButton(onPressed: (){},splashRadius: 20, icon: Icon(Icons.date_range_outlined))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomText(text: "Date d'entrée dans le poste",fontSize: policeNormal,isBold: true,),
                    ),
                    const SizedBox(width: 20,),
                    Row(
                      children: [
                        const CustomText(text: "01/10/2023",fontSize: 18,),
                        const SizedBox(width: 10,),
                        IconButton(onPressed: (){},splashRadius: 20, icon: Icon(Icons.date_range_outlined))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildText({required String value}) {
    return CustomText(text: value,fontSize: policeNormal);
  }
}

