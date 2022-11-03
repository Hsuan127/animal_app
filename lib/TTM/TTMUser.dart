
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TTMItem.dart';

class TTMUser
{
  final List<TTMItem> _buf = [] ;
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //
  //
  static final String _DIR = "ttm" ;

  static final String _PET = "my_pet" ;
  //
  //
  Future<CollectionReference> _pet() async
  {
    User ?user = _auth.currentUser ;
    if( user == null )
      throw "沒有登入" ;
    //
    //  Firebase.in
    final CollectionReference collection =
    FirebaseFirestore.instance.collection('$_DIR');
    DocumentReference doc = collection.doc( "${user.uid}" );
    return  doc.collection( _PET );

  }
  //
  //
  void signOut()
  {
    _buf.clear();
  }
  //
  Future<String> readData() async
  {
    //
    try
    {
      final CollectionReference collection = await _pet();
      QuerySnapshot querySnapshot = await collection.get();

      _buf.clear();
      for( QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs )
      {
        try{
          _buf.add( await TTMItem.init( queryDocumentSnapshot ));
        }catch( e )
        {
        }
      }


      return "" ;
    }catch( e )
    {
      return e.toString();
    }

  }

  //
  // add

  Future<String> addData( TTMItem item ) async
  {

    //
    try
    {
      final CollectionReference collection = await _pet();
      DocumentReference reference = await collection.add( item.toMap());

      _buf.add( TTMItem( reference , reference.id , item.name , item.money ));

      return "" ;
    }catch( e )
    {
      return e.toString();
    }


  }

  List<String> bufList()
  {
    List<String> ret = [] ;
    for( final TTMItem item in _buf ) {
      ret.add( item.name );
    }
    return ret ;
  }

  TTMItem getAt(int selectedIndex) {
    if( selectedIndex >= _buf.length )
      throw "not this index: $selectedIndex " ;
    return _buf[selectedIndex] ;
  }

  //
  // 登入
  Future<String> onLogin( final String user , final String pass )async
  {
    try
    {
      UserCredential ret = await _auth.signInWithEmailAndPassword( email : user , password: pass );
      if( ret.user == null )
        throw "Login error: $user " ;
      return "" ;
    }catch( e )
    {
      return e.toString();
    }
    return "" ;
  }

  Future<String> onRegister( final String user , final String pass )async
  {
    try
    {
      UserCredential ret = await _auth.createUserWithEmailAndPassword( email : user , password: pass );
      if( ret.user == null )
        throw "Register error: $user " ;
      return "" ;
    }catch( e )
    {
      throw e.toString();
    }
    return "" ;
  }

  // 移掉
  Future<String> removePie( TTMItem item ) async
  {
    try{
      _buf.remove( item );
      await item.remove();
      return "" ;
    }catch( e )
    {
      return e.toString();
    }
  }

}