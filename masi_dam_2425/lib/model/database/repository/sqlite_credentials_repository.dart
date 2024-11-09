import 'package:masi_dam_2425/model/credentials.dart';
import 'package:sqflite/sqflite.dart';
import 'base_repository.dart';

class CredentialsRepositorySQLite implements CredentialRepository {

  final Database _database;
  final String _table = "credentials";

  CredentialsRepositorySQLite(this._database);

  @override
  Future<void> insert(Credentials credentials) async {
    await _database.insert(
      'credentials',
      credentials.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Credentials> credentials() async {
    final List<Map<String, Object?>> credentials = await _database.query(_table);
    if (credentials.isNotEmpty) {
      final Map<String, Object?> credentialMap = credentials.first;
      return Credentials(
        id: credentialMap['id'] as int,
        email: credentialMap['email'] as String,
        apiToken: credentialMap['apiToken'] as String,
      );
    } else {
      throw Exception('No credentials found');
    }
  }

  @override
  Future<List<Credentials>> getAll() async {
    final List<Map<String, Object?>> credentials = await _database.query(_table);
    return credentials.isNotEmpty
        ? credentials.map((credentialMap) => Credentials(
            id: credentialMap['id'] as int,
            email: credentialMap['email'] as String,
            apiToken: credentialMap['apiToken'] as String,
          )).toList()
        : [];
  }

  @override
  Future<Credentials?> getById(int id) async {
    List<Map<String, dynamic>> results = await _database.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? Credentials(
      id: results.first['id'] as int,
      email: results.first['email'] as String,
      apiToken: results.first['apiToken'] as String,
    ) : null;
  }

  @override
  Future<void> update(Credentials credentials) async {
    await _database.update(
      _table,
      credentials.toMap(),
      where: 'id = ?',
      whereArgs: [credentials.id],
    );
  }

  @override
  Future<void> delete(int id) async {
    await _database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
