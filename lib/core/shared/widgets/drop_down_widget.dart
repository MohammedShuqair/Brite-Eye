import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    super.key,
    this.selectedItem,
    this.validator,
    required this.items,
    required this.hintText,
    this.onChanged,
    required this.builder,
  });

  final T? selectedItem;
  final String? Function(T?)? validator;
  final List<T> items;
  final String hintText;
  final void Function(T)? onChanged;
  final DropdownMenuItem<T> Function(T elemnt, int index) builder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: validator,
      value: selectedItem,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items:
          List.generate(items.length, (index) => builder(items[index], index)),
      onChanged: (v) {
        if (v != null && onChanged != null) {
          onChanged!(v);
        }
      },
    );
  }
}
