import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/models/response.dart';
import '../../../domain/models/book_model.dart';
import '../../../domain/use_cases/create_book_usecase.dart';
import '../../../domain/use_cases/detail_book_usecase.dart';
import '../../../domain/use_cases/update_book_usecase.dart';

part 'books_form_state.dart';

class BooksFormCubit extends Cubit<BooksFormState> {
  final DetailBookUsecase detailBookUsecase;
  final UpdateBookUsecase updateBookUsecase;
  final CreateBookUsecase createBookUsecase;

  BooksFormCubit(
      {required this.detailBookUsecase,
      required this.updateBookUsecase,
      required this.createBookUsecase})
      : super(BooksFormInitial());

  Future<void> findById(String id) async {
    emit(BooksFormLoading());
    var data = await detailBookUsecase.call(id);
    if (data!.response is Success) {
      emit(BooksFormDetailSuccess(data.result!));
    } else if (data.response is ErrorResponse) {
      emit(BooksFormError((data.response as ErrorResponse).error));
    }
  }

  Future<void> save(BookModel body) async {
    emit(BooksFormBusy());
    Response response = Success();
    if (body.id != null) {
      response = (await updateBookUsecase.call(body.id!, body)).response;
    } else {
      response = (await createBookUsecase.call(body)).response;
    }

    if (response is Success) {
      emit(BooksFormSuccess());
    } else if (response is ErrorResponse) {
      emit(BooksFormError(response.error));
    }
  }
}
