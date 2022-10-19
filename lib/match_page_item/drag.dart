import 'package:flutter/material.dart';
import 'package:animal_app/match_page_item/animal.dart';

//Drag左右滑功能
class Drag extends StatefulWidget {
  final Animal animal;
  const Drag({Key ? key, required this.animal}) : super(key: key);

  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.amber[200],
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 動物的image
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 432,
              height: 405,
              child: widget.animal.animalImage(widget.animal.album),
            ),
          ),
          // 下面的框框
          Positioned(
            left: 68,
            top: 405,
            child: Container(
                width: 296,
                height: 145,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(11)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    // color: Color(0xffffffff)
                    color: Colors.amber[200]
                )),
          ),
          // 動物的variety
          Positioned(
            left: 100,
            top: 410,
            child: Container(
              width: 100,
              height: 100,
              child: Text(widget.animal.variety,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                      fontSize: 20.1),
                  textAlign: TextAlign.left),
            ),
          ),
          // 動物的sex, color, bodtytype, kind, shelter_name
          Positioned(
            left: 100,
            top: 445,
            child: Container(
              width: 250,
              height: 100,
              child: Text(widget.animal.changeSexName(widget.animal.sex) + "\n" + widget.animal.colour + "\n" + widget.animal.changeBodytypeName(widget.animal.bodytype) + widget.animal.kind + "\n" + widget.animal.shelterName,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.9),
                  textAlign: TextAlign.left),
            ),
          ),
        ],
      ),
    );
  }
}