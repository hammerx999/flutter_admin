import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/add_bill.dart';
import 'package:flutter_admin/bill/add_bill_page.dart';
import 'package:get/get.dart';

class ListRoomPage extends StatefulWidget {
  ListRoomPage({Key? key}) : super(key: key);

  @override
  State<ListRoomPage> createState() => _ListRoomPageState();
}

class _ListRoomPageState extends State<ListRoomPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _listRoom = FirebaseFirestore.instance
        .collection('rooms')
        .orderBy("name")
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
                            Get.to(AddBill(),arguments: 1);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://www.google.com/imgres?imgurl=https%3A%2F%2Ftraining-saraburi.cdd.go.th%2Fwp-content%2Fuploads%2Fsites%2F149%2F2018%2F08%2Fperson-outline-icon-png-person-outline-icon-png-person-17.png&imgrefurl=https%3A%2F%2Ftraining-saraburi.cdd.go.th%2Fdownloads%2F%25E0%25B8%25A3%25E0%25B8%25B2%25E0%25B8%25A2%25E0%25B8%258A%25E0%25B8%25B7%25E0%25B9%2588%25E0%25B8%25AD%25E0%25B8%259C%25E0%25B8%25B9%25E0%25B9%2589%25E0%25B9%2580%25E0%25B8%2582%25E0%25B9%2589%25E0%25B8%25B2%25E0%25B8%25A3%25E0%25B8%25B1%25E0%25B8%259A%25E0%25B8%2581%25E0%25B8%25B2%25E0%25B8%25A3%25E0%25B8%259D%25E0%25B8%25B6%2Fattachment%2Fperson-outline-icon-png-person-outline-icon-png-person-17&tbnid=KsvPS8r1Unh8DM&vet=12ahUKEwiblPGct9L8AhVCgGMGHZH1BfkQMygNegUIARDRAQ..i&docid=H6-1uQH-EeG7CM&w=512&h=512&q=person%20png&ved=2ahUKEwiblPGct9L8AhVCgGMGHZH1BfkQMygNegUIARDRAQ')),
                            title: Text(
                              data['name'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(data['name'].toString(),
                                style: TextStyle(color: Colors.white)),
                          ),
                        )),
                    SizedBox(
                      height: 10,
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
