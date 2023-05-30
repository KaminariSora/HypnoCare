import 'dart:io';
import 'package:project/model/Mbmi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DbBmi {
  String dbnum;

  DbBmi({required this.dbnum});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbnum);

    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<String> getLatestMess() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var finder = Finder(sortOrders: [
      SortOrder(Field.key, false)
    ], limit: 1);
    var recordSnapshots = await store.find(db, finder: finder);

    if (recordSnapshots.isNotEmpty) {
      var latestRecord = recordSnapshots.first;
      var mess = latestRecord['mess'] as String;
      return '$mess';
    }

    return '';
  }

  Future<int> InsertData(Mbmi statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    var keyID = store.add(db, {
      "mess": statement.mess,
      "nbmi": statement.nbmi,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  Future<List<Mbmi>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [
          SortOrder(Field.key, false)
        ]));
    List<Mbmi> mobmiList = [];
    for (var record in snapshot) {
      mobmiList.add(
        Mbmi(
          mess: record["mess"] as String,
          nbmi: record["nbmi"] as double,
          date: DateTime.parse(record["date"] as String),
        ),
      );
    }
    return mobmiList;
  }
}
