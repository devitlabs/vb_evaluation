import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final bool? isBold;
  final bool? isItalic;
  final bool? isSelectable;
  const CustomText({super.key, required this.text, this.color, this.fontSize, this.isBold, this.isItalic, this.isSelectable});

  @override
  Widget build(BuildContext context) {
    return isSelectable == true  ?  SelectableText(
      text,style: TextStyle(fontSize: fontSize??16,color: color,fontWeight: isBold ==true?FontWeight.bold:null,
    fontStyle: isItalic == true ? FontStyle.italic : null),
    ) : Text(
      text,style: TextStyle(fontSize: fontSize??16,color: color,fontWeight: isBold ==true?FontWeight.bold:null,
        fontStyle: isItalic == true ? FontStyle.italic : null,fontFamily: "Calibri"),
    ) ;
  }
}
