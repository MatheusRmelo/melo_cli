import '../../../core/containers/injection_container.dart';
import '../presentation/manager/users/users_cubit.dart';
import '../presentation/manager/users_form/users_form_cubit.dart';
import '../presentation/pages/users_form_page.dart';
import '../presentation/pages/users_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final getRouterContainer = [
  GoRoute(
    path: '/users',
    name: 'get-users',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<UsersCubit>(
          create: (context) => dependency.get<UsersCubit>(),
          child: const UsersPage(),
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
  GoRoute(
    path: '/users/create',
    name: 'create-user',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<UsersFormCubit>(
          create: (context) => dependency.get<UsersFormCubit>(),
          child: const UsersFormPage(),
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
  GoRoute(
    path: '/users/edit/:id',
    name: 'edit-user',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<UsersFormCubit>(
          create: (context) => dependency.get<UsersFormCubit>(),
          child: UsersFormPage(
            id: state.pathParameters['id'],
          ),
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
];
