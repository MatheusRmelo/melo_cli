part of 'books_cubit.dart';

sealed class BooksState {}

final class BooksInitial extends BooksState {}

final class BooksLoading extends BooksState {}

final class BooksSuccess extends BooksState {
  final List<BookModel> data;
  BooksSuccess(this.data);
}

final class BooksError extends BooksState {
  final String message;
  BooksError(this.message);
}
