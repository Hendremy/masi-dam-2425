import 'package:masi_dam_2425/model/database/repository/sqlite_credentials_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../source/datasource.dart';

class RepositoryFactory {
  final DatabaseSource source;
  final Database? sqliteDb;

  RepositoryFactory({
    required this.source,
    this.sqliteDb
  });

  T getRepository<T>() {
    switch (source) {
      case DatabaseSource.sqlite:
        return _createSQLiteRepository<T>();
      default:
        throw Exception("Unknown database source");
    }
  }

  T _createSQLiteRepository<T>() {
    if (sqliteDb == null) throw Exception("SQLite database is not initialized");
    if (T == CredentialsRepositorySQLite) return CredentialsRepositorySQLite(sqliteDb!) as T;
    throw Exception("Repository type $T is not supported for SQLite");
  }
}