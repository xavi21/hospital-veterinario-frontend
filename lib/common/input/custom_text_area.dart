import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/validation/validate_input.dart';
import 'package:paraiso_canino/resources/colors.dart';

class CustomTextArea extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isRequired;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String labelText;

  const CustomTextArea({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType = TextInputType.text,
    this.isRequired = false,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(
          height: 12.0,
        ),
        TextFormField(
          minLines: 6,
          maxLines: null,
          controller: widget.controller,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.textInputType,
          cursorColor: blue,
          validator: (String? value) {
            if (validateInput(value, widget.isRequired) != null) {
              return validateInput(value, widget.isRequired);
            }
            if (widget.validator != null) {
              return widget.validator!(value);
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: fillInputSelect,
            errorStyle: const TextStyle(
              fontSize: 12.0,
              color: error,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 40.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                color: inputBorder,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                32.0,
              ),
              borderSide: const BorderSide(
                color: error,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                32.0,
              ),
              borderSide: const BorderSide(
                color: inputBorder,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
