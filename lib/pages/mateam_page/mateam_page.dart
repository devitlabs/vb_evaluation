import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/police.dart';
import '../../widgets/custom_text.dart';

class MaTeamPage extends StatefulWidget {
  final Widget child;
  const MaTeamPage({super.key, required this.child});

  @override
  State<MaTeamPage> createState() => _MaTeamPageState();
}

class _MaTeamPageState extends State<MaTeamPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.groups,size: policeGrandTitre,color: primaryBoldColor,),
              const SizedBox(width: 10,),
              CustomText(text: "Ma Team",fontSize: policeGrandTitre,isBold: true,color: primaryBoldColor,),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: widget.child)
        ],
      ),
    );
  }
}
