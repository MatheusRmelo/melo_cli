import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../commons/extensions/context_extension.dart';

import '../../../../commons/widgets/dialogs/delete_dialog_widget.dart';
import '../../../../commons/widgets/sidebar/sidebar.dart';
import '../../../../commons/widgets/table_widget.dart';
import '../../../../core/containers/injection_container.dart';
import '../../domain/models/user_model.dart';
import '../manager/users/users_cubit.dart';
import '../widgets/card_tile.dart';
import '../../../../commons/widgets/custom_button.dart';
import '../../../../commons/widgets/custom_text.dart';

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

  void _handleClickDelete(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => DeleteDialogWidget(
        title: 'Excluir usuário',
        question: 'Excluir o usuário ${user.name}, é uma ação irreversível',
        onClose: () => context.pop(context),
        onDelete: () {
          context.pop(context);
          _bloc.delete(user.id!);
        },
      ),
    );
  }

  void _handleClickEdit(UserModel user) {
    context
        .pushNamed('edit-user', pathParameters: {'id': user.id!}).then((value) {
      if (value is bool && value == true) {
        _bloc.findAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            body: Row(
              children: [
                const Sidebar(
                  width: 300,
                ),
                Expanded(
                  child: Builder(builder: (context) {
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
                            CustomText(
                              'Falha: ${state.message}',
                              color: Colors.red,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomButton(
                                width: 200,
                                title: 'Recarregar',
                                onPressed: () {})
                          ],
                        ),
                      );
                    }
                    if (state is UsersSuccess) {
                      return Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: CustomText(
                                    'Usuários',
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CustomButton(
                                    width: 250,
                                    title: 'Nova usuário',
                                    icon: Icons.add,
                                    onPressed: () {
                                      context
                                          .pushNamed('create-user')
                                          .then((value) {
                                        if (value is bool && value == true) {
                                          _bloc.findAll();
                                        }
                                      });
                                    })
                              ],
                            ),
                            Expanded(
                              child: context.isDesktop
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: TableWidget(
                                            data: state.data,
                                            columns: [
                                              TableOptionModel(name: '#'),
                                              TableOptionModel(name: "Nome")
                                            ],
                                            parser: (element) => [
                                              TableOptionModel(
                                                  name: element.id ?? ''),
                                              TableOptionModel(
                                                  name: element.name)
                                            ],
                                            hasAction: true,
                                            onDelete: (index) =>
                                                _handleClickDelete(
                                                    state.data[index]),
                                            onEdit: (index) => _handleClickEdit(
                                                state.data[index]),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 1.5,
                                              mainAxisSpacing: 16,
                                              crossAxisSpacing: 16),
                                      itemBuilder: (context, index) => SizedBox(
                                            width: 200,
                                            height: 100,
                                            child: CardTile(
                                              title: state.data[index].name,
                                              onTap: () {},
                                              onDelete: () =>
                                                  _handleClickDelete(
                                                      state.data[index]),
                                              onEdit: () => _handleClickEdit(
                                                  state.data[index]),
                                            ),
                                          ),
                                      itemCount: state.data.length),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
                ),
              ],
            ),
          );
        });
  }
}
