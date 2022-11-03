import 'package:flutter/material.dart';
import 'package:animal_app/match_page_item/animal.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher_string.dart'; //連結到其他網址或功能

//Drag左右滑功能
class Drag extends StatefulWidget {
  final Animal animal;
  const Drag({Key? key, required this.animal}) : super(key: key);

  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          //動物的image
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQueryData.fromWindow(window).size.width,
              height: (MediaQueryData.fromWindow(window).size.height - 100) / 2,
              child: widget.animal.animalImage(widget.animal.album),
            ),
          ),

          //下面的框框
          Positioned(
            left: MediaQueryData.fromWindow(window).padding.left,
            top: (MediaQueryData.fromWindow(window).size.height - 100) / 2,
            bottom: MediaQueryData.fromWindow(window).padding.bottom,
            child: Container(
                width: MediaQueryData.fromWindow(window).size.width,
                height:
                    (MediaQueryData.fromWindow(window).size.height - 100) / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: Colors.amber[200])),
          ),

          //動物的詳細資訊
          Positioned(
            left: MediaQueryData.fromWindow(window).padding.left + 20,
            top: (MediaQueryData.fromWindow(window).size.height - 100) / 2,
            bottom: MediaQueryData.fromWindow(window).padding.bottom + 20,
            child: Container(
                width: MediaQueryData.fromWindow(window).size.width - 40,
                height: (MediaQueryData.fromWindow(window).size.height - 100) /
                        4 /
                        6 +
                    400,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //第1列
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //品種
                              Text(widget.animal.variety,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                              ),
                              //性別
                              widget.animal.sex != "N"
                                  ? widget.animal.sex == "M"
                                      ? Icon(
                                          Icons.male,
                                          color: Colors.black,
                                        )
                                      : Icon(
                                          Icons.female,
                                          color: Colors.black,
                                        )
                                  : Text("",
                                      style: TextStyle(
                                          fontSize: 24),
                                    ),
                            ],
                          ),
                          //我要認養
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.orange),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.transparent),
                              )),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(8)),
                            ),
                            child: Text(
                              "我要認養",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              launchUrlString(
                                  "https://asms.coa.gov.tw/Amlapp/App/AnnounceList.aspx?Id=${widget.animal.id}&AcceptNum=${widget.animal.subid}&PageType=Adopt",
                                  mode: LaunchMode.externalApplication);
                            },
                          ),
                        ],
                      ),

                      //第2列
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //地區
                          Text(widget.animal.changeAreaName(widget.animal.areaId),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                          ),
                          //時間
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.update,
                                color: Colors.black,
                              ),
                              Text(widget.animal.cDate,
                                  style: TextStyle(
                                      fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),

                      //第3列
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //收容所名稱
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                size: 20,
                                Icons.home,
                                color: Colors.black,
                              ),
                              Text(widget.animal.shelterName,
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontSize: 12),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //地圖
                              IconButton(
                                  icon: Icon(Icons.location_on, color: Colors.orange),
                                  onPressed: (() {
                                    launchUrlString(
                                        "https://www.google.com/maps/search/?api=1&query=${widget.animal.shelterAddress}",
                                        mode: LaunchMode.externalApplication);
                                  })),
                              //電話
                              IconButton(
                                  icon: Icon(Icons.call, color: Colors.orange),
                                  onPressed: (() {
                                    launchUrlString(
                                        "tel:${widget.animal.shelterTel}");
                                  })),
                            ],
                          )
                        ],
                      ),

                      //第4列
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //體型
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Text('體型',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      textAlign: TextAlign.center
                                  ),
                                  Text(
                                      widget.animal
                                          .changeBodytypeName(widget.animal.bodytype),
                                      style: TextStyle(
                                          fontSize: 14),
                                      textAlign: TextAlign.center
                                  ),
                                ],
                              ),
                            ),
                            //年紀
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Text('年紀',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      textAlign: TextAlign.center
                                  ),
                                  Text(widget.animal.changeAgeName(widget.animal.age),
                                      style: TextStyle(
                                          fontSize: 14),
                                      textAlign: TextAlign.center
                                  ),
                                ],
                              ),
                            ),
                            //絕育
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Text('絕育',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      textAlign: TextAlign.center),
                                  Text(
                                      widget.animal.changeSterilizationName(
                                          widget.animal.sterilization),
                                      style: TextStyle(
                                          fontSize: 14),
                                      textAlign: TextAlign.center
                                  ),
                                ],
                              ),
                            ),
                            //狂犬疫苗
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Text('狂犬疫苗',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      textAlign: TextAlign.center
                                  ),
                                  Text(
                                      widget.animal
                                          .changeBacterinName(widget.animal.bacterin),
                                      style: TextStyle(
                                          fontSize: 14),
                                      textAlign: TextAlign.center
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      //第5列
                      //收容編號
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('收容編號： ${widget.animal.subid}',
                            style: const TextStyle(
                                fontSize: 14),
                        ),
                      ),

                      //第6列
                      //尋獲地
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.animal.foundplace != ""
                            ? Text('尋獲地： ${widget.animal.foundplace}',
                                style: const TextStyle(
                                    fontSize: 14),
                              )
                            : Container(),
                      ),

                      //第7列
                      //備註
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.animal.remark != ""
                            ? Text('備註： ${widget.animal.remark}',
                                style: const TextStyle(
                                    fontSize: 14)
                              )
                            : Container(),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
