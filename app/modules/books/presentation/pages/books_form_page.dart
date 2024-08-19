import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melo_ui/melo_ui.dart';
import '../../../../commons/injection/injection_container.dart';
import '../../domain/models/book_model.dart';
import '../manager/books_form/books_form_cubit.dart';

class BooksFormPage extends StatefulWidget {
  const BooksFormPage({super.key, this.id, required this.activeDate});
  final String? id;
  final DateTime activeDate;
  @override
  State<BooksFormPage> createState() => _BooksFormPageState();
}

class _BooksFormPageState extends State<BooksFormPage> {
  final _bloc = dependency.get<BooksFormCubit>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id == null) {
      _nameController.clear();
    } else {
      _bloc.findById(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksFormCubit, BooksFormState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is BooksFormSuccess) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
          if (state is BooksFormError) {
            ScaffoldMessenger.of(context).showSnackBar(MeloUIErrorSnackbar(
                context: context, content: Text(state.message)));
          }
          if (state is BooksFormDetailSuccess) {
            _nameController.text = state.data.name;
          }
        },
        builder: (context, state) {
          if (state is BooksFormLoading) {
            return Scaffold(
                appBar: AppBar(
                  title: MeloUIText(
                      '${widget.id != null ? 'Editar' : 'Cadastrar'} lista de compra'),
                  centerTitle: true,
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          return Scaffold(
            appBar: AppBar(
              title: MeloUIText(
                  '${widget.id != null ? 'Editar' : 'Cadastrar'} lista de compra'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MeloUIText(
                      'Selecione o dia (Opcional)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MeloUITextField(
                      label: 'Nome',
                      placeholder: 'Digite o nome do orçamento',
                      controller: _nameController,
                    ),
                    MeloUIButton(
                        title:
                            '${widget.id != null ? 'Editar' : 'Criar'} lista',
                        isLoading: (state is BooksFormBusy),
                        onPressed: () {
                          _bloc.save(BookModel(
                              name: _nameController.text, id: widget.id));
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
