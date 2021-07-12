import 'package:flutter/material.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';

class LineButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color borderColor;

  const LineButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.transparent,
    this.textColor = kAltWhite,
    this.borderColor = kAltWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: kBorderSmall,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: kBorderSmall,
            border: Border.all(color: borderColor, width: 1)),
        child: Padding(
          padding: fieldPaddingAll,
          child: Center(
            child: Text(
              text,
              style: kBodyStyle.copyWith(
                  fontWeight: FontWeight.w700, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
