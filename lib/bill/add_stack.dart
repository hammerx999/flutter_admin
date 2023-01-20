import 'package:flutter/material.dart';
import 'package:flutter_admin/bill/add_bill_page.dart';
import 'package:flutter_admin/bill/list_room_page.dart';
import 'package:get/get.dart';


class AddStack extends StatefulWidget {
  AddStack({Key? key}) : super(key: key);

  @override
  State<AddStack> createState() => _AddStackState();
}

class _AddStackState extends State<AddStack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Get.arguments != null ? AddBillPage() : ListRoomPage(),
    );
  }
}