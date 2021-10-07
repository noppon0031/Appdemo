import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:noppon/Business/add_image.dart';
import 'package:noppon/Business/business_list_user.dart';
import 'package:noppon/User/favorite.dart';
import 'package:noppon/Entrepreneur/launcher.dart';
import 'package:noppon/User/profile.dart';
import 'package:noppon/login.dart';
import 'package:noppon/register.dart';
import 'package:noppon/src/blocs/application_bloc.dart';

import 'splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:noppon/src/blocs/application_bloc.dart';
// import 'package:noppon/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Flutter Firebase',
        /* theme: ThemeData(
        primarySwatch: Colors.blue,
      ), */
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
