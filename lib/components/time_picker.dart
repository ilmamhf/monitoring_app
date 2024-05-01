import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final String text;
  final TimeController;
  
  const TimePicker({
    super.key, 
    required this.text, 
    required this.TimeController});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  // variable time
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextField(
          controller: this.widget.TimeController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(8),
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
          onTap: () {_selectTime();},
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    TimeOfDay? _picked = await showTimePicker(
      context: context, 
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (_picked != null){
      setState(() {
        this.widget.TimeController.text = '${selectedTime.hour}:${selectedTime.minute}';
      });
    }
  }
}