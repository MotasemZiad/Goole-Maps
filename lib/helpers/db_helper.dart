import 'package:native_features/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  DbHelper._();
  static final dbHelper = DbHelper._();

  Future<Database> databaseConnection() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, dbName),
      version: dbVersion,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE $tableName(
          $tableColumnId TEXT PRIMARY KEY,
          $tableColumnTitle TEXT NOT NULL,
          $tableColumnImage TEXT,
          $tableColumnLocationLatitude REAL,
          $tableColumnLocationLongitude REAL,
          $tableColumnAddress TEXT
        );
        ''');
      },
    );
  }

  Future<void> insert(String tableName, Map<String, Object> data) async {
    final database = await databaseConnection();
    int id = await database.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(id);
  }

  Future<List<Map<String, Object>>> getData(String tableName) async {
    final database = await databaseConnection();
    return database.query(tableName);
  }
}
