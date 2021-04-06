import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:movil/src/models/scan_model.dart';
export 'package:movil/src/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'electronic_ivoice.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans('
          'id INTEGER PRIMARY KEY,'
          'NumFac TEXT,'
          'FecFac TEXT,'
          'HorFac TIME,'
          'NitFac TEXT,'
          'DocAdq TEXT,'
          'ValFac DOUBLE,'
          'ValIva DOUBLE,'
          'ValOtroIm DOUBLE,'
          'ValTolFac DOUBLE,'
          'CUFE LONGTEXT,'
          'QRCode LONGTEXT'
          ')');
    });
  }

  newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  Future<ScanModel> getScanNumFac(String numFac) async {
    final db = await database;
    final res = await db.query('Scans', where: 'NumFac=?', whereArgs: [numFac]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getScansByType(String nitFac) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE NitFac='$nitFac'");
    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(),
        where: 'id=?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }
}
