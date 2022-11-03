import 'package:animal_app/signIn_signUp_item/sign_in_page.dart';
import 'package:animal_app/temp_utils/matchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首頁'),
      ),
      body: Center(child: Text("首頁")),
    );
  }
}
 */

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("首頁"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              child: Text("Hospital Records"),
              onPressed: () {
                /*
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HospitalWritingPage()));
              */
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Vaccine Records"),
              onPressed: () {
                /*
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VaccineWritingPage()));
              */
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Spending Records"),
              onPressed: () {
                /*
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SpendWritingPage()));
                 */
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Pet ID"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MatchScreen()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInPage()));
                  });
                })
          ],
        ),
      ),
    );
  }
}