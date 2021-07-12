import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';

class AvatarView extends StatelessWidget {
  final double height;
  final double widget;
  final String path;
  final String userName;
  final BoxFit fit;
  const AvatarView(
      {Key? key,
      this.height = 48,
      this.widget = 48,
      required this.path,
      required this.userName, this.fit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: CircleBorder(),
      child: Container(
        decoration: BoxDecoration(
            color: kcPrimaryColor,
            borderRadius: BorderRadius.circular(kRadiusMedium)),
        height: height,
        width: widget,
        child: path == null || path.isEmpty
            ? _buildLetter(context)
            : _buildProfileImageView(context, path),
      ),
    );
  }

  Widget _buildProfileImageView(BuildContext context, String url) => ClipRRect(
        borderRadius: BorderRadius.circular(kRadiusMedium),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          placeholder: (context, url) => _buildLetter(context),
          errorWidget: (context, url, error) => _buildLetter(context),
        ),
      );

  Widget _buildLetter(BuildContext context) => Center(
        child: Text(
          userName[0],
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.bold, color: kcAccent),
        ),
      );
}
