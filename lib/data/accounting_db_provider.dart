import 'dart:async';

import 'package:accountingmultiplatform/data/serializers/serializers.dart';
import 'package:accountingmultiplatform/data/total_expenses.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_grouping_tag.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_month.dart';
import 'package:built_collection/built_collection.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<BuiltList<Accounting>> queryPreviousAccounting(
      DateTime lastDate, int limit) async {
    final db = await getDB();
    var result = await db.rawQuery(
        "SELECT * FROM $_tableName "
        "WHERE createTime <= ? "
        "ORDER BY createTime "
        "DESC LIMIT ?",
        [lastDate.millisecondsSinceEpoch, limit]);

    return deserializeListOf<Accounting>(result);
  }

  Future<Null> insertAccounting(Accounting accounting) async {
    final db = await getDB();

    await db.rawInsert("""
    INSERT OR REPLACE INTO 
      `accounting`(`id`,`amount`,`createTime`,`tag_name`,`remarks`) 
    VALUES (nullif(?, 0),?,?,?,?)
    """, [
      accounting.id,
      accounting.amount,
      accounting.createTime.millisecondsSinceEpoch,
      accounting.tagName,
      accounting.remarks
    ]);
  }

  Future<Null> deleteAccountingById(int id) async {
    final db = await getDB();
    await db.rawDelete("""
        DELETE FROM accounting WHERE id = ?
    """, [id]);
  }

  Future<Accounting> getAccountingById(int id) async {
    final db = await getDB();
    var result =
        await db.rawQuery("SELECT * FROM accounting WHERE id = ?", [id]);

    return deserializeListOf<Accounting>(result).first;
  }

  Future<double> totalExpensesOfDay(int millisecondsSinceEpoch) async {
    final db = await getDB();
    var timeInMillis = (millisecondsSinceEpoch ~/ 1000).toInt();
    var result = await db.rawQuery("""
      SELECT SUM(amount) total
        FROM accounting
        WHERE datetime(createTime / 1000, 'unixepoch')
        BETWEEN datetime(?, 'unixepoch')
        AND datetime(? + 60 * 60 * 24, 'unixepoch')
    """, [timeInMillis, timeInMillis]);

    return deserializeListOf<TotalExpenses>(result).first.total;
  }

  Future<BuiltList<TotalExpensesOfMonth>> getMonthTotalAmount(
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

    return deserializeListOf<TotalExpensesOfMonth>(result);
  }

  Future<BuiltList<TotalExpensesOfGroupingTag>>
      getGroupingTagOfLatestMonth() async {
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

    return deserializeListOf<TotalExpensesOfGroupingTag>(result);
  }

  Future<BuiltList<TotalExpensesOfGroupingTag>> getGroupingMonthTotalAmount(
      String year, String month) async {
    final db = await getDB();
    var result = await db.rawQuery("""
    SELECT SUM(amount) as total, tag_name
    FROM accounting
    WHERE strftime('%Y', createTime / 1000, 'unixepoch') = ?
      AND  strftime('%m', createTime / 1000, 'unixepoch') = ?
    GROUP BY tag_name
    """, [year, month]);

    return deserializeListOf<TotalExpensesOfGroupingTag>(result);
  }
}
