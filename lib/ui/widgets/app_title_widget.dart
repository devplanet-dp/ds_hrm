import 'package:flutter/material.dart';
import 'package:ds_hrm/constants/app_constants.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';

class AppTitleWidget extends StatelessWidget {
  final bool isDark;
  final bool isLarge;

  const AppTitleWidget({Key? key, required this.isDark, required this.isLarge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: isDark ? kAltWhite : kAltBg,
          radius: 24,
          child: Text(APP_INITIAL,
              style: isLarge
                  ? Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? kcPrimaryColor : Colors.white)
                  : Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.black : Colors.white)),
        ),
        Text(' $APP_LAST',
            style: isLarge
                ? Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? kAltWhite : kAltBg)
                : Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.black : kAltBg))
      ],
    );
  }
}
