import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/config/config.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/utils/utils.dart';
import 'package:vb_performance/widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class InscriptionPage extends StatefulWidget {
  final String? token;
  const InscriptionPage({super.key, this.token});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {

  bool _isLoaded = false;
  bool _submitting = false;
  bool _isHovering = false;
  bool _obscureText = true;
  bool _obscureCinfirmText = true;
  DateTime? dateEntreeVB;

  bool? _validForm;

  double spcacing = 5;

  Future<bool> checkCreateAccount(String email) async {
    final String url = 'http://127.0.0.1:4545/api/v1/auth/check-create-account';
    final Map<String, String> body = {
      'EMAIL': email,
    };

    try {

      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'}
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['userCanCreateAccount'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  Future<bool> updateCollaborateurAccount({
    required String token,
    required String collaborateurEmail,
    required String motPasse,
    required String nom,
    required String prenoms,
    required String matricule,
    required bool estBloque,
    required DateTime dateEntreeVB,
  }) async {


    final String url = 'http://127.0.0.1:4545/api/v1/collaborateurs/update-account';


    final Map<String, dynamic> requestBody = {
      "TOKEN": token,
      "MOTPASSE": motPasse,
      "NOM": nom,
      "EMAIL": collaborateurEmail,
      "PRENOMS": prenoms,
      "MATRICULE": matricule,
      "ESTBLOQUE": estBloque,
      "DATEENTREEVB": formatDate(dateEntreeVB)
    };

    print(requestBody);

    try {

      final response = await http.post(
          Uri.parse(url), body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'}
      );

      if (response.statusCode == 200) {
        // Si la requête a réussi
        return true;
      } else {
        // Si la requête a échoué
        return false;
      }
    } catch (e) {
      // En cas d'erreur lors de la requête
      return false;
    }
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _matriculeController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void verfication() async{

    final _token = widget.token;
    if ( _token != null  && _token.isNotEmpty ) {
      String _SECRETKEY = "VB_PERF_032024_@#";
      try {

        final jwt = JWT.verify(_token, SecretKey('${_SECRETKEY}'));

        final String _email = jwt.payload["email"];
        final _chekUser = await checkCreateAccount(_email);

        if (_chekUser) {
          setState(() {
            _emailController.text = _email;
            _dateController.text = _formatDate(dateEntreeVB);
            _isLoaded = true;
          });
        } else {
          context.go("/connexion");
        }

      } on JWTExpiredException {
        context.go("/connexion");
      } on JWTException catch (ex) {
        context.go("/connexion");
      } catch (e) {
        context.go("/connexion");
      }

    } else {
      context.go("/connexion");
    }
  }

  @override
  void initState() {
    verfication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SelectionArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(width,60),
          child: Material(
            color: Colors.white,
            textStyle: TextStyle(color: primaryColor),
            elevation: 1,
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/logos/logo-versus-bank -2.png"),
                  CustomText(text: "Inscription à VB-EVALUATION",fontSize: 30,color: primaryBoldColor,isBold: true,),
                  TextButton(
                      onPressed: (){
                        GoRouter.of(context).go('/connexion');
                      },
                      child: const CustomText(text: 'Se Connecter',fontSize: 25,),
                   )
                ],
              ),
            ),
          ),
        ),
        body: _isLoaded ? formulaireInscription() : Container(),
      ),
    );
  }


  Widget formulaireInscription() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/img_bg_inscription.png"),
              fit: BoxFit.cover
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Container(
              width: 700,
              height: 530,
              padding: EdgeInsets.only(top: 10,bottom: 10,left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Color(0xFF000000).withOpacity(0.25)
                    )
                  ]
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Formulaire d’inscription", fontSize: 30,isBold: true,),
                        SizedBox(height: spcacing,),
                        Text("Veuillez renseigner et soumettre le formulaire pour votre inscription à VERSUS EVALUATION (Application de fixation d’objectifs et d’évaluations du personnel) ",
                          style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontFamily: "Calibri"),),
                        SizedBox(height: 15,),
                        Container(
                          height: 80,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: "Email", fontSize: 20,isBold: true,),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFE5EBF0),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text("${_emailController.text}",style: TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.bold),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: "Matricule", fontSize: 20,isBold: true,),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _matriculeController,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          style: TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: primaryColor), // Couleur de la bordure lorsque le champ est sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey), // Couleur de la bordure lorsque le champ n'est pas sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: spcacing,),
                        Container(
                          height: 80,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const CustomText(text: "Nom", fontSize: 20,isBold: true,),
                                      const SizedBox(height: 10,),
                                      Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _nomController,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(bottom: 10,left: 10),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: primaryColor), // Couleur de la bordure lorsque le champ est sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey), // Couleur de la bordure lorsque le champ n'est pas sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: "Prénom(s)", fontSize: 20,isBold: true,),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _prenomController,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(bottom: 10,left: 10),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: primaryColor), // Couleur de la bordure lorsque le champ est sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey), // Couleur de la bordure lorsque le champ n'est pas sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: spcacing,),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: Row(
                              children: [
                                Expanded(child: CustomText(text: "Date d’entrée à VERSUS BANK", fontSize: 20,isBold: true,)),
                                SizedBox(width: 20,),
                                Expanded(child: Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: TextFormField(
                                        controller: _dateController,
                                        enabled: false,
                                        style: const TextStyle(
                                          fontSize: 16, // Modifie la taille de la police
                                          color: Colors.black, // Modifie la couleur du texte
                                          fontStyle: FontStyle.italic, // Ajoute un style italique
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez sélectionner une date';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        _selectDate(context);
                                      },
                                      onHover: (value){
                                        setState(() {
                                          _isHovering = value;
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: _isHovering ? Color(0xFFE5EBF0): Colors.transparent,
                                            shape: BoxShape.circle
                                        ),
                                        child: Icon(Icons.date_range_rounded),
                                      ),
                                    )
                                  ],
                                )),
                              ]
                          ),
                        ),
                        SizedBox(height: spcacing,),
                        Container(
                          height: 80,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: "Mot de passe ", fontSize: 20,isBold: true,),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: _obscureText,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(bottom: 10,left: 10),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: primaryColor), // Couleur de la bordure lorsque le champ est sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(_obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey), // Couleur de la bordure lorsque le champ n'est pas sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: "Confirmer votre mot de passe", fontSize: 20,isBold: true,),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 40,
                                        alignment: Alignment.centerLeft,
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _confirmPasswordController,
                                          obscureText: _obscureCinfirmText,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(bottom: 10,left: 10),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: primaryColor), // Couleur de la bordure lorsque le champ est sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureCinfirmText = !_obscureCinfirmText;
                                                });
                                              },
                                              child: Icon(_obscureCinfirmText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.grey), // Couleur de la bordure lorsque le champ n'est pas sélectionné
                                              borderRadius: BorderRadius.circular(10), // Rayon de la bordure
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        CustomText(text: "Le mot de passe doit avoir au moins 8 caractères, dont au moins 1 lettre majuscule et 1 chiffre.",fontSize: 12,isItalic: true,),
                        SizedBox(height: 5,),
                        if (_validForm == false ) CustomText(text: "Quelque chose s'est mal passé",fontSize: 14,isItalic: true,color: Colors.red,),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFFB0903D)
                            ),onPressed: _submitting ? null : (){
                              inscription();
                            }, child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CustomText(text: "Soumettre",fontSize: 20,),
                            )),
                            _submitting ? const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: CircularProgressIndicator(),
                            ) : Container()
                          ],
                        ),
                        SizedBox(height: spcacing,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2004),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dateEntreeVB = picked;
        _dateController.text = _formatDate(dateEntreeVB);
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "--/--/----";

    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String year = '${date.year}';

    return "$day/$month/$year";
  }

  void inscription() async{
    setState(() {
      _validForm = null;
      _submitting = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    bool kvalidForm = verifyForm();

    if ( kvalidForm == true ) {

      final String hashedPassword = BCrypt.hashpw("${_passwordController.text.trim()}", BCrypt.gensalt());

      print(hashedPassword);


      final result = await updateCollaborateurAccount(
          token: widget.token!,
          collaborateurEmail: _emailController.text,
          motPasse: hashedPassword,
          nom: _nomController.text,
          prenoms: _prenomController.text,
          matricule: _matriculeController.text,
          estBloque: false,
          dateEntreeVB: dateEntreeVB!
      );

      if (result) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.green,content: Text('Votre compte a été crée avec succès.')),
        );

        await Future.delayed(Duration(seconds: 1));

        context.go("/connexion");

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.red,content: Text('Echec')),
        );
      }

      setState(() {
        _submitting = false;
      });

    } else {
      setState(() {
        _validForm = kvalidForm;
        _submitting = false;
      });
    }

  }

  bool isPasswordValid(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    }

    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
    return regex.hasMatch(password);
  }

  bool verifyForm() {

    if (_emailController.text == null || _emailController.text.isEmpty || !GetUtils.isEmail(_emailController.text) ) {
      return false;
    }

   if (_matriculeController.text == null || _matriculeController.text.isEmpty) {
      return false;
    }

    if (_nomController.text == null || _nomController.text.isEmpty || _nomController.text.length < 3 ) {
      return false;
    }

    if (_prenomController.text == null || _prenomController.text.isEmpty || _prenomController.text.length < 3 ) {
      return false;
    }

    final _isValidPassword = isPasswordValid(_passwordController.text);
    if ( _isValidPassword == false ) {
      return false;
    }

    if (_confirmPasswordController.text != _passwordController.text) {
      return false;
    }

    if (_dateController.text == null || _dateController.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _emailController.dispose();
    _matriculeController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

}
