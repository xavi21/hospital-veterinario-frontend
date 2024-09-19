import 'package:flutter/material.dart';
import 'package:paraiso_canino/resources/colors.dart';

class CustomInputSelect extends StatelessWidget {
  final String title;
  final String? hint;
  final double? width;
  final String? selectedValue;
  final List<String> valueItems;
  final List<String> displayItems;
  final Function(String?) onSelected;
  final TextEditingController controller;

  const CustomInputSelect({
    super.key,
    required this.title,
    this.hint,
    this.selectedValue,
    this.width = 301.0,
    required this.valueItems,
    required this.displayItems,
    required this.onSelected,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 12.0,
                color: black,
              ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 4.0,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownMenu<String>(
              initialSelection: selectedValue,
              controller: controller,
              requestFocusOnTap: true,
              hintText: hint,
              width: width,
              enableSearch: true,
              enableFilter: true,
              onSelected: onSelected,
              dropdownMenuEntries: displayItems
                  .map((element) => DropdownMenuEntry<String>(
                        value: element,
                        label: element,
                        style: MenuItemButton.styleFrom(
                          foregroundColor: black,
                          backgroundColor: fillInputSelect,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
