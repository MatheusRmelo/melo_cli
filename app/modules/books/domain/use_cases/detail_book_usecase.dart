import '../../../../commons/models/response.dart';
import '../models/book_model.dart';
import '../repositories/i_books_repository.dart';

class DetailBookUsecase {
  final IBooksListRepository repository;
  DetailBookUsecase({required this.repository});

  Future<({Response response, BookModel? result})?> call(String id) async {
    var response = await repository.findById(id);
    return response;
  }
}
