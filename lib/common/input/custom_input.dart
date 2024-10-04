import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/validation/validate_input.dart';
import 'package:paraiso_canino/resources/colors.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPassword;
  final bool isRequired;
  final bool isEnabled;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String labelText;

  const CustomInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.isRequired = false,
    this.isEnabled = true,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isObscureText = true;

  void _handleEnableVisibility() => setState(
        () => isObscureText = !isObscureText,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextFormField(
          controller: widget.controller,
          enabled: widget.isEnabled,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: widget.isPassword ? isObscureText : false,
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
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: _handleEnableVisibility,
                    child: Icon(
                      isObscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: blue,
                      size: 20.0,
                    ),
                  )
                : null,
            errorStyle: const TextStyle(
              fontSize: 12.0,
              color: error,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 12.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                color: inputBorder,
                width: 1.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                color: inputBorder,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                32.0,
              ),
              borderSide: const BorderSide(
                color: error,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                32.0,
              ),
              borderSide: const BorderSide(
                color: inputBorder,
                width: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
