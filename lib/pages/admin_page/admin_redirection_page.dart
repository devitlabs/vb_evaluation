import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminRedirectionPage extends StatefulWidget {
  const AdminRedirectionPage({super.key});

  @override
  State<AdminRedirectionPage> createState() => _AdminRedirectionPageState();
}

class _AdminRedirectionPageState extends State<AdminRedirectionPage> {

  @override
  void initState() {
    redirection();
    super.initState();
  }

  void redirection() async{
    await Future.delayed(Duration(seconds: 1));
    context.go("/espace/administration/exercice-d-evaluation");
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
