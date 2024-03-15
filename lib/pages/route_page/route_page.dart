import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {


  void redirection() async {
    await Future.delayed(const Duration(seconds: 2));
    context.go("/login");
  }

  @override
  void initState() {
    redirection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logos/logo-versus-bank.png",width: 300,fit: BoxFit.fitHeight,),
              const SizedBox(height: 10,),
              const SizedBox(width : 400 ,height: 5, child: LinearProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
