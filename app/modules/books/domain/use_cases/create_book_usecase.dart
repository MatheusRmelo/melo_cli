import '../../../../commons/models/response.dart';
import '../models/book_model.dart';
import '../repositories/i_books_repository.dart';

class CreateBookUsecase {
  final IBooksListRepository repository;
  CreateBookUsecase({required this.repository});

  Future<({Response response, BookModel? result})> call(BookModel body) async {
    var response = await repository.create(body);
    return response;
  }
}
