import '../../../../commons/models/response.dart';
import '../repositories/i_books_repository.dart';

class DeleteBookUsecase {
  final IBooksListRepository repository;
  DeleteBookUsecase({required this.repository});

  Future<({Response response, bool? result})> call(String id) async {
    var response = await repository.delete(id);
    return response;
  }
}
