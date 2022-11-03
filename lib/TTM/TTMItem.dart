
import 'dart:ffi';

import 'package:animal_app/TTM/TTMCondition.dart';
import 'package:animal_app/TTM/TTMSpendRecords.dart';
import 'package:animal_app/TTM/TTMVaccine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TTMPieCondition.dart' ;
import 'TTMDoctor.dart';

class TTMItem
{

  static final shitName = ["正常", "便秘", "腹瀉" ] ;
  static final foodName = ["正常", "偏少", "偏多" ] ;
  static final activityName =  [ "低" , "中" , "高" ];

  static Future<TTMItem> init( QueryDocumentSnapshot queryDocumentSnapshot )async
  {
    dynamic map = await queryDocumentSnapshot.reference.get();
    if( map == false )
      throw "now data" ;

    return new TTMItem( queryDocumentSnapshot.reference , queryDocumentSnapshot.id , map["_name"] , map["_money"] );

  }

  //
  //
  //
  final String _id ;
  final String _name ;
  int _money ;
  int nextMoney = 0 ;
  final DocumentReference? _documentReference ;
  TTMItem( DocumentReference? documentReference , String id ,String name , int money )
  : _documentReference = documentReference
  , _id = id
  , _name = name
  , _money = money
  ;

  //
  Future<int> getSpend()async
  {

    DateTime dateTime = DateTime.now();
    int ret = 0 ;
    int i ,  nn ;
    // 本月花費
    List<TTMSpendRecords> spends = await getSpendRecords() ;
    for( final TTMSpendRecords spendRecords in spends )
      if( spendRecords.checkYYMM(dateTime))
        ret += spendRecords.spend ;
      // 下月花費
    nextMoney = 0 ;
    nn = 0 ;
    for( i = 0 ; i < 6 ; ++i )
    {
      DateTime exitDate = new DateTime( dateTime.year , dateTime.month - i );
      String monthName = "" ;

      for( final TTMSpendRecords spendRecords in spends ) {
        try {
          if (spendRecords.checkYYMM(exitDate))
            if (spendRecords.dailyIndex == 0) {
              nextMoney += spendRecords.spend;
              nn ++;
            }
        }catch(_){}
      }
      }
    if( nn > 0 )
      nextMoney = nextMoney ~/ nn ;

    /*
    CollectionReference collectionReference = _documentReference!.collection( TTMSpendRecords.DIR  );
    QuerySnapshot querySnapshot =  await collectionReference
        .orderBy("Spend", ).get();
    for( QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs )
    {
      try
      {
        dynamic map = await queryDocumentSnapshot.reference.get();
        if( map != null )
          ret += map["Spend"] as int  ;
      }catch( e )
      {
      }
    }*/
    return _money = ret ;
  }

  //
  //
  String get name => _name ;
  String get id => _id ;
  int get money => _money ;
  //
  Object? toMap()
  {
    return {
      "_name" : _name,
      "_money" : _money ,
    };
  }

  //
  //
  Future<void> addSpendRecords( TTMSpendRecords ttmSpendRecords ) async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;

