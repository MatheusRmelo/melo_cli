import 'dart:io';

class CliDataSource {
  Future<void> create(String path, String name,
      {required String modelName, String tableName = 'tests'}) async {
    final fileName = "${name}_remote_datasource.dart";
    final file = File('$path/$fileName');
    if (await file.exists()) {
      print('File already exists');
    } else {
      var saved = await file.create(recursive: true);
      saved.writeAsString("""
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_list/app/commons/models/response/response_model.dart';
import 'package:store_list/app/core/shopping_list/infra/models/shopping_list_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class I${name.capitalize()}RemoteDataSource {
  Future<ResponseModel<List<$modelName>>> findAll(
      );
  Future<ResponseModel<$modelName>> findById(String id);
  Future<ResponseModel<bool>> update(String id, $modelName body);
  Future<ResponseModel<$modelName>> create($modelName body);
  Future<ResponseModel<bool>> delete(String id);
}

class ${name.capitalize()}RemoteDatasource implements I${name.capitalize()}RemoteDataSource {
  @override
  Future<ResponseModel<List<$modelName>>> findAll(
      ) async {
    final supabase = Supabase.instance.client;
    var response = await supabase
        .from('$tableName')
        .select();

    return ResponseModel(
        ok: true,
        result: (response as List)
            .map((e) => $modelName.fromJson(e))
            .toList());
  }

  @override
  Future<ResponseModel<$modelName>> findById(
      String id) async {
    final supabase = Supabase.instance.client;
    var response = await supabase.from('$tableName').select().eq('id', id);

    return ResponseModel(
        ok: true, result: $modelName.fromJson(response.first));
  }

  @override
  Future<ResponseModel<bool>> update(String id, $modelName body) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('$tableName').update(body.toJson()).eq('id', id);
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<$modelName>> create(
      $modelName body) async {
    final supabase = Supabase.instance.client;
    try {
      var response =
          await supabase.from('$tableName').insert(body.toJson()).select();
      return ResponseModel(
          ok: true, result: $modelName.fromJson(response.first));
    } catch (err) {
      return ResponseModel(
          ok: false, result: null, description: err.toString());
    }
  }

  @override
  Future<ResponseModel<bool>> delete(String id) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('$tableName').delete().eq('id', id);
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}

    """);
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
