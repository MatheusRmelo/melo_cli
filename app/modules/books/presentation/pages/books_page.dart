import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../../commons/injection/injection_container.dart';
import '../manager/books/books_cubit.dart';
import '../widgets/card_tile.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final _bloc = dependency.get<BooksCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const MeloUIText('Minhas listas de compras'),
              actions: [
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                )
              ],
            ),
            body: Builder(builder: (context) {
              if (state is BooksLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is BooksError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MeloUIText(
                        'Falha: ${state.message}',
                        color: Colors.red,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      MeloUIButton(
                          width: 200, title: 'Recarregar', onPressed: () {})
                    ],
                  ),
                );
              }
              if (state is BooksSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => CardTile(
                                  title: state.data[index].name,
                                  onTap: () {},
                                  onDelete: () {},
                                  onEdit: () {},
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 16,
                                ),
                            itemCount: state.data.length),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            }),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add_shopping_cart_rounded),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        });
  }
}
