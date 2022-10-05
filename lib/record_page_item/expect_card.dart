import 'package:flutter/material.dart';

class ExpectCard extends StatelessWidget{
  final String expectation;

  ExpectCard({required this.expectation});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          height: 80,
          width: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    expectation,
                    style: TextStyle(fontFamily: 'Inter', color: Colors.grey[300], fontSize: 24))
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Color(0x3f000000),
                  offset: Offset(0,-2),
                  blurRadius: 4,
                  spreadRadius: 0),
              BoxShadow(
                  color: Color(0x3f000000),
                  offset: Offset(0,2),
                  blurRadius: 4,
                  spreadRadius: 0),
            ]),
        ),
      );
  }
}


