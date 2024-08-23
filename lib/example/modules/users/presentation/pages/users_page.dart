import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commons/injection/injection_container.dart';
import '../manager/users/users_cubit.dart';
import '../widgets/card_tile.dart';
import '../../../../commons/widgets/meloui_button.dart';
import '../../../../commons/widgets/meloui_text.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _bloc = dependency.get<UsersCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const MeloUiText('Minhas listas de compras'),
              actions: [
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                )
              ],
            ),
            body: Builder(builder: (context) {
              if (state is UsersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UsersError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MeloUiText(
                        'Falha: ${state.message}',
                        color: Colors.red,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      MeloUiButton(
                          width: 200, title: 'Recarregar', onPressed: () {})
                    ],
                  ),
                );
              }
              if (state is UsersSuccess) {
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
