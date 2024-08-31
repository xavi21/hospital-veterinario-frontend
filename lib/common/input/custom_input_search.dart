import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class CustomInputSearch extends StatelessWidget {
  final TextEditingController controller;
  final Function? onPressed;
  final String? hintTex;
  final Function(String)? onChanged;
  final Function()? onTap;
  final double maxWidth;
  final double maxHeight;

  const CustomInputSearch({
    super.key,
    required this.controller,
    this.onPressed,
    this.hintTex,
    this.onChanged,
    this.onTap,
    this.maxHeight = 37.0,
    this.maxWidth = 515.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        onFieldSubmitted: (value) => onPressed!(),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(
              10.0,
            ),
            child: SvgPicture.asset(
              '${iconPath}search_grey.svg',
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          suffixIcon: InkWell(
            onTap: () {
              onPressed!();
            },
            child: _sendButton(context),
          ),
          fillColor: inputColor,
          hintText: hintTex,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              25.0,
            ),
            borderSide: const BorderSide(
              color: inputColor,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              25.0,
            ),
            borderSide: const BorderSide(
              color: inputColor,
              width: 2.0,
            ),
          ),
        ),
        minLines: 1,
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        enableSuggestions: false,
        controller: controller,
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _sendButton(BuildContext context) {
    return Container(
      width: 120.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            28.0,
          ),
          topRight: Radius.circular(
            5.0,
          ),
          bottomRight: Radius.circular(
            20.0,
          ),
          bottomLeft: Radius.circular(
            4.0,
          ),
        ),
        color: Colors.white,
      ),
      child: Container(
        margin: const EdgeInsets.only(
          top: 2.0,
        ),
        height: 80.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              32.0,
            ),
            topRight: Radius.circular(
              5.0,
            ),
            bottomRight: Radius.circular(
              5.0,
            ),
            bottomLeft: Radius.circular(
              2.0,
            ),
          ),
          color: Colors.white,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 3,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                30.0,
              ),
              topRight: Radius.circular(
                5.0,
              ),
              bottomRight: Radius.circular(
                30.0,
              ),
              bottomLeft: Radius.circular(
                5.0,
              ),
            ),
            color: search,
            border: Border.all(
              color: border,
              width: 1.0,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Buscar',
                style: TextStyle(
                  fontSize: 12.0,
                  color: blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
