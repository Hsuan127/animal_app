import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityRecord extends StatefulWidget{
  const ActivityRecord({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //createState方法會回傳一個state組件
    return _ActivityRecordState();
    //上述的組件就是這個
  }
}
class _ActivityRecordState extends State<ActivityRecord> {

  int value = 0;
  Widget CustomRadioButton(String text, int index) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              value = index;
            });
          },
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: (value == index) ? Colors.white : Colors.black,
              fontSize: 20,
            ),
          )
      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('活動量'),),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('輸入本日活動量', style: TextStyle(fontSize: 24),),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomRadioButton("高", 1),
                CustomRadioButton("中", 2),
                CustomRadioButton("低", 3)

              ],

            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
             //     backgroundColor: Colors.amber,
                  //foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('送出'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('歷史資料', style: TextStyle(fontSize: 22),),
            ),

          ],
        ),
      ),
    );
  }
}