    CollectionReference collectionReference = _documentReference!.collection( TTMSpendRecords.DIR  );
    await collectionReference.add( ttmSpendRecords.toJson() );



  }

  Future<List<TTMSpendRecords>> getSpendRecords()async
  {
    List<TTMSpendRecords> ret = [] ;
    CollectionReference collectionReference = _documentReference!.collection( TTMSpendRecords.DIR  );
    QuerySnapshot querySnapshot = await collectionReference.get();
    for( QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs )
    {
      try
      {
        ret.add( TTMSpendRecords.fromSnapshot( queryDocumentSnapshot.data() ));
      }catch( e )
      {
      }
    }
    return ret ;
  }

  Future getVaccine() async{

    CollectionReference collectionReference = _documentReference!.collection( TTMVaccine.DIR  );
    return collectionReference.orderBy("date" , descending : true  ).get();;

  }

  Future<void> addVaccine( TTMVaccine vaccine )async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;

    CollectionReference collectionReference = _documentReference!.collection( TTMVaccine.DIR  );
    await collectionReference.add( vaccine.toJson() );

  }


  Future getDoctor() async{

    CollectionReference collectionReference = _documentReference!.collection( TTMDoctor.DIR  );
    return collectionReference.orderBy("date" , descending : true  ).get();

  }

  Future<void> addDoctor( TTMDoctor doctor )async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;

    CollectionReference collectionReference = _documentReference!.collection( TTMDoctor.DIR  );
    await collectionReference.add( doctor.toJson() );

  }

  // 移掉
  Future<void> remove()async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;

    CollectionReference collectionReference = _documentReference!.collection( TTMVaccine.DIR  );
    await collectionReference.parent!.delete();
  }

  //
  // push
  Future<void> pushConditionWeight( double value )async
  {
    _todayWeight = value ;
    await pushCondition( "weight" , value );
  }
  // Future<void> pushConditionShit( int value )async
  // {
  //   try {
  //     _todayShit = shitName[value];
  //     await pushCondition("shit", value);
  //   }catch(_){};
  // }

  // Future<void> pushConditionFood( int value )async
  // {
  //   try {
  //     _todayFood = foodName[value];
  //     await pushCondition("food", value);
  //   }catch(_){};
  // }


  Future<void>  pushCondition( String name , dynamic value )async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;
    DateTime dateTime = DateTime.now();
    String id = "${dateTime.year}-${dateTime.month}" ;

    final Map<String, Object?> updata = {
      name: value,
      "date": "${dateTime.year}/${dateTime.month}/${dateTime.day}"
    } ;

    CollectionReference collectionReference = _documentReference!.collection( TTMCondition.DIR  );
//    collectionReference.doc
  //  await collectionReference.
  ////      .where("", "==", "") ;
