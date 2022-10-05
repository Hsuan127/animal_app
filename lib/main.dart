import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animal_app/signIn_signUp_item/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'bottomAPPBar.dart';
import 'matchPage.dart';
import 'package:animal_app/recordPage.dart';
import 'homePage.dart';
import 'mapPage.dart';
import 'linkPage.dart';
import 'package:animal_app/record_page_item/add_expense.dart';
import 'package:animal_app/record_page_item/add_vaccine.dart';
import 'package:animal_app/record_page_item/add_doctor.dart';
import 'package:animal_app/record_page_item/condition.dart';
import 'package:animal_app/record_page_item/weight_record.dart';
import 'package:animal_app/record_page_item/shit_record.dart';
import 'package:animal_app/record_page_item/activity_record.dart';
import 'package:animal_app/record_page_item/diet_record.dart';

import 'package:intl/date_symbol_data_local.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting(); // TODO 20220912: 多國語言，不然圖表跑不出來
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.amber,
          appBarTheme: const AppBarTheme(
              //backgroundColor: Colors.white,
              // This will be applied to the "back" icon
              iconTheme: IconThemeData(color: Colors.white),
              // This will be applied to the action icon buttons that locates on the right side
              actionsIconTheme: IconThemeData(color: Colors.white),
              centerTitle: true,
              elevation: 15,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 26)),
      ),

      // home: const MyHomePage(),

      debugShowCheckedModeBanner: false,

      //Start the app with the "/" named route. In this case, the app starts
      //on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        //When navigating to the "/" route, build the FirstScreen widget.
        // TODO 20220912:  有登入就直接跳到主頁，沒有就進登入畫面
        '/': (context) => ( FirebaseAuth.instance.currentUser != null ) ? BottomAPPBar(2) : SignInPage() ,
        //When navigating to the "/matchPage" route, build the MatchPage widget.
        '/homePage': (context) => BottomAPPBar(2),
        '/matchPage': (context) => BottomAPPBar(0),
        '/matchFavPage': (context) => BottomAPPBar(6),
        '/matchFilterPage': (context) => BottomAPPBar(5),
        '/recordPage': (context) => RecordPage(),
   //     '/addExpense': (context) => BottomAPPBar(7),
        '/mapPage': (context) => MapPage(),
        '/linkPage': (context) => LinkPage(),
      },
    );
  }
}