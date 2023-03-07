import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../services/logger_service.dart';
import 'show_notification.dart';

class SettingBillPage extends StatefulWidget {
  SettingBillPage({Key? key}) : super(key: key);

  @override
  State<SettingBillPage> createState() => _SettingBillPageState();
}

class _SettingBillPageState extends State<SettingBillPage> {

  final roomBill = TextEditingController();
  final roomBill2 = TextEditingController();
  final roomBill3 = TextEditingController();
  final elecBill = TextEditingController();
  final waterBill = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
             Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ค่าห้อง",
                      style: TextStyle(
                        color: Constants.orangeLight,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                            height: 40,
                            width: 100,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.orange,
                                  primaryColorDark: Colors.orangeAccent),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                controller: roomBill,
                                decoration: const InputDecoration(
                                  labelText: 'ค่าห้อง 1',
                                  labelStyle: TextStyle(
                                      fontFamily: 'fonts1',
                                      fontSize: 8,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            )),
                            Container(
                            height: 40,
                            width: 100,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.orange,
                                  primaryColorDark: Colors.orangeAccent),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                controller: roomBill2,
                                decoration: const InputDecoration(
                                  labelText: 'ค่าห้อง 2',
                                  labelStyle: TextStyle(
                                      fontFamily: 'fonts1',
                                      fontSize: 8,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            )),
                            Container(
                            height: 40,
                            width: 100,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.orange,
                                  primaryColorDark: Colors.orangeAccent),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                controller: roomBill3,
                                decoration: const InputDecoration(
                                  labelText: 'ค่าห้อง 3',
                                  labelStyle: TextStyle(
                                      fontFamily: 'fonts1',
                                      fontSize: 8,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            )),
                       
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "หน่วยค่าไฟ",
                      style: TextStyle(
                        color: Constants.orangeLight,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                            height: 40,
                            width: 100,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.orange,
                                  primaryColorDark: Colors.orangeAccent),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                controller: elecBill,
                                decoration: const InputDecoration(
                                  labelText: 'หน่วยละ',
                                  labelStyle: TextStyle(
                                      fontFamily: 'fonts1',
                                      fontSize: 8,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            )),
              
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ค่าน้ำ",
                      style: TextStyle(
                        color: Constants.orangeLight,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                            height: 40,
                            width: 100,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.orange,
                                  primaryColorDark: Colors.orangeAccent),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                controller: waterBill,
                                decoration: const InputDecoration(
                                  labelText: 'ค่าน้ำ',
                                  labelStyle: TextStyle(
                                      fontFamily: 'fonts1',
                                      fontSize: 8,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            )),
              
                      ],
                    ),
                  ],
                ),SizedBox(height: 20,),
              Row(
                children: [
                  Spacer(),
                   ElevatedButton(
                  child: Text("ยืนยัน"),
                  onPressed: () {
                    setState(() {
                     
                    });
                    if (roomBill == "" ||
                        roomBill2 == "" ||
                        roomBill3 == "" ||
                        elecBill.text == "" ||
                        waterBill == "" 
                     ) {
                      showMessageBox(context, "Error",
                          "Please enter name and description before adding it to firebase",
                          actions: [dismissButton(context)]);
                    } else {
                      Future<void> addBill(BuildContext context,
                          Map<String, dynamic> data, String documentName) {
                        return FirebaseFirestore.instance
                            .collection('setting_bill')
                            .doc(documentName)
                            .set(data)
                            .then((returnData) {
                    showMessageBox(context, "Success", "Added ($documentName) to Firestore",
        actions: [dismissButton(context)]);
                          logger.i("setData success");
                        }).catchError((e) {
                          logger.e(e);
                        });
                      }

                      addBill(
                          context,
                          {
                            "roomBill": roomBill.text,
                            "roomBill2": roomBill2.text,
                            "roomBill3": roomBill3.text,
                            "elecBill": elecBill.text,
                            "waterBill": waterBill.text,
                           
                          },
                       'setting_bill');
                    }

                    

                  },
                ),SizedBox(width: 10,)

                ],
              )
          ],
        ),
      ),
    );
  }
}