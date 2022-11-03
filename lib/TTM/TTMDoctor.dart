
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TTMDoctor
{
  static const String DIR = "Doctor" ;

  /*

   */
  final int type ;
  final String hospital ; //醫院
  final String problem ;
  final DateTime date ;
  final String description ;
  final bool done ;
  final QueryDocumentSnapshot? snapshot ;

  TTMDoctor( this.type , this.hospital , this.problem , this.date , this.description , this.done , [ this.snapshot = null ] ) ;

  Map<String, dynamic> toJson() => {
    'type': type,
    'hospital' : hospital,
    'problem': problem,
    'date': date,
    'description':description,
    'done': done ,
  };



  TTMDoctor.fromSnapshot( snapshot)
      : type = int.parse( snapshot.data()['type'].toString()),
        hospital = snapshot.data()['hospital']??"" ,
        problem = snapshot.data()['problem']??"" ,
        date = snapshot.data()['date'].toDate() ,
        description = snapshot.data()['description']??"",
        done = snapshot.data()['done']??"" ,
        this.snapshot = snapshot
  ;

  //
  String getDate()
  {
    try{
      String str = date.toString() ;
      int index = str.indexOf( ' ' );
      if( index > 0 )
        str = str.substring( 0 , index );
      return str ;
    }catch (_){}
    return date.toString();
  }


  //
  Future<void> upDate()async
  {
    await snapshot!.reference.update( this.toJson());
  }

  Future<void> del() async
  {
    await snapshot!.reference.delete();
  }
}