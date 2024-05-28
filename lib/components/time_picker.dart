import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  final String text;
  final TimeController;
  final Color labelColor;
  
  const TimePicker({
    super.key, 
    required this.text, 
    required this.TimeController,
    required this.labelColor,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  // variable time
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text, 
            textAlign: TextAlign.left,
            style: TextStyle(color: widget.labelColor),
          ),

          SizedBox(height: 5,),
          TextField(
            controller: this.widget.TimeController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              // hintText: this.widget.text,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            readOnly: true,
            onTap: () {_selectTime();},
          ),
        ],
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
        var df = DateFormat("h:mm a");
        var dt = df.parse(_picked.format(context));
        var finaltime =  DateFormat('HH:mm').format(dt); 
        widget.TimeController.text = finaltime;
      });
    }
  }
}