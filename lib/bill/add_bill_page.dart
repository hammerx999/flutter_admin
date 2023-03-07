import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/services/storage_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storgae;
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../constants.dart';
import '../services/add_bill_service.dart';
import '../services/logger_service.dart';
import 'show_notification.dart';
import 'package:logger/logger.dart';

List<String> listmonth = <String>[
  
  'มีนาคม',
  'เมษายน ',
  'พฤษภาคม',
  'มิถุนายน',
  'กรกฎาคม',
  'สิงหาคม',
  'กันยายน',
  'ตุลาคม',
  'พฤศจิกายน',
  'ธันวาคม'
];

class AddBillPage extends StatefulWidget {
  AddBillPage({Key? key}) : super(key: key);

  @override
  _AddBillPageState createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final pdname = 'sdfdfd';
  final pddes = 'ยังไม่ได้ชำระเงิน';
  var water;
  var elec;
  var rentr;

  var month;
  final elecUnit = TextEditingController();
  var monthEng = 'มกราคม'.compareTo('January');
  int selectedIndex = 1;
  DateTime? _selected;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _setbill =
        FirebaseFirestore.instance.collection('setting_bill').snapshots();
    String dropdownValuemonth = listmonth.first;

    String? selectedValue;

    return Scaffold(
      body: StreamBuilder(
        stream: _setbill,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshoot) {
          if (streamSnapshoot.hasError) {
            return Text('Something went wrong');
          }

          if (streamSnapshoot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return ListView(
              children:
                  streamSnapshoot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                List<String> list = <String>[
                  '${data['roomBill']}',
                  '${data['roomBill2']}',
                  '${data['roomBill3']}',
                ];
                List<String> listwater = <String>['${data['waterBill']}'];
                List<String> listelec = <String>['7', '8', '9', '10', '11'];
                String dropdownValueWater = listwater.first;
                String dropdownValueElec = listelec.first;
                String dropdownValue = list.first;
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Text(Get.arguments['name'].toString(),
                              style: TextStyle(
                                  color: Constants.orangeLight, fontSize: 16)),
                          Padding(padding: const EdgeInsets.all(2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "เดือน",
                                style: TextStyle(color: Constants.orangeLight),
                              ),
                              Spacer(),
                              Container(
                                width: 100,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select Item',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellow,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: listmonth
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownValuemonth,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        selectedValue = value as String;
                                        month = value;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 12,
                                    iconEnabledColor: Colors.yellow,
                                    iconDisabledColor: Colors.grey,
                                    buttonHeight: 50,
                                    buttonWidth: 60,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Constants.purpleDark,
                                    ),
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownMaxHeight: 200,
                                    dropdownWidth: 100,
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.redAccent,
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(6),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "ค่าเช่าห้อง",
                                style: TextStyle(
                                  color: Constants.orangeLight,
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 80,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select Item',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellow,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: list
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownValue,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        selectedValue = value as String;
                                        rentr = value;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 12,
                                    iconEnabledColor: Colors.yellow,
                                    iconDisabledColor: Colors.grey,
                                    buttonHeight: 50,
                                    buttonWidth: 60,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Constants.purpleDark,
                                    ),
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownMaxHeight: 200,
                                    dropdownWidth: 100,
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.redAccent,
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(20),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "บาท",
                                style: TextStyle(
                                    fontFamily: 'fonts1',
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "ค่าไฟ",
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
                                            primaryColorDark:
                                                Colors.orangeAccent),
                                        child: TextField(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          controller: elecUnit,
                                          decoration: const InputDecoration(
                                            labelText: 'หน่วยไฟ',
                                            labelStyle: TextStyle(
                                                fontFamily: 'fonts1',
                                                fontSize: 10,
                                                color: Colors.grey),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.teal)),
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      )),
                                  Row(
                                    children: [
                                      Text(
                                        "หน่วยละ",
                                        style: TextStyle(
                                            fontFamily: 'fonts1',
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        data['elecBill'],
                                        style: TextStyle(
                                            fontFamily: 'fonts1',
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "บาท",
                                        style: TextStyle(
                                            fontFamily: 'fonts1',
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                              Container(
                                width: 80,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select Item',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellow,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: listwater
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: dropdownValueWater,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        selectedValue = value as String;
                                        water = value;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 14,
                                    iconEnabledColor: Colors.yellow,
                                    iconDisabledColor: Colors.grey,
                                    buttonHeight: 50,
                                    buttonWidth: 60,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Constants.purpleDark,
                                    ),
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownMaxHeight: 200,
                                    dropdownWidth: 100,
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.redAccent,
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(20),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "บาท",
                                style: TextStyle(
                                    fontFamily: 'fonts1',
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(padding: const EdgeInsets.all(10)),
                          ElevatedButton(
                            child: Text("ยืนยัน"),
                            onPressed: () {
                              setState(() {
                                Get.arguments['index'] =
                                    Get.arguments['index'] + 1;
                                print(selectedIndex);
                              });
                              if (pddes == "" ||
                                  elec == "" ||
                                  month == "" ||
                                  elecUnit.text == "" ||
                                  water == "" ||
                                  rentr == "") {
                                showMessageBox(context, "Error",
                                    "Please enter name and description before adding it to firebase",
                                    actions: [dismissButton(context)]);
                              } else {
                                Future<void> addBill(
                                    BuildContext context,
                                    Map<String, dynamic> data,
                                    String documentName) {
                                  return FirebaseFirestore.instance
                                      .collection(Get.arguments['code_name'])
                                      .doc(documentName)
                                      .set(data)
                                      .then((returnData) {
                                    showMessageBox(context, "สำเร็จ",
                                        "เพิ่มบิลห้อง${Get.arguments['name']} สำเร็จ",
                                        actions: [
                                          dismissButton(context),
                                        ]);
                                    logger.i("setData success");
                                  }).catchError((e) {
                                    logger.e(e);
                                  });
                                }

                                addBill(
                                    context,
                                    {
                                      "title": 'บิลค่าเช่าเดือน ${month} ',
                                      "trailing": pddes,
                                      "elec": data['elecBill'],
                                      "elecUnitOld": data['elecUnitOld'],
                                      "elecUnit": elecUnit.text,
                                      "water": water,
                                      "rentr": rentr,
                                      "month": month
                                    },
                                    elecUnit.text);

                             

                                Future<void> addNotification(
                                    BuildContext context,
                                    Map<String, dynamic> data,
                                    String documentName) {
                                  return FirebaseFirestore.instance
                                      .collection('notifications')
                                      .doc()
                                      .set(data)
                                      .then((returnData) {
                                    logger.i("setData success");
                                  }).catchError((e) {
                                    logger.e(e);
                                  });
                                }

                                addNotification(
                                    context,
                                    {
                                      "description": 'คุณได้รับบิลเดือน ${month}',
                                      "image":
                                          'https://cdn-icons-png.flaticon.com/512/2851/2851468.png',
                                      "name": 'แจ้งเดือนใหม่',
                                    },
                                    selectedIndex.toString());

                                
                              }

                              Future<void> updateMonth(
                                  BuildContext context,
                                  Map<String, dynamic> data,
                                  String documentName) {
                                return FirebaseFirestore.instance
                                    .collection("rooms")
                                    .doc(documentName)
                                    .set({'month': month},
                                        SetOptions(merge: true)).then((value) {
                                  //Do your stuff.
                                });
                              }

                              updateMonth(context, data, Get.arguments['nameid']);
                              Future<void> updateElec(
                                  BuildContext context,
                                  Map<String, dynamic> data,
                                  String documentName) {
                                return FirebaseFirestore.instance
                                    .collection("bill_puchat_01")
                                    .doc(documentName)
                                    .set({'elecOil': elec},
                                        SetOptions(merge: true)).then((value) {
                                  //Do your stuff.
                                });
                              }

                              Future<void> updateBill(
                                  BuildContext context,
                                  Map<String, dynamic> data,
                                  String documentName) {
                                return FirebaseFirestore.instance
                                    .collection("setting_bill")
                                    .doc('setting_bill')
                                    .set({'elecUnitOld': elecUnit.text},
                                        SetOptions(merge: true)).then((value) {
                                  //Do your stuff.
                                });
                              }

                              updateBill(context, data, 'setting_bill');
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
