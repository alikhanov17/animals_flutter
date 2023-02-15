import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'add_animal.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    initFirebase();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Animals"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("animals").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("Add Animal");
          } else {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom:10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(

                        title: Text(
                          snapshot.data?.docs[index].get("name"),
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          snapshot.data?.docs[index].get("description"),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ));
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAnimal()),
          );
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