//    collectionReference.add( {name : value } );
  //
    DocumentReference reference = await collectionReference.doc( id ).collection( "${dateTime.day}").doc( "data" );
    try {
      await reference.update(updata);
    }catch( e ) {

      await reference.set(updata);
    }
  }

  // 取體重
  Future<TTMPieConditionValue> getWeightMonthList() async
  {
    int i ;
    final TTMPieConditionValue ret = new TTMPieConditionValue() ;
    DateTime dateTime = DateTime.now();
    String id = "${dateTime.year}-${dateTime.month}" ;

    CollectionReference collectionReference = _documentReference!.collection( TTMCondition.DIR ) ;
    DocumentReference documentReference = await collectionReference.doc( id );
    //  collectionReference.
    for( i = 1 ; i <= 31 ; ++i )
    {
      try
      {

        DocumentReference reference = await documentReference.collection( "$i")
            .doc( "data" );
        DocumentSnapshot documentSnapshot = await reference.get();
        Object? object = await documentSnapshot.data() ;
        if(( object is Map ) == false )
          throw "err" ;
        Map map = object as Map ;
        ret.add(
            "$id-${i}" , map['weight'] );
      }catch( e )
      {
        ret.add(
            "$id-${i}" , 0 );
      }
    }

    //
    //

    return ret ;
  }
  //
  // 取得大便量
  Future<void> pushConditionShit( int shit )async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;
    DateTime dateTime = DateTime.now();
    String id = "${dateTime.year}-${dateTime.month}-${dateTime.day}" ;

    _todayShit = shitName[shit] ;
    final Map<String, Object?> updata = {
      'value': shit,
      "date": "${dateTime.year}/${dateTime.month}/${dateTime.day}"
    } ;

    CollectionReference collectionReference = _documentReference!.collection( "shit" );

    //
    DocumentReference reference = await collectionReference.doc( id );//.update( updata );
    try {
      await reference.update(updata);
    }catch( e ) {

      await reference.set(updata);
    }
  }

  Future<Map<String,int>> getShitList() async
  {
    Map<String,int> ret = {} ;
    try {
      CollectionReference collectionReference = _documentReference!.collection(
          "shit");
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs ;
      for( final d in queryDocumentSnapshot ) {
        try {

          ret[d['date']] = d['value'] ;
        }catch(__){}
      }

      //    for (final d : querySnapshot.docs)

    }catch( _ ){}
    return ret ;
  }
  // Future<TTMPieConditionValue> getShitMonthList() async
  // {
  //   int i ;
  //   final TTMPieConditionValue ret = new TTMPieConditionValue() ;
  //   DateTime dateTime = DateTime.now();
  //   String id = "${dateTime.year}-${dateTime.month}" ;
  //
  //   CollectionReference collectionReference = _documentReference!.collection( TTMCondition.DIR ) ;
  //   DocumentReference documentReference = await collectionReference.doc( id );
  // //  collectionReference.
  //   for( i = 1 ; i <= 31 ; ++i )
  //     {
  //       try
  //       {
  //
  //         DocumentReference reference = await documentReference.collection( "$i")
  //             .doc( "data" );
  //         DocumentSnapshot documentSnapshot = await reference.get();
  //         Object? object = await documentSnapshot.data() ;
  //         if(( object is Map ) == false )
  //           throw "err" ;
  //         Map map = object as Map ;
  //         ret.add(
  //           "${ shitName[map['shit']]}" , 1 );
  //       }catch( e )
  //       {
  //
  //       }
  //     }
  //
  //   //
  //   //
  //
  //   return ret ;
  // }
  // 進食量
  Future<void> pushConditionFood( int food )async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;
    DateTime dateTime = DateTime.now();
    String id = "${dateTime.year}-${dateTime.month}-${dateTime.day}" ;

    _todayFood = foodName[food] ;
    final Map<String, Object?> updata = {
      'value': food,
      "date": "${dateTime.year}/${dateTime.month}/${dateTime.day}"
    } ;

    CollectionReference collectionReference = _documentReference!.collection( "food" );

    //
    DocumentReference reference = await collectionReference.doc( id );//.update( updata );
    try {
      await reference.update(updata);
    }catch( e ) {

      await reference.set(updata);
    }  }

  Future<Map<String,int>> getFoodList() async
  {
    Map<String,int> ret = {} ;
    try {
      CollectionReference collectionReference = _documentReference!.collection(
          "food");
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs ;
      for( final d in queryDocumentSnapshot ) {
        try {

          ret[d['date']] = d['value'] ;
        }catch(__){}
      }

      //    for (final d : querySnapshot.docs)

    }catch( _ ){}
    return ret ;
  }
  //
  // 取得進食量
  // Future<TTMPieConditionValue> getFoodMonthList() async
  // {
  //   int i ;
  //   final TTMPieConditionValue ret = new TTMPieConditionValue() ;
  //   DateTime dateTime = DateTime.now();
  //   String id = "${dateTime.year}-${dateTime.month}" ;
  //
  //   CollectionReference collectionReference = _documentReference!.collection( TTMCondition.DIR ) ;
  //   DocumentReference documentReference = await collectionReference.doc( id );
  //   //  collectionReference.
  //   for( i = 1 ; i <= 31 ; ++i )
  //   {
  //     try
  //     {
  //
  //       DocumentReference reference = await documentReference.collection( "$i")
  //           .doc( "data" );
  //       DocumentSnapshot documentSnapshot = await reference.get();
  //       Object? object = await documentSnapshot.data() ;
  //       if(( object is Map ) == false )
  //         throw "err" ;
  //       Map map = object as Map ;
  //       ret.add(
  //           "${ foodName[map['food']]}" , 1 );
  //     }catch( e )
  //     {
  //
  //     }
  //   }
  //
  //   return ret ;
  // }
  //
  // 活動量
  Future<void> pushConditionActivity( int activity )async
  {
    if( _documentReference == null )
      throw "no _documentReference " ;
    DateTime dateTime = DateTime.now();
    String id = "${dateTime.year}-${dateTime.month}-${dateTime.day}" ;

    _todayActivity = activityName[activity] ;
    final Map<String, Object?> updata = {
      'value': activity,
      "date": "${dateTime.year}/${dateTime.month}/${dateTime.day}"
    } ;

    CollectionReference collectionReference = _documentReference!.collection( "activity" );

    //
    DocumentReference reference = await collectionReference.doc( id );//.update( updata );
    try {
      await reference.update(updata);
    }catch( e ) {

      await reference.set(updata);
    }  }

  Future<Map<String,int>> getActivityList() async
  {
    Map<String,int> ret = {} ;
    try {
      CollectionReference collectionReference = _documentReference!.collection(
          "activity");
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs ;
      for( final d in queryDocumentSnapshot ) {
        try {

            ret[d['date']] = d['value'] ;
            }catch(__){}
        }

  //    for (final d : querySnapshot.docs)

    }catch( _ ){}
    return ret ;
  }

  // 本日大便
  String _todayShit = "" ;
  Future<void>initTodayShit() async
  {
    Map<String,int> ret = {} ;
    try {
      CollectionReference collectionReference = _documentReference!.collection(
          "shit");
      DateTime dateTime = DateTime.now();
      String key = "${dateTime.year}-${dateTime.month}-${dateTime.day}" ;
      DocumentSnapshot documentSnapshot = await collectionReference.doc(key).get();
      Object? object = await documentSnapshot.data() ;
      if(( object is Map ) == false )
        throw "err" ;

      Map map = object as Map ;
      _todayShit = shitName[ int.parse( map['value'].toString()) ];

//      List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs ;


      //    for (final d : querySnapshot.docs)

    }catch( _ ){}
    // try
    // {
    //
    //   int i ;
    //   final TTMPieConditionValue ret = new TTMPieConditionValue() ;
    //   DateTime dateTime = DateTime.now();
    //   String id = "${dateTime.year}-${dateTime.month}" ;
    //
    //   CollectionReference collectionReference = _documentReference!.collection( TTMCondition.DIR ) ;
    //   DocumentReference documentReference = await collectionReference.doc( id );
    //   //  collectionReference.
    //
    //
    //   DocumentReference reference = await documentReference.collection( "${dateTime.day}")
    //       .doc( "data" );
    //   DocumentSnapshot documentSnapshot = await reference.get();
    //   Object? object = await documentSnapshot.data() ;
    //   if(( object is Map ) == false )
    //     throw "err" ;
    //
    //   Map map = object as Map ;
    //   _todayShit = shitName[map['shit']]   ;
    // }catch( e )
    // {
    //
    // }


    //
  }
  String get todayShit => _todayShit ;
  //
