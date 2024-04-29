import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String count = '0';
  @override
  void initState() {
      var db = FirebaseDatabase.instance.ref().child('count');
      db.onValue.listen((event) {
        setState(() {
          count = event.snapshot.value.toString();
        });
      });
    super.initState();
  }

  final Future<FirebaseApp> fapp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Real time count : $count"),
        ),
      ),
    );
  }
}
