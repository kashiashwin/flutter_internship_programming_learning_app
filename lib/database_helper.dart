import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'backend.db');

    final db = await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        gender TEXT,
        password TEXT,
        confirm_password TEXT,
        profile_photo TEXT
      )
    ''');

        await db.execute('''
      CREATE TABLE login(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT
      )
    ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
        CREATE TABLE IF NOT EXISTS login(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          password TEXT
        )
      ''');
        }
        if (oldVersion < 3) {
          await db.execute(
            'ALTER TABLE users ADD COLUMN profile_photo TEXT',
          );
          // Some testers originally fresh-installed at v2, when onCreate
          // only created `users`. That launch path never received a
          // `login` table, so `INSERT INTO login` was failing. Create it
          // here on the v2 -> v3 upgrade so existing installs recover.
          await db.execute('''
        CREATE TABLE IF NOT EXISTS login(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          password TEXT
        )
      ''');
        }
      },
    );

    // ─── SAFETY NET ─────────────────────────────────────────────
    // Runs on every database open, regardless of whether path was
    // onCreate (fresh install) or onUpgrade (existing install). The
    // IF NOT EXISTS clause makes these idempotent — they are a no-op
    // when the table already exists with the same shape.
    //
    // This guarantees a `login` table even if the device has a
    // half-migrated database left over from earlier versions, which
    // was the root cause of the `no such table: login` crash on
    // sign-up. Columns must mirror onCreate above exactly so the
    // schema never drifts.
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        gender TEXT,
        password TEXT,
        confirm_password TEXT,
        profile_photo TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS login(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT
      )
    ''');

    return db;
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<bool> checker(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
  }

  Future<int> insertLUser(Map<String, dynamic> users) async {
    final db = await database;
    return await db.insert('login', users);
  }

  // GET USERS
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // GET USER BY EMAIL (used by the profile page)
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return result.first;
  }

  // update user
  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatelUser(Map<String, dynamic> users) async {
    final db = await database;
    return await db.update(
      'login',
      users,
      where: 'id = ?',
      whereArgs: [users['id']],
    );
  }

  Future<int> deletelUser(int id) async {
    final db = await database;
    return await db.delete(
      'login',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a user account (by email) and the matching login row.
  // Used by the settings page "Delete account" button.
  Future<void> deleteAccountByEmail(String email) async {
    final db = await database;
    await db.delete('users', where: 'email = ?', whereArgs: [email]);
    await db.delete('login', where: 'email = ?', whereArgs: [email]);
  }

  // Update password (by email)
  Future<int> updatePasswordByEmail(String email, String newPassword) async {
    final db = await database;
    return await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Update profile photo path (by email)
  Future<int> updateProfilePhotoByEmail(String email, String photoPath) async {
    final db = await database;
    return await db.update(
      'users',
      {'profile_photo': photoPath},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
