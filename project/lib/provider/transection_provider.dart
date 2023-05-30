import 'package:flutter/foundation.dart';
import 'package:project/database/transection_db.dart';
import 'package:project/models/transections.dart';

class TransectionProvider with ChangeNotifier {
  List<transections> transection = [];

  List<transections> getTransection() {
    return transection;
  }

  void initData() async {
    var db = TransectionDB(dbName: "Dietdb.db");
    //ดึงข้อมูลมาแสดงผล
    transection = await db.loadAllData();
    notifyListeners();
  }

  void addTransection(transections statement) async {
    var db = TransectionDB(dbName: "Dietdb.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    print("addTransection");
    //ดึงข้อมูลมาแสดงผล
    transection = await db.loadAllData();
    //transection.insert(0,statement);

    //แจ้งเตือน consumer
    notifyListeners();
  }
}
