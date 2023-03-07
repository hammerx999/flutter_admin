import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_admin/bill/show_notification.dart';

import 'logger_service.dart';


Future<void> updateBill(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("bills")
      .doc()
      .set({'success': 'ชำระเงินแล้ว'}, SetOptions(merge: true)).then((value) {
    //Do your stuff.
  });
}

Future<void> deField(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("bill_putchat_01")
      .doc(documentName)
      .update({'trailing': FieldValue.delete()}).whenComplete(() {
    print('Field Deleted');
  });
}

Future<void> addNameRoom(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("noticonfirm")
      .doc(documentName)
      .set(data)
      .then((returnData) {
    logger.i("setData success");
  }).catchError((e) {
    logger.e(e);
  });
}



Future<void> deConfirm(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("confirms")
      .doc(documentName)
      .update({'confirm': FieldValue.delete()}).whenComplete(() {
    print('Field Deleted');
  });
}




