import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:sqflite/sqflite.dart' as sql;

class PortalEazeSqlService {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      Strings.dbName,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTableHistoryTracking(database);
        await createTableHistoryTransaction(database);
      },
    );
  }

  // TABLE SRE
  static Future<void> createTableHistoryTracking(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS history_tracking (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      id_billing TEXT,
      timestamp_second TEXT
    )""");
  }

  // TABLE IFUA
  static Future<void> createTableHistoryTransaction(
      sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS history_transaction (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      data TEXT
    )""");
  }

  // QUERY TABLE HISTORY TRACKING
  // CREATE HISTORY TRACKING
  Future<Map?> createHistoryTracking(
      {required Map<String, dynamic> data}) async {
    final db = await PortalEazeSqlService.db();
    final id = await sqlRunInsert(
      db: db,
      data: data,
      tableName: 'history_tracking',
    );
    if (id == 0) return {'code': 400};
    return {'code': 200};
  }

  // GET HISTORY TRACKING
  Future<List> getHistoryTracking() async {
    final db = await PortalEazeSqlService.db();
    final data = await sqlRunRead(
      db: db,
      tableName: 'history_tracking',
    );

    if (data.isEmpty) return [];
    return data;
  }

  // DELETE HISTORY TRACKING
  Future deleteHistoryTracking(int id) async {
    final db = await PortalEazeSqlService.db();
    await sqlRunDelete(
      db: db,
      tableName: 'history_tracking',
      id: id,
    );
  }

  // DELETE ALL HISTORY TRACKING
  Future deleteAllHistoryTracking() async {
    final db = await PortalEazeSqlService.db();
    await sqlRunDeleteAllRecord(
      db: db,
      tableName: 'history_tracking',
    );
  }
  // END QUERY TABLE USER

  // QUERY TABLE IFUA
  // CREATE IFUA
  Future<Map?> createIfua({required dynamic json}) async {
    final db = await PortalEazeSqlService.db();
    final data = {'data': json};
    final id = await sqlRunInsert(db: db, data: data, tableName: 'ifua');
    if (id == 0) return {'code': 400};
    return {'code': 200};
  }

  // GET IFUA
  Future<List> getIfua() async {
    final db = await PortalEazeSqlService.db();
    final data = await sqlRunRead(
      db: db,
      tableName: 'ifua',
    );

    if (data.isEmpty) return [];
    return data;
  }

  // DELETE ALL IFUA
  Future deleteAllIfua() async {
    final db = await PortalEazeSqlService.db();
    await sqlRunDeleteAllRecord(
      db: db,
      tableName: 'ifua',
    );
  }
  // END QUERY TABLE IFUA

  // RUN INSERT QUERY
  static Future<int> sqlRunInsert({
    required sql.Database db,
    required Map<String, dynamic> data,
    required String tableName,
  }) async {
    try {
      return await db.insert(
        tableName,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } catch (e) {
      return 0;
    }
  }

  // RUN EDIT QUERY
  static Future<int> sqlRunEdit({
    required sql.Database db,
    required String tableName,
    required Map<String, dynamic> change,
    String? where,
  }) async {
    try {
      var data = await db.update(tableName, change, where: where);
      return data;
    } catch (e) {
      return 0;
    }
  }

  // RUN READ QUERY
  static Future<List<Map<String, dynamic>>> sqlRunRead({
    required sql.Database db,
    required String tableName,
    String? where,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      var data = await db.query(
        tableName,
        where: where,
        orderBy: orderBy,
        offset: offset,
        limit: limit,
      );
      if (data.isEmpty) return [];
      return data;
    } catch (e) {
      return [];
    }
  }

  // RUN DELETE QUERY
  static Future<int> sqlRunDelete({
    required sql.Database db,
    required String tableName,
    required int id,
  }) async {
    try {
      var data = await db.delete(
        tableName,
        where: '"id" = $id',
      );
      return data;
    } catch (e) {
      return 0;
    }
  }

  // RUN DELETE QUERY
  static Future<int> sqlRunDeleteAllRecord({
    required sql.Database db,
    required String tableName,
  }) async {
    try {
      var data = await db.delete(tableName);
      return data;
    } catch (e) {
      return 0;
    }
  }
}
