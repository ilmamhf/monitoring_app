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
  // FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextFormField(
          controller: widget.dateController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            hintText: widget.text,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: false,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(height: 0),
          ),
          readOnly: true,
          onTap: () {_selectDate();},

          // focusNode: node,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          // validator: (value) {
          //   if(node.hasFocus) return null;
          //   if (value!.isEmpty) return "";
          // return null;
          // },
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1950), 
      lastDate: DateTime(2100),
    );

    if (_picked != null){
      setState(() {
        this.widget.dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}