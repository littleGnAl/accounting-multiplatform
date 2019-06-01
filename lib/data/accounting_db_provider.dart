import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

import 'accounting.dart';

class AccountingDBProvider {
  static final AccountingDBProvider db = AccountingDBProvider._();

  static Database _dataBase;

  static final String _tableName = "accounting";

  AccountingDBProvider._();

  Future<Database> getDB() async {
    if (_dataBase != null) {
      return _dataBase;
    }

    _dataBase = await _initDB();
    return _dataBase;
  }

  _initDB() async {
    var dbName = "accounting-db";
    var dbPath = await getDatabasesPath();
    var p = join(dbPath, dbName);

    return await openDatabase(p, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(""
          "CREATE TABLE IF NOT EXISTS `accounting` ("
          "`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "`amount` REAL NOT NULL, "
          "`createTime` INTEGER NOT NULL, "
          "`tag_name` TEXT NOT NULL, "
          "`remarks` TEXT"
          ")");
    });
  }

  Future<List<Accounting>> queryPreviousAccounting(
      DateTime lastDate, int limit) async {
    final db = await getDB();
    var result = await db.rawQuery(
        "SELECT * FROM $_tableName "
        "WHERE createTime <= ? "
        "ORDER BY createTime "
        "DESC LIMIT ?",
        [lastDate.millisecondsSinceEpoch, limit]);

    return result.isNotEmpty
        ? result.map((a) => Accounting.fromMap(a)).toList()
        : null;
  }

  insertAccounting(Accounting accounting) async {
    final db = await getDB();
    if (accounting.id != 0) {
      await db.update(_tableName, accounting.toJson());
    } else {
      await db.rawInsert("""
        INSERT INTO $_tableName (amount, createTime, tag_name, remarks)
          VALUES (?, ?, ?, ?)
        """, accounting.toInsertArgs());
    }
  }

  Future<Null> deleteAccountingById(int id) async {
    final db = await getDB();
    var result = await db.rawDelete("""
        DELETE FROM accounting WHERE id = ?
    """, [id]);
  }

  Future<Accounting> getAccountingById(int id) async {
    final db = await getDB();
    var result =
        await db.rawQuery("SELECT * FROM accounting WHERE id = ?", [id]);
    return result.isNotEmpty
        ? result.map((a) => Accounting.fromMap(a)).first
        : null;
  }

  Future<double> totalExpensesOfDay(int millisecondsSinceEpoch) async {
    final db = await getDB();
    var timeInMillis = (millisecondsSinceEpoch ~/ 1000).toInt();
    var result = await db.rawQuery("""
      SELECT SUM(amount)
        FROM accounting
        WHERE datetime(createTime / 1000, 'unixepoch')
        BETWEEN datetime(?, 'unixepoch')
        AND datetime(? + 60 * 60 * 24, 'unixepoch')
    """, [timeInMillis, timeInMillis]);

    return result[0]["SUM(amount)"];
  }

  Future<List<Tuple2<String, double>>> getMonthTotalAmount(
      {int limit = 6}) async {
    final db = await getDB();
    var result = await db.rawQuery("""
    SELECT strftime('%Y-%m', createTime / 1000, 'unixepoch') year_month, 
        SUM(amount) total
      FROM accounting
      GROUP BY year_month
      ORDER BY year_month DESC
      LIMIT ?
    """, [limit]);

    return result.isNotEmpty
        ? result
            .map((r) => Tuple2<String, double>(r["year_month"], r["total"]))
            .toList()
        : null;
  }

  Future<List<Tuple2<String, double>>> getGroupingTagOfLatestMonth() async {
    final db = await getDB();
    var result = await db.rawQuery("""
      SELECT SUM(amount) as total, tag_name, (SELECT createTime
        FROM accounting
        ORDER BY createTime
        LIMIT 1) lastTime
      FROM accounting
      WHERE strftime('%Y', createTime / 1000, 'unixepoch') =
        strftime('%Y', lastTime / 1000, 'unixepoch') AND
        strftime('%m', createTime / 1000, 'unixepoch') =
          strftime('%m', lastTime / 1000, 'unixepoch')
      GROUP BY tag_name
      """);

    return result.isNotEmpty
        ? result
            .map((r) => Tuple2<String, double>(r["tag_name"], r["total"]))
            .toList()
        : null;
  }

  Future<List<Tuple2<String, double>>> getGroupingMonthTotalAmount(
      String year, String month) async {
    final db = await getDB();
    var result = await db.rawQuery("""
    SELECT SUM(amount) as total, tag_name
    FROM accounting
    WHERE strftime('%Y', createTime / 1000, 'unixepoch') = ?
      AND  strftime('%m', createTime / 1000, 'unixepoch') = ?
    GROUP BY tag_name
    """, [year, month]);

    return result.isNotEmpty
        ? result
            .map((r) => Tuple2<String, double>(r["tag_name"], r["total"]))
            .toList()
        : null;
  }
}
