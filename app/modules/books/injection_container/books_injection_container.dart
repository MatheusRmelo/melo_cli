import '../../../commons/injection/injection_adapter.dart';
import '../data/data_sources/books_remote_datasource.dart';
import '../data/repositories/books_repository.dart';
import '../domain/repositories/i_books_repository.dart';
import '../domain/use_cases/create_book_usecase.dart';
import '../domain/use_cases/delete_book_usecase.dart';
import '../domain/use_cases/detail_book_usecase.dart';
import '../domain/use_cases/list_book_usecase.dart';
import '../domain/use_cases/update_book_usecase.dart';
import '../presentation/manager/books/books_cubit.dart';
import '../presentation/manager/books_form/books_form_cubit.dart';

class BooksInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<IBooksRemoteDataSource>(
      () => BooksRemoteDataSource(),
    );

    dependency.registerFactory<IBooksListRepository>(
      () => BooksRepository(
        remoteDataSource: dependency.get<IBooksRemoteDataSource>(),
      ),
    );

    dependency.registerFactory<ListBookUsecase>(
      () => ListBookUsecase(repository: dependency.get<IBooksListRepository>()),
    );

    dependency.registerFactory<DeleteBookUsecase>(
      () =>
          DeleteBookUsecase(repository: dependency.get<IBooksListRepository>()),
    );

    dependency.registerFactory<DetailBookUsecase>(
      () =>
          DetailBookUsecase(repository: dependency.get<IBooksListRepository>()),
    );

    dependency.registerFactory<UpdateBookUsecase>(
      () =>
          UpdateBookUsecase(repository: dependency.get<IBooksListRepository>()),
    );

    dependency.registerFactory<CreateBookUsecase>(
      () =>
          CreateBookUsecase(repository: dependency.get<IBooksListRepository>()),
    );

    dependency.registerFactory<BooksCubit>(
      () => BooksCubit(
          deleteBookUsecase: dependency.get<DeleteBookUsecase>(),
          listBookUsecase: dependency.get<ListBookUsecase>()),
    );

    dependency.registerFactory<BooksFormCubit>(
      () => BooksFormCubit(
        detailBookUsecase: dependency.get<DetailBookUsecase>(),
        updateBookUsecase: dependency.get<UpdateBookUsecase>(),
        createBookUsecase: dependency.get<CreateBookUsecase>(),
      ),
    );
  }
}
