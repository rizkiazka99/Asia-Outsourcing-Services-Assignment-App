import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/cart_response.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      productId TEXT,
      productName TEXT,
      productPhoto TEXT,
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
      id: int.parse(maps[index]['id'].toString()),
      productId: maps[index]['productId'].toString(), 
      productName: maps[index]['productName'].toString(),
      productPhoto: maps[index]['productPhoto'].toString(),
      productValue: maps[index]['productValue'].toString(), 
      productSize: maps[index]['productSize'].toString(), 
      quantity: int.parse(maps[index]['quantity'].toString()), 
      createdAt: maps[index]['createdAt'].toString()
    ));

    for(var i = 0; i < items.length; i++) {
      print(items[i].id);
      print(items[i].productId);
      print(items[i].productName);
      print(items[i].productPhoto);
      print(items[i].productValue);
      print(items[i].productSize);
      print(items[i].quantity);
      print(items[i].createdAt);
    }
    return items;
  }

  static Future<int> updateItem(int? id, Cart item) async {
    final db = await SQLHelper.db();
    int result = await db.update(
      'items', 
      item.toMap(),
      where: "id = ?",
      whereArgs: [id]
    );

    return result;
  }

  static Future<int> deleteItem(int? id) async {
    final db = await SQLHelper.db();
    int result = await db.delete(
      'items',
      where: "id = ?",
      whereArgs: [id]
    );

    return result;
  }
}