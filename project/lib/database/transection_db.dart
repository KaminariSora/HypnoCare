import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../models/transections.dart';

class TransectionDB {
  //บริการเกี่ยวกับฐานข้อมูล

  String dbName; //เก็บชื่อฐานข้อมูล

  //ถ้ายังไม่ถูกสร้าง => สร้าง
  //ถูกสร้างไว้แล้ว => เปิด
  TransectionDB({required this.dbName});

  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }
    Future<String> getStatusDiet() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var finder = Finder(sortOrders: [
      SortOrder(Field.key, false)
    ], limit: 1);
    var recordSnapshots = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

    if (recordSnapshots.isNotEmpty) {
      var latestRecord = recordSnapshots.first;
      var status = latestRecord['status'] as String;
      return '$status';
    }

    return '';
  }

  //บันทึกข้อมูล
  Future<int> InsertData(transections statement) async {
    //ฐานข้อมูล => Store
    //Transection.db => expense
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "dataMeat": statement.dataMeat,
      "dataRice": statement.dataRice,
      "dataVeget": statement.dataVeget,
      "dataFruit": statement.dataFruit,
      "dataMilk": statement.dataMilk,
      "date": statement.date.toIso8601String(),
      "status": statement.status,
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูล

  //ใหม่ => เก่า false มาก => น้อย
  //เก่า => ใหม่ true น้อย => มาก
  Future<List<transections>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<transections> transectionList = [];
    for (var Record in snapshot) {
      transectionList.add(transections(
          dataMeat: double.parse(Record["dataMeat"].toString()),
          dataRice: double.parse(Record["dataRice"].toString()),
          dataVeget: double.parse(Record["dataVeget"].toString()),
          dataFruit: double.parse(Record["dataFruit"].toString()),
          dataMilk: double.parse(Record["dataMilk"].toString()),
          date: DateTime.parse(Record["date"].toString()),
          status: Record["status"].toString()));
          
      print(snapshot);
    }

    return transectionList;
  }
}
