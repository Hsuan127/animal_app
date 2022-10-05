import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/services.dart';

class WeightRecord extends StatefulWidget{
  const WeightRecord({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //createState方法會回傳一個state組件
    return _WeightRecordState();
    //上述的組件就是這個
  }
}
class _WeightRecordState extends State<WeightRecord> {
  final _formKey = GlobalKey<FormBuilderState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('體重紀錄'),),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('輸入本日測量體重', style: TextStyle(fontSize: 24),),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: FormBuilderTextField(
                    name: 'weight',
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      hintText: '輸入寵物體重(kg)',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],

                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: Colors.amber,
            //          foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('送出'),
                  ),
                ),

              ],
              
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('歷史資料', style: TextStyle(fontSize: 22),),
            ),
            
            
          ],
      ),
      ),
      ),
    );
  }
}