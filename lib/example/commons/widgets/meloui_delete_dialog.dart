import 'package:flutter/material.dart';

import 'meloui_button.dart';
import 'meloui_text.dart';

class MeloUiDeleteDialogWidget extends StatelessWidget {
  const MeloUiDeleteDialogWidget(
      {super.key,
      required this.title,
      required this.question,
      this.buttonText = 'Excluir',
      this.onClose,
      this.onDelete});
  final String title;
  final String question;
  final String buttonText;
  final VoidCallback? onClose;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Row(children: [
        const Spacer(),
        IconButton(
            onPressed: onClose ??
                () {
                  Navigator.pop(context);
                },
            icon: const Icon(Icons.close))
      ]),
      content: SizedBox(
        width: 300,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          MeloUiText(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          MeloUiText(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: MeloUiButton(
                    title: 'Fechar',
                    onPressed: onClose ??
                        () {
                          Navigator.pop(context);
                        },
                    backgroundColor: Colors.red,
                    variant: MeloUiButtonVariant.outlined),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: MeloUiButton(
                    title: buttonText,
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    onPressed: onDelete ??
                        () {
                          Navigator.pop(context, true);
                        }),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
