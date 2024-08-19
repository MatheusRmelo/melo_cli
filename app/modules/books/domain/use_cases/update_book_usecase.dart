import '../../../../commons/models/response.dart';
import '../models/book_model.dart';
import '../repositories/i_books_repository.dart';

class UpdateBookUsecase {
  final IBooksListRepository repository;
  UpdateBookUsecase({required this.repository});

  Future<({Response response, bool? result})> call(
      String id, BookModel body) async {
    var response = await repository.update(id, body);
    return response;
  }
}
