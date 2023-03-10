import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/screens/add_bill.dart';
import 'package:flutter_admin/bill/setting_bill_page.dart';
import 'package:flutter_admin/screens/check_bill.dart';
import 'package:flutter_admin/constants.dart';
import 'package:flutter_admin/login_page.dart';
import 'package:flutter_admin/screens/setting_bill.dart';
import 'package:flutter_admin/screens/home.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyD3xGPi9VlJPkEwKPQkzUFldQPGzrw9pVE",
    appId: "1:1089337010053:web:40f6edabb5977e5bf1c6ec",
    messagingSenderId: "1089337010053",
    projectId: "flutter-hor",
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Constants.purpleDark,
          canvasColor: Constants.purpleLight),
      initialRoute: '/',
      routes: {
        '/': (context) => WidgetTree(), 
        '/add': (context) => AddBill(),
        '/login' : (context) => LoginPage(),
        '/setbill' :(p0) => WidgetSetting(),
        '/check' :(p0) => WidgetCheck()
        },
       
      debugShowCheckedModeBanner: false,
    );
    
  }
}
