import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Condition extends StatelessWidget{
  const Condition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('健康狀態')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeightCard(),
              ShitCard(),
              ActivityCard(),
              DietCard(),
            ],
          ),
        ),
      ),

    );
  }
}

// 體重紀錄
class WeightCard extends StatefulWidget{

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _WeightCardState();
  }
}
class _WeightCardState extends State<WeightCard>{

  @override
  Widget build(BuildContext context){
    return Container(
        width: 320,
        height: 125,
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('體重', style: TextStyle(fontSize: 24,)),
                    TextButton(
                      onPressed: (){},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('8/17', style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600])),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('20kg', style: TextStyle(fontSize: 32,)),
                )

              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,

        ),
    );


  }
}

// 大便狀況紀錄
class ShitCard extends StatefulWidget{

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _ShitCardState();
  }
}
class _ShitCardState extends State<ShitCard>{

  @override
  Widget build(BuildContext context){
    return Container(
      width: 320,
      height: 125,
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('大便狀況', style: TextStyle(fontSize: 24,)),
                  TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('8/17', style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600],)),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text('正常', style: TextStyle(fontSize: 32,)),
              )

            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,

      ),
    );


  }
}

// 活動量紀錄
class ActivityCard extends StatefulWidget{

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _ActivityCardState();
  }
}
class _ActivityCardState extends State<ActivityCard>{

  @override
  Widget build(BuildContext context){
    return Container(
      width: 320,
      height: 125,
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('活動量', style: TextStyle(fontSize: 24,)),
                  TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('8/17', style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600])),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text('高', style: TextStyle(fontSize: 32,)),
              )

            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,

      ),
    );


  }
}

// 飲食狀況紀錄
class DietCard extends StatefulWidget{

  //const WeightCard({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _DietCardState();

  }
}
class _DietCardState extends State<DietCard>{

  @override
  Widget build(BuildContext context){
    return Container(
      width: 320,
      height: 125,
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('飲食狀況', style: TextStyle(fontSize: 24,)),
                  TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('8/17', style: TextStyle(fontSize: 16, fontFamily: 'Inter', color: Colors.grey[600])),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 30,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text('正常', style: TextStyle(fontSize: 32,)),
              )

            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,

      ),
    );


  }
}