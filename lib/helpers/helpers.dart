import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';


Future<void> debugVisuel({required BuildContext context,required String variable,required dynamic content}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        title: Text("Variable : ${variable}",style: TextStyle(color: Colors.red,fontSize: 20),),
        content: SizedBox(
          width: 300,
          height: 170,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SelectionArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(text: "${content.toString()}",isItalic: true,fontSize: 18,)
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Fermer'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}