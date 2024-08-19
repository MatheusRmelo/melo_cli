import '../../../../commons/models/response.dart';
import '../../domain/models/book_model.dart';
import '../../domain/repositories/i_books_repository.dart';
import '../data_sources/books_remote_datasource.dart';

class BooksRepository implements IBooksListRepository {
  final IBooksRemoteDataSource remoteDataSource;
  BooksRepository({
    required this.remoteDataSource,
  });

  @override
  Future<({Response response, List<BookModel>? result})> findAll() async {
    var response = await remoteDataSource.findAll();
    return (response: Success(), result: response.result);
  }

  @override
  Future<({Response response, BookModel? result})> findById(String id) async {
    var response = await remoteDataSource.findById(id);
    return (response: Success(), result: response.result);
  }

  @override
  Future<({Response response, bool result})> update(
      String id, BookModel body) async {
    var response = await remoteDataSource.update(id, body);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }

  @override
  Future<({Response response, BookModel? result})> create(
      BookModel body) async {
    var response = await remoteDataSource.create(body);
    return (
      response: response.result == null
          ? ErrorResponse(response.description)
          : Success(),
      result: response.result
    );
  }

  @override
  Future<({Response response, bool result})> delete(String id) async {
    var response = await remoteDataSource.delete(id);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }
}
