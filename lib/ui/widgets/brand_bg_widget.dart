import 'package:flutter/material.dart';

class BrandBgWidget extends StatelessWidget {
  final String imgName;

  const BrandBgWidget({
    Key? key,
    required this.imgName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imgName), fit: BoxFit.cover)));
  }
}
