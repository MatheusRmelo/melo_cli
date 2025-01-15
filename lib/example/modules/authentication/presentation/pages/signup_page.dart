import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/widgets/custom_card.dart';
import '../../../../commons/widgets/custom_snackbar.dart';
import '../../../../commons/widgets/custom_text_field.dart';

import '../../../../commons/widgets/custom_button.dart';
import '../../../../commons/widgets/custom_text.dart';
import '../../../../commons/extensions/error_field_extension.dart';
import '../../../../core/containers/injection_container.dart';
import '../manager/authentication/authentication_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _bloc = dependency.get<AuthenticationCubit>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(context: context, content: Text(state.message)));
          }
          if (state is AuthenticationSuccess) {
            Navigator.pushReplacementNamed(context, '/');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: context.isMobile ? Colors.white : null,
              elevation: context.isMobile ? 0 : null,
            ),
            body: Padding(
              padding: context.isMobile
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    if (context.isDesktop)
                      const Spacer(
                        flex: 1,
                      ),
                    Expanded(
                      child: CustomCard(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                "Crie sua conta!",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const CustomText(
                                "E aproveite",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomTextField(
                                margin: EdgeInsets.zero,
                                label: 'Nome',
                                prefixIcon: const Icon(Icons.person),
                                placeholder: 'Digite o seu nome',
                                controller: _nameController,
                                error: state is AuthenticationErrorField
                                    ? state.errors.getErrorWithCode('name')
                                    : null,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextField(
                                margin: EdgeInsets.zero,
                                label: 'E-mail',
                                prefixIcon: const Icon(Icons.email),
                                placeholder: 'Digite o seu e-mail',
                                controller: _emailController,
                                capitalization: TextCapitalization.none,
                                error: state is AuthenticationErrorField
                                    ? state.errors.getErrorWithCode('email')
                                    : null,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextField(
                                margin: EdgeInsets.zero,
                                prefixIcon: const Icon(Icons.lock),
                                isPassword: true,
                                label: 'Senha',
                                placeholder: "Digite a sua senha",
                                controller: _passwordController,
                                capitalization: TextCapitalization.none,
                                error: state is AuthenticationErrorField
                                    ? state.errors.getErrorWithCode('password')
                                    : null,
                              ),
                              CustomButton(
                                margin: const EdgeInsets.only(top: 32),
                                title: 'Criar conta',
                                onPressed: () => _bloc.handleClickSignUp(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text),
                                isLoading: state is AuthenticationLoading,
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 8),
                                child: TextButton(
                                    onPressed: () {
                                      if (Navigator.canPop(context)) {
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pushNamed(context, '/signUp');
                                      }
                                    },
                                    child: const Text(
                                      "Já tem conta? Entre agora!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ]),
                      ),
                    ),
                    if (context.isDesktop)
                      const Spacer(
                        flex: 1,
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
