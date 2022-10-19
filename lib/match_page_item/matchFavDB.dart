import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchFavDB {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  List<int> animalList = []; //存動物id

  //查詢資料庫裡的所有動物，然後全部加到animalList裡
  Future getAnimalId() async {
    List<int> animalListNew = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite animals')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              animalListNew.add(document.data()['id']);
            }));
    animalList.clear();
    animalList.addAll(animalListNew);
    print(animalList);
  }

  //新增特定的動物至資料庫
  Future addAnimalId(int animalId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite animals')
        .doc(animalId.toString())
        .set({'id': animalId});
  }

  //刪除資料庫內特定的動物
  Future deleteAnimalId(int animalId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite animals')
        .doc(animalId.toString())
        .delete();
  }

}
