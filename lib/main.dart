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

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      // home: const MyHomePage(),

      debugShowCheckedModeBanner: false,

      //Start the app with the "/" named route. In this case, the app starts
      //on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        //When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SignInPage(),
        //When navigating to the "/matchPage" route, build the MatchPage widget.
        '/homePage': (context) => BottomAPPBar(2),
        '/matchPage': (context) => BottomAPPBar(0),
        '/matchFavPage': (context) => BottomAPPBar(6),
        '/matchFilterPage': (context) => BottomAPPBar(5),
        '/recordPage': (context) => RecordPage(),
        '/mapPage': (context) => MapPage(),
        '/linkPage': (context) => LinkPage(),
      },
    );
  }
}