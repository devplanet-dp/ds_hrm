import 'package:flutter/material.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';

class AppInfoWidget extends StatelessWidget {
  final String translateKey;
  final IconData iconData;
  final bool isDark;
  final Widget icon;

  const AppInfoWidget(
      {Key? key,
      required this.translateKey,
      required this.iconData,
      required this.isDark,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor:
              !isDark ? kAltWhite : kAltBg.withOpacity(0.8),
          radius: 48,
          child: icon == null
              ? Icon(
                  iconData,
                  size: 32,
                )
              : icon,
        ),
        verticalSpaceMedium,
        Text(
          translateKey,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
