import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDatabase {

  static Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
        join(await getDatabasesPath(), 'greenmon.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE credentials(id INTEGER PRIMARY KEY, email TEXT, apiToken TEXT)',
          );
        },
        version: 1,
    );
  }



}