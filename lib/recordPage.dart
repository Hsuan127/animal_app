import 'package:flutter/material.dart';
import 'package:animal_app/record_page_item/expense_card.dart';
import 'package:animal_app/record_page_item/estimate_card.dart';
import 'package:animal_app/record_page_item/health_condition.dart';


class RecordPage extends StatefulWidget {
  int selectedIndex=0;//will highlight first item
  List<String> myList=['1','2','3','4'];
  RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>{
  int? _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紀錄'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: 40,
            //   child: ListView.separated(
            //       scrollDirection: Axis.horizontal,
            //       physics: BouncingScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: 1,
            //       itemBuilder: (context, index) => Container(
            //         // padding: EdgeInsets.all(12.0),
            //         // child: Container(
            //         //   height: 40,
            //         //   color: Colors.white,
            //         child: ListView(
            //           scrollDirection: Axis.horizontal,
            //           shrinkWrap: true,
            //           children: widgets,
            //         ),
            //       ),
            //       separatorBuilder: (context, index) => SizedBox(width: 12,
            //       )
            //   ),
            // ),
            SizedBox(
              height: 40, // play with height
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 20,),
                itemCount: 3, //number of item you like show
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color:
                          _selectedIndex == index ? Colors.amber : Colors.grey[400],
                        ),
                        child: Text("$index"),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 40,
              thickness: 2,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text('總花費',
                    style: TextStyle(fontSize: 20,)
                ),
              ),
            ),
            ExpenseCard(
              balance: "\$ 10,000",
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text('下個月預計花費',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)
                  ),
                ),
            ),
            SizedBox(
              height: 10,
            ),

            ExpectCard(
                expectation: "\$ 8,000"
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text('健康狀態',
                    style: TextStyle(fontSize: 20,)
                ),
              ),
            ),
            HealthCondition(),

          ],
        ),
      ),
    );



  }
}