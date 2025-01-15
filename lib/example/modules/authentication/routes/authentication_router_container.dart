import '../../../core/containers/injection_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation/manager/authentication/authentication_cubit.dart';
import '../presentation/pages/signin_page.dart';

final getRouterContainer = [
  GoRoute(
    path: '/sign-in',
    name: 'sign-in',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<AuthenticationCubit>(
          create: (context) => dependency.get<AuthenticationCubit>(),
          child: const SignInPage(),
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
    path: '/sign-up',
    name: 'sign-up',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<AuthenticationCubit>(
          create: (context) => dependency.get<AuthenticationCubit>(),
          child: const SignInPage(),
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
