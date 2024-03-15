import 'package:flutter/material.dart';
import 'package:vb_performance/sections/menu_section.dart';

import '../../sections/header_section.dart';

class MainPage extends StatefulWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const HeaderSection(),
          Expanded(
            child: Row(
              children: [
                Container( width: 200, height: double.infinity,child: MenuSection()),
                Expanded(child: Container(color: Color(0xFFFAFAFA),child: widget.child,))
              ],
            ),
          )
        ],
      ),
    );
  }

}
