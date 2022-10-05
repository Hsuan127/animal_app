import 'package:animal_app/TTM/TTMItem.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:animal_app/record_page_item/condition.dart';
import 'package:animal_app/record_page_item/vaccine.dart';
import 'package:animal_app/record_page_item/go_to_the_doctor.dart';

import '../TTM/TTMUser.dart';
import '../bottomAPPBar.dart';

class HealthCondition extends StatelessWidget{

  final TTMUser user ;
  final TTMItem item ;

  const HealthCondition(
      TTMUser this.user ,
      TTMItem this.item ,
      {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: (){
                _navigateToVaccineScreen(context);
              },
              icon: const Icon(Icons.vaccines),
              label: const Text('疫苗施打'),
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(300, 50),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            OutlinedButton.icon(
              onPressed: (){
                _navigateToDoctorScreen(context);
              },
              icon: const Icon(Icons.assignment_outlined),
              label: const Text('就醫紀錄'),
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(300, 50),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            OutlinedButton.icon(
              onPressed: (){
                _navigateToConditionScreen(context);
              },
              icon: const Icon(Icons.flash_on_outlined),
              label: const Text('狀態紀錄'),
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(300, 50),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ],
         ),
      ),
    );
  }
  void _navigateToVaccineScreen(BuildContext context) {
   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VaccinePage( user , item )));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>BottomAPPBar( 1 , child: VaccinePage( this.user  , item ))));
  }
  void _navigateToDoctorScreen(BuildContext context) {
 //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorPage( this.user , this.item )));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>BottomAPPBar( 1 , child: DoctorPage( this.user  , item ))));

  }
  void _navigateToConditionScreen(BuildContext context) {
   // BottomAPPBar
 //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Condition( this.item )));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>BottomAPPBar( 1 , child: Condition( this.item ))));
  }
}
