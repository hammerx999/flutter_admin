import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/constants.dart';
import 'package:flutter_admin/screens/add_bill.dart';
import 'package:flutter_admin/bill/add_bill_page.dart';
import 'package:flutter_admin/bill/show_dialog.dart';
import 'package:get/get.dart';

class ListRoomPage extends StatefulWidget {
  ListRoomPage({Key? key}) : super(key: key);

  @override
  State<ListRoomPage> createState() => _ListRoomPageState();
}

class _ListRoomPageState extends State<ListRoomPage> {
  var drop = false;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _listRoom = FirebaseFirestore.instance
        .collection('rooms')
        .orderBy("status")
        .snapshots();
    return Scaffold(
      // appBar: AppBar(),
      body:Container(
        child:  StreamBuilder(
        stream: _listRoom,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshoot) {
          if (streamSnapshoot.hasError) {
            return Text('Something went wrong');
          }

          if (streamSnapshoot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else {
            return ListView(
              children:
                  streamSnapshoot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                  
                    Container(
                        height: 40,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                             Get.dialog(ShowDialog(), arguments: data);
                            // Get.to(AddBill(),arguments: data['name']);
                          },
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.pink,
                                radius: 30,
                                child: Image.asset("assets/images/horlogo.png"),
                              ),
                              title: data['month'] != null ?
                              
                              Row(
                                children: [
                                 
                                  Text(
                                    data['name'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),SizedBox(width: 6,),
                                   Text( '( ${
                                    data['month'].toString()} )',
                                    style: TextStyle(color: Constants.orangeDark),
                                  ),
                                ],
                              ) : 
                                  Text(
                                    data['name'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                              subtitle: data['status'] == false
                                  ? Text("มีผู้เช่า",
                                      style: TextStyle(color: Colors.green))
                                  : Text("ไม่มีผู้เช่า",
                                      style: TextStyle(color: Colors.grey))),
                        )),
                    
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              }).toList()
            );
          }
        },
      ),
      )
    );
  }
}
