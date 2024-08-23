import 'package:flutter/material.dart';

import '../../../../commons/widgets/meloui_card.dart';
import '../../../../commons/widgets/meloui_delete_dialog.dart';
import '../../../../commons/widgets/meloui_text.dart';

class CardTile extends StatelessWidget {
  const CardTile(
      {super.key,
      required this.title,
      this.description = "",
      this.onDelete,
      this.onEdit,
      this.onTap});
  final String title;
  final String description;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MeloUiCard(
          width: double.infinity,
          height: 160,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MeloUiText(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      MeloUiText(
                        description,
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                  PopupMenuButton<int>(
                    icon: const Icon(Icons.settings),
                    onSelected: (int item) {
                      if (item == 1) {
                        if (onEdit != null) onEdit!();
                      } else if (item == 2) {
                        showDialog(
                          context: context,
                          builder: (context) => MeloUiDeleteDialogWidget(
                            title: 'Excluir lista de compra',
                            question:
                                'Ao excluir essa lista é uma ação irreversível',
                            onClose: () => Navigator.pop(context),
                            onDelete: () {
                              Navigator.pop(context);
                              if (onDelete != null) onDelete!();
                            },
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                      const PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(
                              width: 8,
                            ),
                            MeloUiText('Editar'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(
                              width: 8,
                            ),
                            MeloUiText('Excluir'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          )),
    );
  }
}
