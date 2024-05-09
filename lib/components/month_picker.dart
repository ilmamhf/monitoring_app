import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthPicker extends StatefulWidget {
  final String text;
  final monthController;
  DateTime selectedMonth;
  final ValueChanged<DateTime> onMonthChanged; // Penambahan argumen
  
  MonthPicker({
    super.key, 
    required this.text, 
    required this.monthController,
    required this.selectedMonth,
    required this.onMonthChanged});

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  DateTime? _picked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextField(
          controller: widget.monthController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(8),
            hintText: widget.text,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: false,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          ),
          readOnly: true,
          onTap: () {_selectMonth(context: context);},
        ),
      ),
    );
  }

  Future<void> _selectMonth({required BuildContext context,}) async {
    final picked = await showMonthPicker(
      context: context, 
      initialDate: widget.selectedMonth,
      firstDate: DateTime(1950), 
      lastDate: DateTime(2100),
    );

    if (picked != null){
      setState(() {
        widget.monthController.text = DateFormat('MMMM yyyy').format(picked).toString();
        widget.onMonthChanged(picked);
        print(picked);
      });
    }
  }
}