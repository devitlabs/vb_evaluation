import 'package:flutter/material.dart';
import 'package:vb_performance/constants/police.dart';

import '../../widgets/custom_text.dart';

class InfosHierarchie extends StatefulWidget {
  const InfosHierarchie({super.key});

  @override
  State<InfosHierarchie> createState() => _InfosHierarchieState();
}

class _InfosHierarchieState extends State<InfosHierarchie> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    CustomText(text: "Informations de la Hiérarchie",fontSize: policeSousTitre,isBold: true,),
                  ],
                ),
                Divider(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: CustomText(text: "Classification",fontSize: policeNormal,isBold: true,),
                          ),
                          SizedBox(width: 20,),
                          CustomText(text: "CLASS III",fontSize: policeNormal,)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: CustomText(text: "Supérieur hiérarchique direct (N+1)",fontSize: policeNormal,isBold: true,),
                          ),
                          SizedBox(width: 20,),
                          CustomText(text: "Adams TOURE",fontSize: policeNormal,)
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: CustomText(text: "Direction-entité",fontSize: policeNormal,isBold: true,),
                          ),
                          SizedBox(width: 20,),
                          CustomText(text: "DRS",fontSize: policeNormal,)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: CustomText(text: "Supérieur hiérarchique direct (N+2)",fontSize: policeNormal,isBold: true,),
                          ),
                          SizedBox(width: 20,),
                          CustomText(text: "Adams TOURE",fontSize: policeNormal,)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
