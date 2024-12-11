import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons/widgets/sidebar/sidebar.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  final List<SidebarItemModel> _modules = [
    SidebarItemModel(
        icon: Icons.menu_book, name: 'Categorias', route: '/categories'),
  ];
  int _active = 0;

  int get active => _active;
  List<SidebarItemModel> get modules => _modules;

  void navigate(BuildContext context, int index) {
    Navigator.pushReplacementNamed(context, _modules[index].route);
    _active = index;
    emit(NavigationChange(active: index));
  }
}
