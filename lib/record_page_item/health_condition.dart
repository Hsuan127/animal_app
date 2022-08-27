import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:animal_app/record_page_item/condition.dart';
import 'package:animal_app/record_page_item/vaccine.dart';
import 'package:animal_app/record_page_item/go_to_the_doctor.dart';

class HealthCondition extends StatelessWidget{


  const HealthCondition({Key? key}) : super(key: key);
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VaccinePage()));
  }
  void _navigateToDoctorScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorPage()));
  }
  void _navigateToConditionScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Condition()));
  }
}
