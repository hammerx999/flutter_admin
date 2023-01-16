import 'package:flutter/material.dart';

class PanelRightPage extends StatefulWidget {
  PanelRightPage({Key? key}) : super(key: key);

  @override
  State<PanelRightPage> createState() => _PanelRightPageState();
}

class _PanelRightPageState extends State<PanelRightPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.red,
    ),);
  }
}