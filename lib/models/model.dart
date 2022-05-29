import 'dart:ffi';
import 'package:drift/drift.dart';
import 'package:zen_player/models/database.dart';

class BaseModel {
  final MyDatabase database;

  BaseModel(
      this.database); // For testing purpose, do not use it in production code.

  Value<T> getCompanionValue<T>(String key, T value) {
    return value == null ? Value.absent() : Value(value);
  }
}

abstract class Model<T> {
  Future<T> insert(Map<String, dynamic> data);

  Future<T> findOrCreate(Map<String, dynamic> data);

  Future<T> findById(id);

  Future<T> updateById(id, T dataToUpdate);

  Future<void> removeById(id);
}
