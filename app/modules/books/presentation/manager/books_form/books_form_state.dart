part of 'books_form_cubit.dart';

sealed class BooksFormState {}

final class BooksFormInitial extends BooksFormState {}

final class BooksFormLoading extends BooksFormState {}

final class BooksFormBusy extends BooksFormState {}

final class BooksFormDetailSuccess extends BooksFormState {
  final BookModel data;
  BooksFormDetailSuccess(this.data);
}

final class BooksFormSuccess extends BooksFormState {
  BooksFormSuccess();
}

final class BooksFormError extends BooksFormState {
  final String message;
  BooksFormError(this.message);
}
