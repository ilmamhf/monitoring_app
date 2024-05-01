import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatefulWidget {
  final String hintText;
  final List<String> listString;
  String selectedItem;
  final Function(String?) onChange;

  DropdownField({
    super.key, 
    required this.hintText, 
    required this.listString,
    required this.selectedItem,
    required this.onChange
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: DropdownSearch<String>(
        items: widget.listString,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: widget.hintText,
            // hintText: hintText,
          )
        ),
        validator: (String? item) {
          if (item == null)
            return "Tidak boleh kosong";
          else
            return null;
        },
        onChanged: widget.onChange,
        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) {
            return ListTile(
              title: Text(item),
              selected: isSelected,
          );
          },
        ),
      ),
    );
  }
}