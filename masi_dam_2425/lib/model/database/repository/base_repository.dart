import '../../credentials.dart';

abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<void> insert(T item);
  Future<void> update(T item);
  Future<void> delete(int id);
}

abstract class CredentialRepository extends BaseRepository<Credentials> {}