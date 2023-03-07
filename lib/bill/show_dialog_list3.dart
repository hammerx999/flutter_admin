import 'package:flutter/material.dart';
import 'package:flutter_admin/bill/add_bill_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/services/storage_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storgae;
import 'package:firebase_core/firebase_core.dart';

import '../constants.dart';
import '../services/add_bill_service.dart';
import 'show_notification.dart';

class ShowDialogList3 extends StatelessWidget {
  const ShowDialogList3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
      backgroundColor: Constants.purpleDark,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                                ),
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width * 0.25,
          child: AddBillPage(),
        ),
      ));
}
