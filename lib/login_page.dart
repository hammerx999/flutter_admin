import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_admin/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredentail = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredentail.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text('error')),
              body: Center(child: Text('${snapshot.error}')),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              
              children: [
                 Image.asset(
            "assets/images/back.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
                Scaffold(
       backgroundColor: Colors.transparent,
                  body: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                        Image(
                            image: AssetImage('assets/images/horlogo.png'),
                            height: 90,
                          ),
                      Text('SURIYA HOME',style: TextStyle(fontSize: 24, color: Constants.orangeLight),),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: [
                                Color.fromARGB(255, 26, 65, 65),
                                Theme.of(context).primaryColor
                              ]),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height:  MediaQuery.of(context).size.height * 0.45,
                          width:  MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                                        ),
                          child: Column(children: [
                          
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: FormBuilder(
                                key: _formkey,
                                initialValue: {
                                  'email': '',
                                  'password': '',
                                },
                                autovalidateMode: AutovalidateMode.always,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: <Widget>[
                                      Text('ลงชื่อเข้าใช้',
                                          style: TextStyle(
                                              fontFamily: 'fonts1', fontSize: 20)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: _emailController,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'User',
                                            labelStyle: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 12,
                                                fontFamily: 'fonts1'),
                                            fillColor:
                                                Color.fromARGB(58, 255, 255, 255),
                                            filled: true,
                                            errorStyle:
                                                TextStyle(color: Colors.redAccent),
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: _passwordController,
                                          maxLines: 1,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              labelText: 'Password',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 12,
                                                  fontFamily: 'fonts1'),
                                              fillColor: Colors.white24,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(color: Colors.redAccent)),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'กรุณากรอกรหัสผ่าน';
                                            } else
                                              return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 14),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(255, 26, 61, 70),
                                          ),
                                          onPressed: () async {
                                            User? user =
                                                await loginUsingEmailPassword(
                                                    email: _emailController.text,
                                                    password:
                                                        _passwordController.text,
                                                    context: context);
                                            if (user != null) {
                                              Navigator.of(context).pushNamed(
                                                '/', arguments: _emailController.text
                                              );
                                            }
                                          },
                                          child: Text(
                                            'เข้าสู่ระบบ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: 'fonts1'),
                                          ),
                                        ),
                                      ),
                                     
                                      
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width * 0.05,)
                      ],
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ],
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
