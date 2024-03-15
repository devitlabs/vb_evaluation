import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RedirectionInscriptionPage extends StatefulWidget {
  final String? token;
  const RedirectionInscriptionPage({super.key, this.token});

  @override
  State<RedirectionInscriptionPage> createState() => _RedirectionInscriptionPageState();
}

class _RedirectionInscriptionPageState extends State<RedirectionInscriptionPage> {

  void verfication() async{
    await Future.delayed(const Duration(seconds: 1));
    final _token = widget.token;
    if ( _token != null  && _token.isNotEmpty ) {
      context.go("/inscription",extra: _token);
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
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(color: Color(0xFFB0903D),),
          ),
        ],
      ),
    );
  }
}
