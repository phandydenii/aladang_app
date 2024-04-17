import 'package:sqflite/sqflite.dart' as sql;

class ProductCartDB {
  // ignore: constant_identifier_names
  static const product_cart_tbl = """
  CREATE TABLE product_carts(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        productId INTEGER,
        productCode TEXT,
        productName TEXT, 
        price DOUBLE NULL
      )""";

  static Future<void> createTables(sql.Database database) async {
    await database.execute(product_cart_tbl);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'AladangApp.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> insertProductCart(
      int proId, String proCode, String proName, double price) async {
    final db = await ProductCartDB.db();

    final data = {
      'productId': proId,
      'productCode': proCode,
      'productName': proName,
      'price': price,
    };
    final id = await db.insert('product_carts', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getProductCarts() async {
    final db = await ProductCartDB.db();
    return db.query('product_carts', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getProductCartCount() async {
    final db = await ProductCartDB.db();
    return db.rawQuery(
        'select productId,productCode,productName,price,COUNT(*) as count from product_carts group by productId,productCode,productName,price');
  }

  static Future<void> truncateProductCart() async {
    final db = await ProductCartDB.db();
    db.rawQuery('delete from product_carts');
  }

  static Future<void> delete(int id) async {
    final db = await ProductCartDB.db();
    await db.rawQuery('delete from product_carts where productId=' +
        id.toString() +
        ' limit 1');
  }

  static Future getSumTotal() async {
    final db = await ProductCartDB.db();
    return await db.rawQuery(
        'select sum(price) as total from product_carts group by price');
  }

  static Future coutItem() async {
    final db = await ProductCartDB.db();
    return await db.rawQuery('select count(*) as count from product_carts');
  }
}
