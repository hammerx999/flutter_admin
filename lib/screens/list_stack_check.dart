import 'package:flutter/material.dart';
import 'package:flutter_admin/bill/check_page.dart';
import 'package:flutter_admin/bill/list_room_page.dart';
import 'package:flutter_admin/bill/list_room_page2.dart';
import 'package:flutter_admin/constants.dart';

import '../bill/list_room_page3.dart';

List<String> list = <String>[
  'พุทธชาต',
  'กาสะลอง',
];

class ListStack2 extends StatefulWidget {
  ListStack2({Key? key}) : super(key: key);

  @override
  State<ListStack2> createState() => _ListStack2State();
}

class _ListStack2State extends State<ListStack2> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Constants.orangeDark),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                print(dropdownValue);
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
        Row(children: [
          SizedBox(width: 50,),
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: 300,
              child: dropdownValue == 'พุทธชาต' ?
              CheckPage() : ListRoomPage2()  )
        ],)
        ],
      ),
    );
  }
}
