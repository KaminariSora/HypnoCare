import 'package:project/db/dbbmi_db.dart';
import 'package:project/model/Mbmi.dart';
import 'package:flutter/foundation.dart';

class BmiProvider with ChangeNotifier {
  List<Mbmi> mobmi = [];

  get date => null;

  //ดึงข้อมูล
  List<Mbmi> getMbmi() {
    return mobmi;
  }

  void initData() async {
    var db = DbBmi(dbnum: "mombi.db");
    mobmi = await db.loadAllData();
    notifyListeners();
  }

  void addMbmi(Mbmi statement) async {
    var db = DbBmi(dbnum: "mombi.db");
    await db.InsertData(statement);

    mobmi = await db.loadAllData();
    notifyListeners();
  }
}
