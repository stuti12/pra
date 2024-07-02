import 'package:test_stuti/new_home/model/product_response.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), "products_db");
    _database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await createTable(db, 'product', [
        'id INTEGER PRIMARY KEY',
        'thumbnail TEXT',
        'title TEXT',
        'description TEXT',
        'price INTEGER',
        'rating REAL',
        'stock INTEGER',
        'brand TEXT',
        'category TEXT',
      ]);
    });
    return _database!;
  }

  Future<void> createTable(
      Database db, String tableName, List<String> columns) async {
    final columnsString = columns.join(', ');
    final createTableQuery = 'CREATE TABLE $tableName($columnsString)';
    await db.execute(createTableQuery);
  }

  Future<void> insertData(
      {required String tableName, required Product data}) async {
    try {
      await _database?.insert(tableName, data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw Exception('Error inserting data');
    }
  }

  Future<List<Product>> getProducts() async {
    final List<Map<String, Object?>>? result =
        await _database?.query('product');
    if (result == null || result.isEmpty) {
      return [];
    }
    return result.map((map) => Product.fromJson(map)).toList();
  }

  Future<void> updateData(
      {required String tableName,
      required Product data,
      required int id}) async {
    try {
      await _database
          ?.update(tableName, data.toMap(), where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Error updating data');
    }
  }
}
