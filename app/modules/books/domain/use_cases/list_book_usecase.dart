import '../../../../commons/models/response.dart';
import '../models/book_model.dart';
import '../repositories/i_books_repository.dart';

class ListBookUsecase {
  final IBooksListRepository repository;
  ListBookUsecase({required this.repository});

  Future<({Response response, List<BookModel>? result})> call() async {
    var response = await repository.findAll();
    return response;
  }
}
