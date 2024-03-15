import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({
    super.key,
    required this.items,
    required this.onChanged,
    required this.validator,
    required this.hint,
    this.selectedValue,
  });

  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String hint;

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      hint: Text(
        widget.hint,
        style: const TextStyle(fontSize: 14),
      ),
      value: widget.selectedValue,
      items: widget.items.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ),
      )).toList(),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: (value) {},
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
