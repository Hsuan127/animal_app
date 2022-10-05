import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DietRecord extends StatefulWidget{
  const DietRecord({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //createState方法會回傳一個state組件
    return _DietRecordState();
    //上述的組件就是這個
  }
}
class _DietRecordState extends State<DietRecord> {

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
      appBar: AppBar(title: const Text('飲食狀況'),),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('輸入本日飲食狀況', style: TextStyle(fontSize: 24),),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomRadioButton("正常", 1),
                CustomRadioButton("偏少", 2),
                CustomRadioButton("偏多", 3)
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
                  //backgroundColor: Colors.amber,
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