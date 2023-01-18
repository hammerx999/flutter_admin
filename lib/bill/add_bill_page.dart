

import 'package:flutter/material.dart';
import 'package:flutter_admin/services/storage_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storgae;
import 'package:firebase_core/firebase_core.dart';
import '../constants.dart';
import '../services/add_bill_service.dart';
import '../services/show_notification.dart';


class AddBillPage extends StatefulWidget {
  AddBillPage({Key? key}) : super(key: key);

  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final pdname = 'sdfdfd';
  final pddes = 'ยังไม่ได้ชำระเงิน';
  final water = TextEditingController();
  final elec = TextEditingController();
  final rentr = TextEditingController();
  final rentf = TextEditingController();

  DateTime? _selected;
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
                left: Constants.kPadding / 2,
                right: Constants.kPadding / 2,
                top: Constants.kPadding / 2,
              ),
            child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(10)),
                  TextField(
                    controller: rentr,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'ค่าเช่าห้อง',
                        labelStyle:
                            TextStyle( fontSize: 12)),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: elec,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'ค่าไฟฟ้า',
                        labelStyle:
                            TextStyle( fontSize: 12)),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: rentf,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'ค่าเช่าเฟอร์นิเจอร์',
                        labelStyle:
                            TextStyle( fontSize: 12)),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: water,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'ค่าน้ำ',
                        labelStyle:
                            TextStyle( fontSize: 12)),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 
                  Padding(padding: const EdgeInsets.all(10)),
                  ElevatedButton(
                    child: Text("ยืนยัน"),
                    onPressed: () {
                      if ( 
                          pddes == "" ||
                          elec.text == "" ||
                          water.text == "" ||
                          rentr.text == "" ||
                          rentf.text == "") {
                        showMessageBox(context, "Error",
                            "Please enter name and description before adding it to firebase",
                            actions: [dismissButton(context)]);
                      
                      } else {
                        addBill(
                            context,
                            {
                              "title": 'บิลค่าเช่า ${pdname} ',
                              "trailing": pddes,
                              "elec": elec.text,
                              "water": water.text,
                              "rentr": rentr.text,
                              "rentf": rentf.text
                            },
                            pdname);

                        ;
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
