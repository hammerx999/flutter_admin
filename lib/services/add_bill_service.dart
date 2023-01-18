

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_admin/services/show_notification.dart';


import 'logger_service.dart';

Future<void> addBill(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("bills")
      .doc(documentName)
      .set(data)
      .then((returnData) {
    showMessageBox(context, "Success", "Added item($documentName) to Firestore",
        actions: [dismissButton(context)]);
    logger.i("setData success");
  }).catchError((e) {
    logger.e(e);
  });
}

Future<void> updateBill(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("bills")
      .doc(documentName)
      .set({'success': 'ชำระเงินแล้ว'}, SetOptions(merge: true)).then((value) {
    //Do your stuff.
  });
}

Future<void> deField(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("bills")
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

Future<void> addConfirm(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("confirms")
      .doc(documentName)
      .set(data)
      .then((returnData) {})
      .catchError((e) {
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

Future<void> addNews(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return FirebaseFirestore.instance
      .collection("news")
      .doc(documentName)
      .set(data)
      .then((returnData) {
    showMessageBox(context, "Success", "Added item($documentName) to Firestore",
        actions: [dismissButton(context)]);
    logger.i("setData success");
  }).catchError((e) {
    logger.e(e);
  });
}
