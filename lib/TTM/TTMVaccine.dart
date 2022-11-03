
import 'package:cloud_firestore/cloud_firestore.dart';

class TTMVaccine
{
  static const String DIR = "Vaccine" ;

  final int type ;
  final String name ;
  final DateTime date ;
  final String description ;
  final bool done ;
  final QueryDocumentSnapshot? snapshot ;

  TTMVaccine( this.type , this.name , this.date , this.description , this.done  , [ this.snapshot = null ]);

  Map<String, dynamic> toJson() => {
    'type': type,
    'name': name,
    'date': date,
    'description': description,
    'done': done
  };
//   'type': '',
//   'expense': '',
//   'date': '',
//   'description':'',
//   'done': false,

  TTMVaccine.fromSnapshot(snapshot)
      : type = int.parse( snapshot.data()['type'].toString()),
        name = snapshot.data()['name']??"" ,
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