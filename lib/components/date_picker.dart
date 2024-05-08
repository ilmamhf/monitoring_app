import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final String text;
  final dateController;
  
  const DatePicker({
    super.key, 
    required this.text, 
    required this.dateController});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextField(
          controller: this.widget.dateController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(12),
            hintText: this.widget.text,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
          ),
          readOnly: true,
          onTap: () {_selectDate();},
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100),
    );

    if (_picked != null){
      setState(() {
        this.widget.dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}