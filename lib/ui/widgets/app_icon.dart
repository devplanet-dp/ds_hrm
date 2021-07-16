import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color bgColor;

  const AppIconWidget({
    Key? key,
    required this.iconData,
    required this.iconColor,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRadiusSmall))),
      clipBehavior: Clip.antiAlias,
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}
