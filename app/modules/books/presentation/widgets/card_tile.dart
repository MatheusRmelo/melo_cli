import 'package:flutter/material.dart';
import 'package:melo_ui/melo_ui.dart';

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
      child: MeloUICard(
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
                      MeloUIText(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      MeloUIText(
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
                          builder: (context) => MeloUIDeleteDialogWidget(
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
                            MeloUIText('Editar'),
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
                            MeloUIText('Excluir'),
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
