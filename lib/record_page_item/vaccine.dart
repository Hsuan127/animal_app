import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:animal_app/record_page_item/add_vaccine.dart';



class VaccinePage extends StatefulWidget {
  //final DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();
  // final String vaccineId;
  //VaccinePage(this.vaccineId);

  @override
  State<StatefulWidget> createState() {
    //createState方法會回傳一個state組件
    return _VaccinePageState();
    //上述的組件就是這個
  }
}
//void createRecord(){
// Map<DateTime, String> record = {
//   "日期": date,
//   "疫苗": vaccineName,
// };
// firebaseDB.child("vaccine_id").child(id).set(record).whenComplete(() {
//   print("finish set");
//   }).catchError((error){
//   print(error);
// });
//   databaseReference.child("1").set({
//     'date': '2021-11-10',
//     'vaccine': '五合一疫苗'
//   });
//   databaseReference.child("2").set({
//       'date': '2022-03-14',
//       'vaccine': '鉤端螺旋體四價疫苗'
//   });
//
//}
// final List<Vaccine> _vaccines = <Vaccine>[];
// final VaccineDataSource _vaccineDataSource = VaccineDataSource();

class Vaccine {
  Vaccine(this.date, this.name);
  final DateTime date;
  final String name;
}

class VaccineDataSource extends DataGridSource {
  VaccineDataSource(this.vaccineData) {
    _buildDataRow();
  }

  List<DataGridRow> _vaccineData = [];
  List<Vaccine> vaccineData;

  void _buildDataRow() {
    _vaccineData = vaccineData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<DateTime>(columnName: '日期', value: e.date),
      DataGridCell<String>(columnName: '疫苗', value: e.name),
    ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _vaccineData;

  @override
  DataGridRowAdapter buildRow(
      DataGridRow row,
      ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
late VaccineDataSource vaccineDataSource;
List<Vaccine> vaccineData = [];
List<String> docID = [];
// late VaccineDataSource vaccineRecord;
// List<Vaccine> vaccineData = [];
class _VaccinePageState extends State<VaccinePage>{

  // final date = DateTime();
  // final name = "";

  Future getDataFromDatabase() async {
    // final String documentId;
    //
    //  await FirebaseFirestore.instance.collection('users').get().then(
    //      (snapshot) => snapshot.docs.forEach(
    //              (document){
    //        print(document.reference);
    //        docID.add(document.reference.id);
    //      }),
    //      );
    //
    //  CollectionReference users = FirebaseFirestore.instance.collection('users');
    //  return users.doc
    // return FutureBuilder<DocumentSnapshot>(
    //   builder: ((context, snapshot){
    //     if(snapshot.connectionState == ConnectionState.done){
    //       Map<String, dynamic> data =
    //       snapshot.data!.data() as Map<String, dynamic>;
    //       return Text()
    //     }
    //   }
    //   ),
    // );
    // var value = FirebaseFirestore.instance
    //     .collection('vaccine_id')
    //     .snapshots()
    //     .map((snapshot) => snapshot.docs.map((doc) => doc.data())).toList();
    var value = FirebaseDatabase.instance.reference();
    var getValue = await value.child('vaccine_id').once();
    return getValue;
  }

  Widget _buildDataGrid() {
    return FutureBuilder(
      future: getDataFromDatabase(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //var showData = snapshot.data;
          Map<String, dynamic> values = snapshot.data!.data() as Map<String, dynamic>;
          List<dynamic> key = values.keys.toList();

          for (int i = 0; i < key.length; i++) {
            final data = values[key[i]];
            vaccineData.add(Vaccine(
                data['日期'],
                data['疫苗']));
          }

          vaccineDataSource = VaccineDataSource(vaccineData);
          return SfDataGrid(
            source: vaccineDataSource,
            columns: <GridColumn>[
              GridColumn(
                  columnName: '日期',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        '日期',
                      ))),
              GridColumn(
                  columnName: '疫苗',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('疫苗'))
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState(){
    super.initState();
    getDataFromDatabase();
  }


  void _navigateToAddVaccineScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddVaccine()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('疫苗施打')),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text('歷史紀錄',
                    style: TextStyle(fontSize: 24)
                ),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 10,
              thickness: 2,
            ),
            Container(
              height: 300,
              width: 100,
              child: _buildDataGrid(),
            ),

            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amber, width: 2),
                  //color: Colors.blueAccent,
                ),
                child: IconButton(
                  iconSize: 25,
                  padding: const EdgeInsets.all(5),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.amber,
                  ),
                  onPressed: (){
                    _navigateToAddVaccineScreen(context);
                    // createRecord();
                  },
                )
            ),





          ],
        ),
      ),

    );
  }

}