import 'package:flutter/material.dart';
import 'package:animal_app/record_page_item/add_expense.dart';

class ExpenseCard extends StatelessWidget{
  final String balance;

  ExpenseCard({required this.balance});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
            children: <Widget>[
              Container(
                height: 150,
                width: 300,
                child: Center(
                  child: Text(
                    balance,
                    style: TextStyle(fontFamily: 'Inter', color: Colors.amber[700], fontSize: 40, fontWeight: FontWeight.w700,)
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          offset: Offset(2, 2),
                          blurRadius: 6.0,
                          spreadRadius: 0),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2.0, -2.0),
                          blurRadius: 6.0,
                          spreadRadius: 0),
                    ]),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: FloatingActionButton(
                  mini: true,
                    heroTag: "uniqueTag",
                    child: const Icon(Icons.add),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddExpense(),
                          ));
                    }
                ),
              ),
            ],

      ),

    );
  }


}

class SpendRecords {
  String? category;
  int? spend;
  String? date; // should be Datetime
  DateTime? created;
  String? note;

  SpendRecords();

  Map<String, dynamic> toJson() => {
    'Category': category,
    'Spend': spend,
    'Date': date,
    'Created Date': created,
    'Notes': note
  };

  SpendRecords.fromSnapshot(snapshot)
      : category = snapshot.data()['Category'],
        spend = snapshot.data()['Spend'],
        date = snapshot.data()['Date'],
        created = snapshot.data()['Created Date'].toDate(),
        note = snapshot.data()['Notes'];
}
