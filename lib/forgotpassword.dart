//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';

class forgotpassword extends StatefulWidget {
  @override
  _forgotpasswordState createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget Title = Container(
    padding: EdgeInsets.symmetric(
      horizontal: 20,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    ),
  );
  Widget back = Container(
      child: Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: 615,
        width: 300,
      ),
      Positioned(
        top: 0,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 510,
          width: 290,
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 35),
        ),
      ),
    ],
  ));
  Widget text(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Container(
            child: const Text(
              "ลืมรหัสผ่านใช่หรือไม่?",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
          SizedBox(height: 50),
          Text("กรอกอีเมลของคุณ", style: TextStyle(fontSize: 20)),
          SizedBox(height: 50),
          Text("ระบบจะทำการส่งลิงก์ไปยังอีเมลของคุณ",
              style: TextStyle(color: Colors.black54)),
          Text(" เพื่อ reset รหัสผ่าน",
              style: TextStyle(color: Colors.black54)),
          SizedBox(height: 50),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12)),
            child: Container(
                padding: EdgeInsets.all(10),
                constraints: const BoxConstraints(
                    minWidth: 80, minHeight: 40, maxWidth: 260),
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "EMAIL",
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                            width: 180,
                            height: 30,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          )
                        ]),
                  ],
                )),
          ),
          SizedBox(height: 13),
          Container(
            // width: 120,
            padding: EdgeInsets.only(left: 30, top: 7, right: 7, bottom: 7),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue, Colors.blue]),
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(40), left: Radius.circular(40))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "ถัดไป",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Container(width: 15),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: IconButton(
                        onPressed: () async {
                          resetPassword();
                        },
                        icon: Icon(Icons.arrow_forward_rounded),
                        iconSize: 25,
                        color: Colors.black54),
                    width: 40,
                    height: 40,
                  )
                ]),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                " ",
                style: TextStyle(fontSize: 13),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  });
                },
                child: Container(
                    child: const Text(
                  "กลับไปยังหน้า login",
                  style: TextStyle(color: Colors.black),
                )),
              ),
            ],
          ),
          SizedBox(height: 80, width: 20),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    const color3 = const Color(0xFF38BF68);
    return Form(
        key: _formKey,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Balsamiq_Sans'),
            home: Scaffold(
                backgroundColor: Colors.red[300],
                body: Container(
                  child: Container(
                    //  margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView(children: [
                      Title,
                      Stack(alignment: Alignment.center, children: [
                        back,
                        text(context),
                      ])
                    ]),
                  ),
                ))));
  }

  resetPassword() async {
    String email = _emailController.text.toString();
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
