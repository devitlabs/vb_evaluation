import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/constants/police.dart';

import '../../../widgets/custom_text.dart';

class OngletExercice extends StatefulWidget {
  const OngletExercice({super.key});

  @override
  State<OngletExercice> createState() => _OngletExerciceState();
}

class _OngletExerciceState extends State<OngletExercice> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WorkFlowEvaluationCollaborateur(),
        const SizedBox(height: 10,),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: Row(
            children: [
              const OngletButton(
                tilte: "Objectifs",
                subRoute: "objectifs",
              ),
              const SizedBox(width: 20,),
              const OngletButton(
                tilte: "Evaluation à mi-parcours",
                subRoute: "evaluation-mi-parcours",
              ),
              const SizedBox(width: 20,),
              const OngletButton(
                tilte: "Evaluation finale",
                subRoute: "evaluation-finale",
              ),
              const SizedBox(width: 20,),
              const OngletButton(
                tilte: "Performances",
                subRoute: "performances",
              ),
              const SizedBox(width: 20,),
              Expanded(child: Container()),
              OutlinedButton(onPressed: (){},style: OutlinedButton.styleFrom(foregroundColor: Colors.green), child: Container(
                height: 35,
                child: const Row(
                  children: [
                    Icon(Icons.print,color: Colors.indigoAccent,),
                    SizedBox(width: 10,),
                    CustomText(text: "Imprimer")
                  ],
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }
}


class OngletButton extends StatefulWidget {
  final String tilte;
  final String subRoute;
  const OngletButton({super.key, required this.subRoute, required this.tilte});

  @override
  State<OngletButton> createState() => _OngletButtonState();
}

class _OngletButtonState extends State<OngletButton> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final listSubPath = location.split("/");
    final currentSubRoute = listSubPath.last;
    listSubPath.removeLast();
    return Column(
      children: [
        OutlinedButton(
            onPressed: (){
              final nextRoute = listSubPath.join("/") + "/${widget.subRoute}";
              context.go(nextRoute);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: currentSubRoute == widget.subRoute ? primaryColor : Colors.white ,
            ),
            child: SizedBox(height: 35,
              child: Center(child: CustomText(text: "${widget.tilte}",fontSize: policeSousTitre,color: currentSubRoute == widget.subRoute ? Colors.white : Colors.black,)),)
        ),
      ],
    );
  }
}


class WorkFlowEvaluationCollaborateur extends StatefulWidget {
  const WorkFlowEvaluationCollaborateur({super.key});

  @override
  State<WorkFlowEvaluationCollaborateur> createState() => _WorkFlowEvaluationCollaborateurState();
}

class _WorkFlowEvaluationCollaborateurState extends State<WorkFlowEvaluationCollaborateur> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: 990,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle
                  ),
                  child:  Center(
                    child: CustomText(text: "1",color: Colors.white,fontSize: policeMedium,),
                  ),
                ),
                Container(
                  height: 10,
                  width: 250,
                  color: Colors.grey,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle
                  ),
                  child:  Center(
                    child: CustomText(text: "2",color: Colors.white,fontSize: policeMedium,),
                  ),
                ),
                Container(
                  height: 10,
                  width: 250,
                  color: Colors.grey,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle
                  ),
                  child:  Center(
                    child: CustomText(text: "3",color: Colors.white,fontSize: policeMedium,),
                  ),
                ),
                Container(
                  height: 10,
                  width: 250,
                  color: Colors.grey,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle
                  ),
                  child:  Center(
                    child: CustomText(text: "4",color: Colors.white,fontSize: policeMedium,),
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: 990,
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 150,
                  alignment: Alignment.center,
                  child:  Center(child: CustomText(text: "Mise à jour du profil",fontSize: 14,)),
                ),
                Container(
                  height: 10,
                  width: 130,
                ),
                Container(
                  height: 35,
                  width: 150,
                  child:  Center(
                    child: CustomText(text: "Fixation d'objectifs",fontSize: 14,),
                  ),
                ),
                Container(
                  height: 10,
                  width: 130,
                ),
                Container(
                  height: 35,
                  width: 150,
                  child:  Center(
                    child: Column(
                      children: [
                        CustomText(text: "Evaluation à ",fontSize: 14,),
                        CustomText(text: "mi-parcours",fontSize: 14,),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 10,
                  width: 130,
                ),
                Container(
                  height: 35,
                  width: 150,
                  child:  Center(
                    child: CustomText(text: "Evaluation finale",fontSize: 14,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


