import 'package:flutter/material.dart';

//動物的資訊
class Animal {
  int id;
  String subid;
  int areaId;
  String kind,
      variety,
      sex,
      bodytype,
      colour,
      age,
      sterilization,
      bacterin,
      foundplace,
      remark,
      shelterName,
      album,
      cDate,
      shelterAddress,
      shelterTel;

  Animal(this.id, //動物id
      this.subid, //收容編號
      this.areaId, //縣市
      this.kind, //種類
      this.variety, //品種
      this.sex, //性別
      this.bodytype, //體型
      this.colour, //毛色
      this.age, //年紀
      this.sterilization, //絕育
      this.bacterin, //狂犬疫苗
      this.foundplace, //尋獲地
      this.remark, //備註
      this.shelterName, //收容所名稱
      this.album, //動物圖片
      this.cDate, //資料更新時間
      this.shelterAddress, //收容所地址
      this.shelterTel //收容所電話
  );

  //動物的圖片
  animalImage(String album) {
    if (album != '') {
      return Image.network(album);
    } else {
      return null;
    }
  }

  //轉換名稱(animal_area_pkid)
  changeAreaName(text) {
    String area = "";
    switch (text) {
      case 2:
        area = "台北";
        break;
      case 3:
        area = "新北";
        break;
      case 4:
        area = "基隆";
        break;
      case 5:
        area = "宜蘭";
        break;
      case 6:
        area = "桃園";
        break;
      case 7:
        area = "新竹縣";
        break;
      case 8:
        area = "新竹市";
        break;
      case 9:
        area = "苗栗";
        break;
      case 10:
        area = "台中";
        break;
      case 11:
        area = "彰化";
        break;
      case 12:
        area = "南投";
        break;
      case 13:
        area = "雲林";
        break;
      case 14:
        area = "嘉義縣";
        break;
      case 15:
        area = "嘉義市";
        break;
      case 16:
        area = "台南";
        break;
      case 17:
        area = "高雄";
        break;
      case 18:
        area = "屏東";
        break;
      case 19:
        area = "花蓮";
        break;
      case 20:
        area = "台東";
        break;
      case 21:
        area = "澎湖";
        break;
      case 22:
        area = "金門";
        break;
      case 23:
        area = "連江";
        break;
    }
    return area;
  }

  //轉換名稱(animal_sex)
  changeSexName(text) {
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

  //轉換名稱(animal_bodytype)
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

  //轉換名稱(animal_age)
  changeAgeName(text) {
    switch(text) {
      case "CHILD":
        age = "幼年";
        break;
      case "ADULT":
        age = "成年";
        break;
      case "":
        age = "不詳";
        break;
    }
    return age;
  }

  //轉換名稱(animal_sterilization)
  changeSterilizationName(text) {
    switch(text) {
      case "T":
        sterilization = "是";
        break;
      case "F":
        sterilization = "否";
        break;
      case "N":
        sterilization = "不詳";
        break;
    }
    return sterilization;
  }

  //轉換名稱(animal_bacterin)
  changeBacterinName(text) {
    switch(text) {
      case "T":
        bacterin = "已施打";
        break;
      case "F":
        bacterin = "未施打";
        break;
      case "N":
        bacterin = "不詳";
        break;
    }
    return bacterin;
  }

}