//

  // 本日食量
  String _todayFood = "" ;
  Future<void>initTodayFood() async
  {
    Map<String,int> ret = {} ;
    try {
      CollectionReference collectionReference = _documentReference!.collection(
          "food");
      DateTime dateTime = DateTime.now();
      String key = "${dateTime.year}-${dateTime.month}-${dateTime.day}" ;
      DocumentSnapshot documentSnapshot = await collectionReference.doc(key).get();
      Object? object = await documentSnapshot.data() ;
      if(( object is Map ) == false )
        throw "err" ;

      Map map = object as Map ;
      _todayFood = foodName[ int.parse( map['value'].toString()) ];

//      List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs ;


      //    for (final d : querySnapshot.docs)

    }catch( _ ){}


    //
  }
  String get todayFood => _todayFood ;


  //
  //
  // 本日體重
  double _todayWeight = 0 ;
  Future<void>initTodayWeight() async
  {
    try
    {

      int i ;
      final TTMPieConditionValue ret = new TTMPieConditionValue() ;
      DateTime dateTime = DateTime.now();
      String id = "${dateTime.year}-${dateTime.month}" ;

      CollectionReference collectionReference = _documentReference!.collection( TTMCondition.DIR ) ;
      DocumentReference documentReference = await collectionReference.doc( id );
      //  collectionReference.


      DocumentReference reference = await documentReference.collection( "${dateTime.day}")
          .doc( "data" );
      DocumentSnapshot documentSnapshot = await reference.get();
      Object? object = await documentSnapshot.data() ;
      if(( object is Map ) == false )
        throw "err" ;

      Map map = object as Map ;
      _todayWeight = double.parse( map['weight'].toString()  ) ;
    }catch( e )
    {

    }

  }
  double get todayWeight => _todayWeight ;

  //
  //
  // 本日活動量
  String _todayActivity = "" ;
  Future<void>initTodayActivity() async
  {
    Map<String,int> ret = {} ;
    try {
      CollectionReference collectionReference = _documentReference!.collection(
          "activity");
      DateTime dateTime = DateTime.now();
      String key = "${dateTime.year}-${dateTime.month}-${dateTime.day}" ;
      DocumentSnapshot documentSnapshot = await collectionReference.doc(key).get();
      Object? object = await documentSnapshot.data() ;
      if(( object is Map ) == false )
        throw "err" ;

      Map map = object as Map ;
      _todayActivity = activityName[ int.parse( map['value'].toString()) ];

//      List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs ;


      //    for (final d : querySnapshot.docs)

    }catch( _ ){}


    //
  }

  String get todayActivity => _todayActivity ;

  //
  // 取得索引
  int get todayFoodIndex => foodName.indexOf( _todayFood );
  int get todayShitIndex => shitName.indexOf( _todayShit );
  int get todayActivityIndex => activityName.indexOf( _todayActivity );
}

