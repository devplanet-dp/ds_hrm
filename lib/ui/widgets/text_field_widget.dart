import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? initialValue, hintText, prefix;
  final TextEditingController controller;
  final Color textColor;
  final double margin;
  final Color? fillColor;
  final Color borderColor;
  final int minLine;
  final Widget? suffix, prefixWidget, prefixIcon;
  final bool isEmail,
      isPhone,
      isEnabled,
      isPassword,
      isMoney,
      isDark,
      isNumber,
      isTextArea;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final bool isCapitalize;
  final int maxLength;
  final double verticalPadding;
  final TextInputAction textInputAction;
  final double borderRadius;

  const AppTextField({
    Key? key,
    this.initialValue,
    this.prefix,
    required this.controller,
    this.onTap,
    this.hintText,
    this.maxLength = 100,
    this.isEmail = false,
    this.isEnabled = true,
    this.isTextArea = true,
    this.margin = 0,
    this.isPhone = false,
    this.isPassword = false,
    this.isDark = false,
    this.isMoney = false,
    this.isNumber = false,
    this.isCapitalize = true,
    this.textColor = Colors.black,
    this.suffix,
    this.prefixWidget,
    this.prefixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.verticalPadding = 20,
    this.validator,
    this.minLine = 1,
    this.fillColor,
    this.borderColor = Colors.transparent, this.textInputAction = TextInputAction.next, this.borderRadius = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        textAlign: TextAlign.start,
        initialValue: controller == null ? initialValue : null,
        controller: controller,
        obscureText: isPassword,
        enabled: isEnabled,
        validator: validator,
        onChanged: onChanged,
        minLines: minLine,
        textInputAction: textInputAction,
        onTap: onTap,
        enableInteractiveSelection: isEnabled,
        maxLength: maxLength,
        textCapitalization: isCapitalize
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        onEditingComplete: onEditingComplete,
        maxLines: isTextArea && !isPassword
            ? null
            : isPassword
                ? 1
                : 3,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isPhone
                ? TextInputType.phone
                : isMoney
                    ? TextInputType.numberWithOptions()
                    : TextInputType.multiline,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: isDark ? Colors.white : textColor),
        decoration: InputDecoration(
          hintText: initialValue,
          labelText: hintText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: isDark
                  ? Colors.white.withOpacity(0.9)
                  : textColor.withOpacity(0.4)),
          counterText: "",
          contentPadding:
              EdgeInsets.symmetric(horizontal: 30, vertical: verticalPadding),
          fillColor: fillColor == null
              ? isDark
                  ? kAltBg
                  : kAltWhite
              : fillColor,
          prefixText: prefix,
          prefix: prefixWidget,
          prefixIcon: prefixIcon,
          suffix: suffix,
          errorStyle: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 11,
              color: isDark ? Colors.white : Colors.red),
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: isDark
                  ? Colors.white.withOpacity(0.9)
                  : textColor.withOpacity(0.4)),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
