import 'package:flutter/material.dart';
import 'package:flutter_admin/constants.dart';
import 'package:flutter_admin/panel_left/circle_graph.dart';
import 'package:flutter_admin/panel_left/curved_chart.dart';
import 'package:flutter_admin/responsive_layout.dart';

class Todo {
  String name;
  bool enable;
  Todo({this.enable = true, required this.name});
}

class PanelLeftPage extends StatefulWidget {
  PanelLeftPage({Key? key}) : super(key: key);

  @override
  State<PanelLeftPage> createState() => _PanelLeftPageState();
}

class _PanelLeftPageState extends State<PanelLeftPage> {
  List<Todo> _toDo = [
    Todo(name: "Purchase Paper", enable: true),
    Todo(name: "Purchase Paper", enable: true),
    Todo(name: "Purchase Paper", enable: true),
    Todo(name: "Purchase Paper", enable: true),

    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        if (ResponsiveLayuot.isComputer(context))
          Container(
            color: Constants.purpleDark,
            width: 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Constants.purpleDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  )),
            ),
          ),
        SingleChildScrollView(
          child: Column(
            children: [
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
                          "ห้องทั้งหมด",
                          style: TextStyle(color: Colors.white),
                        ),
                        
                        trailing: Chip(
                          label: Text(
                            "50",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ),
              LineChartSample2(),
              // PieChartSample2(),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: Constants.kPadding / 2,
              //     right: Constants.kPadding / 2,
              //     top: Constants.kPadding / 2,
              //     bottom: Constants.kPadding,
              //   ),
              //   child: Card(
              //     color: Constants.purpleLight,
              //     elevation: 3,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Column(
              //       children: List.generate(
              //           _toDo.length,
              //           (index) => CheckboxListTile(
              //             title: Text(_toDo[index].name, style: TextStyle(color: Colors.white),),
              //               value: _toDo[index].enable,
              //               onChanged: (newValue) {
              //                 setState(() {
              //                   _toDo[index].enable = newValue ?? true;
              //                 });
              //               })),
              //     ),
              //   ),
              // ),
            ],
          ),
        )
      ]),
    );
  }
}
