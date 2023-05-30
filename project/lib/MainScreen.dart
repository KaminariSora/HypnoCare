import 'package:flutter/material.dart';
import 'package:project/database/transection_db.dart';
import 'HomeBox.dart';
import 'Bmi.dart';
import 'Diet.dart';
import 'Sodium.dart';

import 'package:project/db/dbbmi_db.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String latestMess = '', statusDiet = '';

  @override
  void initState() {
    super.initState();
    initializeData();
    print("Call initState......");
  }

  Future<void> initializeData() async {
    DbBmi db = DbBmi(dbnum: 'mombi.db');
    TransectionDB diet = TransectionDB(dbName: "Dietdb.db");
    latestMess = await db.getLatestMess();
    statusDiet = await diet.getStatusDiet();
    setState(() {});
  }

  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HypnoCare",
          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Itim'),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
              Color(0xffeeaeca),
              Color(0xff94bbe9)
            ]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bmi()),
                );
              },
              child: Container(
                child: HomeBox(
                  "Body Mass Index",
                  latestMess,
                  Color(0xffeeaeca).withOpacity(0.75),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Diet()),
                );
              },
              child: Container(
                child: HomeBox("Health Diet", statusDiet, Color(0xff94bbe9).withOpacity(0.75)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SodiumTrackerApp()),
                );
              },
              child: Container(
                child: HomeBox(
                  "Sodium",
                  "",
                  Color(0xffeeaeca).withOpacity(0.75),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
