import '../models/book_model.dart';
import '../../../../commons/models/response.dart';

abstract class IBooksListRepository {
  Future<({Response response, List<BookModel>? result})> findAll();
  Future<({Response response, BookModel? result})> findById(String id);
  Future<({Response response, bool result})> update(String id, BookModel body);

  Future<({Response response, bool result})> delete(String id);
  Future<({Response response, BookModel? result})> create(BookModel body);
}
