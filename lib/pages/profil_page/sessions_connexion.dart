import 'package:flutter/material.dart';
import 'package:vb_performance/constants/police.dart';

import '../../widgets/custom_text.dart';

class SessionsConnexion extends StatefulWidget {
  const SessionsConnexion({super.key});

  @override
  State<SessionsConnexion> createState() => _SessionsConnexionState();
}

class _SessionsConnexionState extends State<SessionsConnexion> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    CustomText(text: "Sessions de connexion",fontSize: policeSousTitre,isBold: true,),
                  ],
                ),
                const Divider(),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 50,
              child: CustomText(text: "Aucune donnée",fontSize: policeNormal,),
            )
          ],
        ),
      ),
    );
  }
}
