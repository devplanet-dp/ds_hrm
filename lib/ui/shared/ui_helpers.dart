import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ds_hrm/ui/widgets/brand_bg_widget.dart';

import 'app_colors.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 80.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    const Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

extension CustomContext on BuildContext {
  double screenHeight({double percent = 1}) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth({double percent = 1}) =>
      MediaQuery.of(this).size.width * percent;
}

Widget emptyBox() => const SizedBox.shrink();

AppBar noTitleAppBar({bool isLight = true, bool leading = true}) {
  return AppBar(
    automaticallyImplyLeading: leading,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: isLight ? kcPrimaryColor : kAltWhite),
    elevation: 0,
    brightness: isLight ? Brightness.light : Brightness.dark,
  );
}


class ShimmerWidget extends StatelessWidget {
  final bool isCircle;

  const ShimmerWidget({
    Key? key,
    required this.isCircle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: isCircle
            ? CircleAvatar(
          radius: 30,
          backgroundColor: kcMediumGreyColor,
        )
            : SizedBox(
          height: 20,
          width: 50,
        ),
        baseColor: kcMediumGreyColor,
        highlightColor: kAltBg);
  }
}
class ShimmerView extends StatelessWidget {
  const ShimmerView({
    Key? key,
    required this.thumbHeight,
    required this.thumbWidth,
  }) : super(key: key);

  final double thumbHeight;
  final double thumbWidth;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: kAltBg,
        highlightColor: kAltBg.withOpacity(0.2),
        child: Container(
          height: thumbHeight,
          width: thumbWidth,
          color: kAltBg,
        ));
  }
}
