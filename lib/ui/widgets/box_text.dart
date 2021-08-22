import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;

  const BoxText.headingOne(this.text, {TextAlign align = TextAlign.start})
      : style = kHeading1Style,
        alignment = align;
  const BoxText.headingTwo(this.text, {TextAlign align = TextAlign.start})
      : style = kHeading2Style,
        alignment = align;
  const BoxText.headingThree(this.text, {TextAlign align = TextAlign.start})
      : style = kHeading3Style,
        alignment = align;
  const BoxText.headline(this.text, {TextAlign align = TextAlign.start})
      : style = kHeadlineStyle,
        alignment = align;
  const BoxText.subheading(this.text, {TextAlign align = TextAlign.start})
      : style = kSubheadingStyle,
        alignment = align;
  const BoxText.caption(this.text, {TextAlign align = TextAlign.start})
      : style = kCaptionStyle,
        alignment = align;

  BoxText.body(this.text,
      {Color color = kcMediumGreyColor, TextAlign align = TextAlign.start})
      : style = kBodyStyle.copyWith(color: color),
        alignment = align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}