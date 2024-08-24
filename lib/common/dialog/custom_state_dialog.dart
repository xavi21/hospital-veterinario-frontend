import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class CustomStateDialog {
  static void showAlertDialog(
    BuildContext context, {
    required String title,
    String description = emptyString,
    bool isError = false,
    bool isWarning = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: isError
              ? SvgPicture.asset(
                  '${imagePath}error.svg',
                )
              : isWarning
                  ? SvgPicture.asset(
                      '${imagePath}warning.svg',
                    )
                  : SvgPicture.asset(
                      '${imagePath}success.svg',
                    ),
          iconPadding: EdgeInsets.zero,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(
              60.0,
            ),
          ),
          title: Container(
            margin: const EdgeInsets.only(
              top: 20.0,
              bottom: 5,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          content: IntrinsicHeight(
            child: IntrinsicWidth(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 5.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        18.0,
                      ),
                      color: blue.withOpacity(
                        0.56,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  SizedBox(
                    width: 340.0,
                    child: Text(
                      description,
                      maxLines: 5,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          titlePadding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
          ),
          contentPadding: const EdgeInsets.only(
            top: 13.0,
            left: 20.0,
            bottom: 20.0,
          ),
        );
      },
    );
  }
}
