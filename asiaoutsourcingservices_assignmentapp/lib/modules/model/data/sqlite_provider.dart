import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
      productId TEXT PRIMARY KEY NOT NULL,
      productName TEXT,
      productValue TEXT,
      productSize TEXT,
      quantity INTEGER,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'asiaoutsourcingservicesassignment.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      }
    );
  }

  static Future<int> addItem(Cart item) async {
    final db = await SQLHelper.db();
    return await db.insert(
      'items', 
      item.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.ignore
    );
  }

  static Future<List<Cart>> getItems() async {
    final db = await SQLHelper.db();
    final maps = await db.query('items', orderBy: 'createdAt');
    List<Cart> items = List.generate(maps.length, (index) => Cart(
      productId: maps[index]['productId'].toString(), 
      productName: maps[index]['productName'].toString(), 
      productValue: maps[index]['productValue'].toString(), 
      productSize: maps[index]['productSize'].toString(), 
      quantity: int.parse(maps[index]['quantity'].toString()), 
      createdAt: maps[index]['createdAt'].toString()
    ));

    return items;
  }

  static Future<int> updateItem(String productId, Cart item) async {
    final db = await SQLHelper.db();
    int result = await db.update(
      'items', 
      item.toMap(),
      where: "productId = ?",
      whereArgs: [productId]
    );

    return result;
  }

  static Future<int> deleteItem(String productId) async {
    final db = await SQLHelper.db();
    int result = await db.delete(
      'items',
      where: "productId = ?",
      whereArgs: [productId]
    );

    return result;
  }
}