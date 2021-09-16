// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:noppon/Business/business_list.dart';
// import 'package:noppon/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   var user_id, email, password, photo, username, tel, type;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       _asyncMethod();
//     });
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _asyncMethod();
//     }
//   }

//   void _asyncMethod() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       user_id = prefs.getString('user_id');
//       email = prefs.getString('email');
//       password = prefs.getString('password');
//       photo = prefs.getString('photo');
//       username = prefs.getString('username');
//       tel = prefs.getString('tel');
//       type = prefs.getString('type');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: AppBar(
//           title: Text('เพิ่มร้านค้า'),
//           backgroundColor: Colors.red,
//         ),
//         body: Stack(
//           children: <Widget>[
//             ListView(
//               padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//               children: <Widget>[
//                 Text('หมวดหมู่'),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop1.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "ร้านอาหาร"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop2.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "ร้านกาแฟ"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop3.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "ร้านเครื่องเขียน"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop4.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "ร้านเสริมสวย"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop5.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "คลินิก/ขายยา"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop6.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "ร้านทั่วไป"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop7.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "สถานที่ใน Rmutt"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                       height: 80,
//                       width: 150,
//                       child: IconButton(
//                         icon: Image.asset('assets/shop8.png'),
//                         iconSize: 150,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   Business_List(type: "สถานที่ทั่วไป"),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }

//   LogoutMethod(BuildContext context) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(children: [
//             Image.asset(
//               'assets/logo.png',
//               width: 30,
//               height: 30,
//               fit: BoxFit.contain,
//             ),
//             Text('  แจ้งเตือน')
//           ]),
//           content: Text("คุณต้องการออกจากระบบ ใช่หรือไม่?"),
//           actions: <Widget>[
//             // ignore: deprecated_member_use
//             FlatButton(
//               child: Text(
//                 "ไม่ใช่",
//                 style: new TextStyle(color: Colors.blue),
//               ),
//               onPressed: () {
//                 Navigator.of(context, rootNavigator: true).pop('dialog');
//               },
//             ),
//             // ignore: deprecated_member_use
//             FlatButton(
//               child: Text(
//                 "ใช่",
//                 style: new TextStyle(color: Colors.blue),
//               ),
//               onPressed: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 prefs.clear();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
