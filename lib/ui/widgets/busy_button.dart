import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';

class BoxButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isLoading;
  final double radius;

  const BoxButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor =kAltWhite,
    required this.onPressed,
    this.isLoading = false,
    this.radius = 7.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      height: 50,
      minWidth: context.screenWidth(percent: 1),
      color: buttonColor,
      padding: EdgeInsets.zero,
      disabledColor: kcAccent,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      onPressed: isLoading ? null : onPressed,
      child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF438eef),
                Color(0xFF2c7fed),
                Color(0xFF1471eb),
              ],
            ),
          ),
          constraints: BoxConstraints(
              minWidth: context.screenWidth(percent: 1), minHeight: 50),
          duration: const Duration(milliseconds: 200),
          child: Center(
              child: isLoading
                  ? CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(kAltWhite))
                  : Text(
                      buttonText.toUpperCase(),
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ))),
    );
  }
}
