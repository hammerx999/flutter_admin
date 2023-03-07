import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/constants.dart';
import 'package:flutter_admin/services/add_bill_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CheckDetailPage extends StatefulWidget {
  CheckDetailPage({Key? key}) : super(key: key);

  @override
  State<CheckDetailPage> createState() => _CheckDetailPageState();
}

class _CheckDetailPageState extends State<CheckDetailPage> {
  final Stream<QuerySnapshot> _check =
      FirebaseFirestore.instance.collection('list_images').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _check,
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

                return Column(
                  children: [
                    Text(
                      Get.arguments['name'],
                      style: TextStyle(color: Constants.orangeDark),
                    ),
                   
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 300,
                      width: 250,
                      child: Image.network(
                        '${data['imageUrl']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          deField(context, data, data['elecUnit']);
                        },
                        child: Text('ยืนยัน')),
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
