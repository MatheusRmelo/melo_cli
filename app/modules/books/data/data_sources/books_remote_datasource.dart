import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../commons/models/response_model.dart';
import '../../domain/models/book_model.dart';

abstract class IBooksRemoteDataSource {
  Future<ResponseModel<List<BookModel>>> findAll();
  Future<ResponseModel<BookModel>> findById(String id);
  Future<ResponseModel<bool>> update(String id, BookModel body);
  Future<ResponseModel<BookModel>> create(BookModel body);
  Future<ResponseModel<bool>> delete(String id);
}

class BooksRemoteDataSource implements IBooksRemoteDataSource {
  final String _table = "books";

  @override
  Future<ResponseModel<List<BookModel>>> findAll() async {
    final supabase = Supabase.instance.client;
    var response = await supabase.from(_table).select();

    return ResponseModel(
        ok: true,
        result: (response as List).map((e) => BookModel.fromJson(e)).toList());
  }

  @override
  Future<ResponseModel<BookModel>> findById(String id) async {
    final supabase = Supabase.instance.client;
    var response = await supabase.from(_table).select().eq('id', id);

    return ResponseModel(ok: true, result: BookModel.fromJson(response.first));
  }

  @override
  Future<ResponseModel<bool>> update(String id, BookModel body) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from(_table).update(body.toJson()).eq('id', id);
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<BookModel>> create(BookModel body) async {
    final supabase = Supabase.instance.client;
    try {
      var response = await supabase.from(_table).insert(body.toJson()).select();
      return ResponseModel(
          ok: true, result: BookModel.fromJson(response.first));
    } catch (err) {
      return ResponseModel(
          ok: false, result: null, description: err.toString());
    }
  }

  @override
  Future<ResponseModel<bool>> delete(String id) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from(_table).delete().eq('id', id);
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
