import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/screens/add_bill.dart';
import 'package:flutter_admin/bill/add_bill_page.dart';
import 'package:flutter_admin/bill/show_dialog_list2.dart';
import 'package:get/get.dart';

class ListRoomPage2 extends StatefulWidget {
  ListRoomPage2({Key? key}) : super(key: key);

  @override
  State<ListRoomPage2> createState() => _ListRoomPage2State();
}

class _ListRoomPage2State extends State<ListRoomPage2> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _listRoom = FirebaseFirestore.instance
        .collection('rooms_kasalong')
        .orderBy("status")
        .snapshots();
    return Scaffold(
      // appBar: AppBar(),
      body: StreamBuilder(
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
                            Get.dialog(ShowDialogList2(), arguments: data);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 30,
                              child: Image.asset("assets/images/horlogo.png"),
                            ),
                            title: Text(
                              data['name'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: data['status'] == false ?
                            Text("มีผู้เช่า",
                                style: TextStyle(color: Colors.green))
                                :  Text("ไม่มีผู้เช่า",
                                style: TextStyle(color: Colors.grey))
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    )
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
