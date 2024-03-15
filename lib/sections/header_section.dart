import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../constants/colors.dart';
import '../widgets/custom_text.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  bool _isIconMenuHovering = false;
  bool _isIconMessageHovering = false;
  String _identifiant = "";
  String _avatarString = "";


  void initialisation() async{
    const storage = FlutterSecureStorage();
    String? kIdentifiant = await storage.read(key: "login");
    if (kIdentifiant != null) {
      setState(() {
        _identifiant = formatName(kIdentifiant);
        _avatarString = "${kIdentifiant[0].toUpperCase()}${kIdentifiant[1].toUpperCase()}";
      });
    }
  }

  String formatName(String name) {
    List<String> listLetter = name.split("");
    final firstLetter = listLetter[0].toUpperCase();
    final secondLetter = listLetter[1].toUpperCase();
    listLetter.removeAt(0);
    listLetter.removeAt(0);
    final autreLetter = listLetter.join("");

    return '${firstLetter}. ${secondLetter}${autreLetter}';

  }

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: secondaryColor)
      ),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          InkWell(
            onTap: (){
            },
            onHover: (value){
              setState(() {
                _isIconMenuHovering = value;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                  color: _isIconMenuHovering ? const Color(0xFFF0F0F0) : null,
                  shape: BoxShape.circle
                ),
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.menu,size: 35,),
                )),
          ),
          const SizedBox(width: 20,),
          Image.asset("assets/logos/logo-versus-bank -2.png",width: 110,fit: BoxFit.fitHeight,),
          const SizedBox(width: 40,),
          const CustomText(text: "VB-Evaluation",color: primaryBoldColor,isBold: true,fontSize: 25,),
          Expanded(child: Container()),
          CustomText(text: "${_identifiant}",fontSize: 18,),
          const SizedBox(width: 20,),
          InkWell(
            onTap: (){},
            onHover: (value){
              setState(() {
                _isIconMessageHovering = value;
              });
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: _isIconMessageHovering ? const Color(0xFFF0F0F0)  : Colors.transparent,
                shape: BoxShape.circle
              ),
              child: Stack(
                children: [
                  const Center(child: Icon(Icons.message,size: 25,)),
                  Positioned(left: 20,top: 7,child: Container(width: 15,height: 15,
                    decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),child: Center(child: CustomText(text: "1",color: Colors.white,fontSize: 10,),),))
                ],
              ),
            ),
          ),
          const SizedBox(width: 20,),
          InkWell(
            onTap: (){
              context.go("/espace/mon-profil");
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: secondaryColor,
                shape: BoxShape.circle
              ),
              child: Center(child: CustomText(text: "HF",color: primaryColor,fontSize: 16,isBold: true,)),
            ),
          ),
          const SizedBox(width: 20,),
        ]
      ),
    );
  }

}
