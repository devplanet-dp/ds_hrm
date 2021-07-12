import 'package:flutter/material.dart';

import 'app_colors.dart';

// Box Decorations

BoxDecoration fieldDecortaion =
    BoxDecoration(borderRadius: BorderRadius.circular(5), color: kAltBg);

BoxDecoration disabledFieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets fieldPaddingAll = const EdgeInsets.all(12.0);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

//Radius
const double kRadiusSmall = 4;
const double kRadiusMedium = 12;
const double kRadiusLarge = 18;
const double kRadiusAvatar = 40.0;

///border radius
BorderRadius kBorderSmall = BorderRadius.all(Radius.circular(kRadiusSmall));
BorderRadius kBorderMedium = BorderRadius.all(Radius.circular(kRadiusMedium));
BorderRadius kBorderLarge = BorderRadius.all(Radius.circular(kRadiusLarge));



/// text themes
// To make it clear which weight we are using, we'll define the weight even for regular
// fonts
const TextStyle kHeading1Style = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w400,
);

const TextStyle kHeading2Style = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
);

const TextStyle kHeading3Style = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
);

const TextStyle kHeadlineStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
);

const TextStyle kBodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
);

const TextStyle kSubheadingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
);

const TextStyle kCaptionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
);
const Widget EmptyBox = SizedBox.shrink();

//shaders
final Shader goldGradient = LinearGradient(
    colors: <Color>[Color(0xFFfcf29f), Color(0xFFe5c469)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
