import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:flutter/material.dart';

import '../../helpers/validator_helper.dart';
import 'drop_down_widget.dart';

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({
    super.key,
    required this.onChanged,
    this.selectedItem,
  });

  final void Function(String) onChanged;
  final String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropDownWidget<String>(
      onChanged: onChanged,
      selectedItem: selectedItem,
      hintText: "gender",
      validator: ValidatorHelper.validateNotEmpty,
      builder: (item, index) {
        return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: context.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ));
      },
      items: const ["male", "female"],
    );
  }
}
