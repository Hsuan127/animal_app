import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:animal_app/record_page_item/add_doctor.dart';

class DoctorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //createState方法會回傳一個state組件
    return _DoctorPageState();
    //上述的組件就是這個
  }
}

class _DoctorPageState extends State<DoctorPage> {

  void _navigateToAddDoctorScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDoctor()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('就醫紀錄')),
      body: Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
        alignment: Alignment.centerLeft,
        child: Container(
        child: Text('歷史紀錄',
        style: TextStyle(fontSize: 24)),
                ),
        ),
        Divider(
        color: Colors.grey[400],
        height: 10,
        thickness: 2,
        ),
        Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber, width: 2),
              //color: Colors.blueAccent,
            ),
            child: IconButton(
              iconSize: 25,
              padding: const EdgeInsets.all(5),
              icon: const Icon(
                Icons.add,
                color: Colors.amber,
              ),
              onPressed: (){
                _navigateToAddDoctorScreen(context);
                // createRecord();
              },
            )
        ),

          ],
         ),
      ),

    );
  }
}