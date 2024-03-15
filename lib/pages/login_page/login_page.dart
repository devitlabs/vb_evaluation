import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/config/config.dart';
import '../../constants/colors.dart';
import '../../widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final storage = const FlutterSecureStorage();

  bool isStaffConnexion = true;
  bool _obscureText = true;
  bool _isLoging = false;

  Future<Map<String, dynamic>> login({required String email, required String motPasse}) async {
    final String apiUrl = "${BASE_URL}/auth/login";
    try {
      // Prepare the request body
      Map<String, dynamic> requestBody = {
        'email': email,
        'motPasse': motPasse,
      };
      // Encode the request body as JSON
      String requestBodyJson = json.encode(requestBody);

      // Send the POST request with the encoded request body
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        return {"status": true, "result": data};
      } else {
        return {"status": false, "result": "Échec du chargement des données depuis l'API"};
      }
    } catch (e) {
      return {"status": false, "result": "Impossible de se connecter au serveur"};
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController(text: "eros.houessou@versusbank.com");
    _passwordController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SelectionArea(
      child: Scaffold(
        body: Row(
          children: [
            if (width > 1000) Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/img_bg_login.png",
                            height: height,
                            fit: BoxFit.fitHeight,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: CustomText(
                                        text: "VB-EVALUATION",
                                        color: Colors.white,
                                        fontSize: 60)),
                                SizedBox(
                                  height: 20,
                                ),
                                Flexible(
                                    child: CustomText(
                                  text:
                                      "Application de fixation d'objectifs et d'évaluation du personnel",
                                  fontSize: 25,
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logos/logo-versus-bank.png",
                      width: 212,
                      height: 65,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: 430,
                        width: 400,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomText(
                                text: "VB-Evaluation",
                                fontSize: 25,
                                isBold: true,
                                color: primaryBoldColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        isStaffConnexion = true;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: isStaffConnexion
                                            ? secondaryColor
                                            : null),
                                    child: SizedBox(
                                      width: 110,
                                      height: 40,
                                      child: Center(
                                        child: CustomText(
                                          text: "VersusBankers",
                                          color: isStaffConnexion
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 2,
                                    color: grisColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          isStaffConnexion = false;
                                        });
                                      },
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              isStaffConnexion == false
                                                  ? secondaryColor
                                                  : null),
                                      child: SizedBox(
                                        width: 110,
                                        height: 40,
                                        child: Center(
                                          child: CustomText(
                                              text: "RH - Admin",
                                              color: isStaffConnexion == false
                                                  ? Colors.white
                                                  : null),
                                        ),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !GetUtils.isEmail(value)) {
                                      return "L'adresse email renseignée est incorrecte.";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: secondaryColor),
                                    ),
                                    hintText: "Entrez votre email",
                                    labelText: "Adresse email",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscureText,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 6) {
                                      return "Le mot de passe doit avoir  plus de 6 caractères.";
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {},
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: secondaryColor),
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
                                    hintText: 'Entrez votre mot de passe',
                                    labelText: 'Mot de passe',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _showResetPasswordDialog(context);
                                      },
                                      child: const CustomText(
                                          text: "Mot de passe oublié ? "),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: _isLoging
                                      ? null
                                      : () async {
                                          if ( _formKey.currentState!.validate() ) {

                                            setState(() {
                                              _isLoging = true;
                                            });

                                            final result = await login(
                                                email: _emailController.text,
                                                motPasse: _passwordController.text
                                            );


                                            if (result["status"]) {

                                              await storage.write(key: "token", value: result["result"]["token"]);

                                              await Future.delayed(const Duration(seconds: 1));

                                              context.go("/espace/accueil");

                                            } else {

                                              setState(() {
                                                _isLoging = false;
                                              });

                                              await Future.delayed(const Duration(milliseconds: 200));

                                              _showMessage(
                                                  context: context,
                                                  title: "Erreur",
                                                  message:  result["result"],
                                                  color: Colors.red
                                              );
                                            }
                                          }
                                        },
                                  child: SizedBox(
                                    width: 250,
                                    height: 40,
                                    child: Center(
                                      child: _isLoging
                                          ? const SizedBox(
                                              width: 25,
                                              height: 25,
                                              child:
                                                  CircularProgressIndicator())
                                          : const CustomText(
                                              text: "Connexion",
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                    ),
                                  ))
                            ],
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
    );
  }

  Future<void> _showResetPasswordDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contacter le help desk'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "Veuillez contacter l'unité le help desk pour réinitialiser "),
                Text('votre mot de passe.'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    SelectableText(
                      'technical_support@versusbank.com',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    SelectableText(
                      '6054',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
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

  Future<void> _showMessage({required BuildContext context,required String title, required dynamic message,required Color color}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: color, fontSize: 20),
          ),
          content: SizedBox(
            width: 300,
            height: 170,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: "${message}",
                      isItalic: true,
                      fontSize: 18,
                    )
                  ],
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

}
