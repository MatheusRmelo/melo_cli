import 'package:flutter/material.dart';

class MeloUiErrorSnackbar extends SnackBar {
  MeloUiErrorSnackbar({
    super.key,
    required BuildContext context,
    required super.content,
  }) : super(
          backgroundColor: Theme.of(context).colorScheme.error,
          action: SnackBarAction(
            label: 'FECHAR',
            textColor: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        );
}

class MeloUiSuccessSnackbar extends SnackBar {
  MeloUiSuccessSnackbar({
    super.key,
    required BuildContext context,
    required super.content,
  }) : super(
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'FECHAR',
            textColor: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        );
}
