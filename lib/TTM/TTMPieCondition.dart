
class TTMPieConditionItem
{
  final DateTime dateTime = DateTime.now();
  final int type ;
  final String data ;

  TTMPieConditionItem( this.type , this.data );

}

class TTMPieCondition
{

  final List<TTMPieConditionItem> _buf = [] ;

  List<TTMPieConditionItem> getDatas(int type)
  {
    final  List<TTMPieConditionItem> ret = [] ;
    for( TTMPieConditionItem d in _buf )
      if( type == d.type )
      {
        ret.add( d );
      }
    return ret ;
  }

}


class TTMPieConditionValue
{
   final Map<String,dynamic> _map = {} ;

   void add( String key , dynamic value )
   {
      if( _map[key] == null )
        _map[key] = value ;
      else
        _map[key] = _map[key]! + value ;
   }

   List<dynamic> toValues()
   {
     List<dynamic> ret = [] ;
     for( String key in _map.keys )
       ret.add( _map[key]! );
     return ret ;
   }

   List<double> toDoubleValues()
   {
     List<double> ret = [] ;
     for( String key in _map.keys )
     {
       try
       {
         String str =  _map[key].toString() ;
         ret.add( double.parse( str) );
       }catch(_)
     {
       ret.add( 0 );
     }
     }
     return ret ;
   }
   List<String> toKeys()
   {
     List<String> ret = [] ;
     for( String key in _map.keys )
       ret.add( key );
     return ret ;
   }
   //
   // 日期
   List<int> toDay()
   {
     List<int> ret = [];
     for (String key in _map.keys) {
       try {
         List data = key.split('-');
         ret.add( int.parse(data[2]));
       } catch (e) {

       }
     }
     return ret;
   }
}