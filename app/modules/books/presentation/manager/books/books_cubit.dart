import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melo_cli/example/commons/models/response.dart';

import '../../../domain/models/book_model.dart';
import '../../../domain/use_cases/delete_book_usecase.dart';
import '../../../domain/use_cases/list_book_usecase.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final ListBookUsecase listBookUsecase;
  final DeleteBookUsecase deleteBookUsecase;
  BooksCubit({required this.listBookUsecase, required this.deleteBookUsecase})
      : super(BooksInitial());

  Future<void> findAll() async {
    emit(BooksLoading());
    var response = await listBookUsecase.call();
    if (response is ErrorResponse) {
      emit(BooksError((response.response as ErrorResponse).error));
    } else {
      emit(BooksSuccess(response.result!));
    }
  }

  Future<void> delete(String id) async {
    emit(BooksLoading());
    var response = await deleteBookUsecase.call(id);
    if (response is ErrorResponse) {
      emit(BooksError((response.response as ErrorResponse).error));
    } else {
      findAll();
    }
  }
}
