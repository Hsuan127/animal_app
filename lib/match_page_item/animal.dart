import 'package:flutter/material.dart';

//動物的資訊
class Animal {
  int id;
  String album, variety, age, sex, colour, bodytype, shelterName, kind;

  Animal(this.id, this.album, this.variety, this.age, this.sex, this.colour, this.bodytype, this.shelterName, this.kind);

  //動物的圖片
  animalImage(String album) {
    if (album != '') {
      return Image.network(album);
    } else {
      return null;
    }
  }

  //轉換名稱(animal_sex)
  changeSexName(text) {
    //animal_sex
    switch (text) {
      case "M":
        sex = "公";
        break;
      case "F":
        sex = "母";
        break;
      case "N":
        sex = "";
        break;
    }
    return sex;
  }

  // 轉換名稱(animal_bodytype)
  changeBodytypeName(text) {
    switch(text) {
      case "SMALL":
        bodytype = "小型";
        break;
      case "MEDIUM":
        bodytype = "中型";
        break;
      case "BIG":
        bodytype = "大型";
        break;
    }
    return bodytype;
  }
}