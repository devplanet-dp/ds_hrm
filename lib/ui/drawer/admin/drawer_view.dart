import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/constants/app_assets.dart';
import 'package:ds_hrm/model/drawer_item.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/viewmodel/drawer/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DrawerView extends StatelessWidget {
  Function(int) selectedIndex;

  DrawerView({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerViewModel>.reactive(
      onModelReady: (model) {
        model.setSelectedTool(1);
      },
      builder: (context, model, child) => Drawer(
        child: Material(
          elevation: 0,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: const EdgeInsets.only(right: 12.0),
            children: [
              ListTile(
                leading: Image.asset(kIcDSLogo),
                title: AutoSizeText(
                  'Admin',
                  style: kBodyStyle.copyWith(
                      color: kAltBg,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 8),
                  maxLines: 1,
                ),
                isThreeLine: true,
                subtitle: AutoSizeText(
                  'Divisional Secretariat',
                  style: kCaptionStyle.copyWith(fontSize: 8, color: kAltBg),
                ),
              ),
              verticalSpaceSmall,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    model.drawerTools.length,
                    (index) => DrawerWidget(
                        item: model.drawerTools[index],
                        onTapped: () {
                          selectedIndex(index);
                          model.setSelectedTool(model.drawerTools[index].id);
                        },
                        isSelected:
                            model.isToolSelected(model.drawerTools[index].id))),
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
      viewModelBuilder: () => DrawerViewModel(),
    );
  }

  Widget _buildDrawerSubHeader(String title) => Padding(
        padding: fieldPadding,
        child: AutoSizeText(
          title,
          style: kBodyStyle.copyWith(color: kAltWhite),
          maxLines: 1,
        ),
      );
}

class DrawerWidget extends StatefulWidget {
  final DrawerItem item;
  final VoidCallback onTapped;
  final bool isSelected;

  const DrawerWidget({
    Key? key,
    required this.item,
    required this.onTapped,
    required this.isSelected,
  }) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (isHovering) {
        setState(() {
          _isHovering = isHovering;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(kRadiusLarge * 2),
              bottomRight: Radius.circular(kRadiusLarge * 2)),
          color: widget.isSelected
              ? kcPrimaryColorLight.withOpacity(0.4)
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        child: ListTile(
          onTap: widget.onTapped,
          leading: Icon(
            widget.item.icon,
            color: widget.isSelected
                ? kcPrimaryColorDark.withOpacity(0.4)
                : kAltBg.withOpacity(0.5),
          ),
          title: AutoSizeText(
            widget.item.title,
            maxLines: 1,
            style: kBodyStyle.copyWith(
                fontWeight:
                    widget.isSelected ? FontWeight.w800 : FontWeight.w200,
                color: widget.isSelected
                    ? kcPrimaryColorDark.withOpacity(0.4)
                    : kAltBg),
          ),
        ),
      ),
    );
  }
}
