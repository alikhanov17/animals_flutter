import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAnimal extends StatefulWidget {
  const AddAnimal({Key? key}) : super(key: key);

  @override
  State<AddAnimal> createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  String _name = "";
  String _description = "";
  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
initFirebase();
    return Scaffold(
      body: AlertDialog(
        scrollable: true,
        title: const Text(
          'Add Animal',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
        content: SizedBox(
          height: height * 0.35,
          width: width,
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (newValue) =>
                    _name = newValue,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Name',
                    hintStyle: const TextStyle(fontSize: 14),
                    icon: const Icon(CupertinoIcons.square_list,
                        color: Colors.brown),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onChanged: (newValue) =>
                    _description = newValue,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Description',
                    hintStyle: const TextStyle(fontSize: 14),
                    icon: const Icon(CupertinoIcons.bubble_left_bubble_right,
                        color: Colors.brown),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
            onPressed: () {
              setState(() {
                FirebaseFirestore.instance
                    .collection("animals")
                    .add({"name": _name,"description":_description});
              });
              Navigator.pop(context);

            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
