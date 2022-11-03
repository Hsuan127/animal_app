
class TTMSpendRecords {
  final String category;
  final int spend;
  final String date; // should be Datetime
  final DateTime created;
  final String note;
  final DateTime targetDate ;
  final int dailyIndex ;


  static const String DIR = "Spend" ;


  TTMSpendRecords(  String this.category,
      int this.spend,
      String this.date, // should be Datetime
      DateTime this.created,
      String this.note ,
      int this.dailyIndex ):
        targetDate = DateTime.parse(date)
  ;

  Map<String, dynamic> toJson() => {
    'Category': category,
    'Spend': spend,
    'Date': date,
    'Created Date': created,
    'Notes': note,
    'dailyIndex' : dailyIndex
  };

  TTMSpendRecords.fromSnapshot(snapshot)
      : category = snapshot['Category'],
        spend = snapshot['Spend'],
        date = snapshot['Date'],
        created = snapshot['Created Date'].toDate(),
        note = snapshot['Notes'] ,
        targetDate = DateTime.parse(snapshot['Date']),
        dailyIndex = ( snapshot['dailyIndex'] != null ) ? snapshot['dailyIndex'] : 0

  ;

  bool checkYYMM(DateTime dateTime)
  {
    DateTime thisData = targetDate;
    if( thisData.year == dateTime.year )
      return thisData.month == dateTime.month ;
    return false ;
  }

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
}
