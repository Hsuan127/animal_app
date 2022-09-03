import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  List<String> _animallist = []; //1 build a list to store random id
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: MyCustomForm()
        //Text('Past Hospital Records'),
      ),
      body: Container(
        child: FutureBuilder(
            future: getAnimalId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: _animallist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GetAnimalId(
                        documentId: _animallist[index],
                      ),
                    );
                  });
            }),
      ),
    );
  }

  // 2 get those random id(doc)
  Future getAnimalId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite animals')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
      //print(document.reference);
      _animallist.add(document.reference.id);
    }));
  }
}

// 3 get those real id from random id(doc)
class GetAnimalId extends StatelessWidget {
  final String documentId;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  GetAnimalId({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // get the collection of animal id
    CollectionReference animal = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite animals');

    return FutureBuilder<DocumentSnapshot>(
        future: animal.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              'ID : ${data['id']}',
            );
          }
          return Text('loading...');
        }));
  }
}

//4 I tried to be concise but fail and this is the best way for me to add data into database
class AnimalIdRecords {
  int? id;

  AnimalIdRecords();

  Map<String, dynamic> toJson() => {
    'id': id,
  };
}

class MyCustomForm extends StatefulWidget {
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _fromKey = GlobalKey<FormState>();

  TextEditingController _animalId = TextEditingController();

  AnimalIdRecords animalIdRecord = AnimalIdRecords();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.pets_outlined),
                    labelText: 'Animal ID',
                  ),
                  onChanged: (value) {
                    _animalId.text = value;
                    animalIdRecord.id = int.parse(_animalId.text);
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Type Something';
                    }
                    return null;
                  },
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_fromKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Save Your Record Successfully'),
                          ),
                        );
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('favorite animals')
                            .add(animalIdRecord.toJson());
                      }
                      _animalId.clear();
                    },
                    child: Text('Submit'),
                  ),
                ),
              ]),
        ));
  }
}