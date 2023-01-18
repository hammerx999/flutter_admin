import 'package:flutter/material.dart';

import '../constants.dart';

class PanelRightPage extends StatefulWidget {
  PanelRightPage({Key? key}) : super(key: key);

  @override
  State<PanelRightPage> createState() => _PanelRightPageState();
}

class _PanelRightPageState extends State<PanelRightPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Constants.kPadding / 2,
              right: Constants.kPadding / 2,
              top: Constants.kPadding / 2,
            ),
            child: Card(
              color: Constants.purpleLight,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                width: double.infinity,
                child: ListTile(
                  title: Text(
                    "Products Sold",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "18 =% of Products Sold",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Chip(
                    label: Text(
                      "4,500",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Constants.kPadding,
              left: Constants.kPadding / 2,
              right: Constants.kPadding / 2,
              top: Constants.kPadding,
            ),
            child: Card(
              color: Constants.purpleLight,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
