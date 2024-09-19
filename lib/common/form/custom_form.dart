import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final Widget formContent;

  const CustomForm({
    super.key,
    required this.formContent,
    required this.title,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          SizedBox(
            height: 110.0,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _backButton(),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: widget.formContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton() => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('${iconPath}arrow_back.svg'),
            const Text('Regresar')
          ],
        ),
      );
}
