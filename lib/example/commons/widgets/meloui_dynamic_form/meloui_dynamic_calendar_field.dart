import 'package:flutter/material.dart';

import '../meloui_calendar_widget.dart';

class MeloUiDynamicCalendarField extends StatefulWidget {
  const MeloUiDynamicCalendarField(
      {super.key,
      required this.label,
      required this.activeDate,
      required this.onChanged});
  final String label;
  final DateTime activeDate;
  final ValueChanged<DateTime?> onChanged;
  @override
  State<MeloUiDynamicCalendarField> createState() =>
      _MeloUiDynamicCalendarFieldState();
}

class _MeloUiDynamicCalendarFieldState
    extends State<MeloUiDynamicCalendarField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 280,
          child: MeloUiCalendarWidget(
            activeDate: DateTime(widget.activeDate.year,
                widget.activeDate.month, widget.activeDate.day),
            onChanged: (DateTime? date) {
              if (date?.day != null) {
                widget.onChanged(date!);
              }
            },
          ),
        ),
      ],
    );
  }
}
