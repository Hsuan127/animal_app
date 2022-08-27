// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class GetUserData extends StatelessWidget {
//   final String documentID;
//
//   GetUserData({required this.documentID});
//
//   @override
//   Widget build(BuildContext context){
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//     return FutureBuilder<DocumentSnapshot>(
//       builder: ((context, snapshot){
//         if(snapshot.connectionState == ConnectionState.done){
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return
//         }
//     }
//       ),
//     );
//
//
//   }

//}