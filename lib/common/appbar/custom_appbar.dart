import 'package:flutter/material.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required String userName,
  }) : _userName = userName;

  final String _userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(
        vertical: 22.0,
        horizontal: 80.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            textAlign: TextAlign.end,
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Bienvenido \n',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: _userName,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          const CircleAvatar(
            backgroundColor: fillInputSelect,
            backgroundImage: AssetImage('${imagePath}paw.png'),
          )
        ],
      ),
    );
  }
}
