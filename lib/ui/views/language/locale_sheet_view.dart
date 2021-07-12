import 'package:ds_hrm/constants/app_constants.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/viewmodel/language/locale_sheet_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LocaleSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const LocaleSheetView(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocaleSheetViewModel>.reactive(
      onModelReady: (model) {},
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(kRadiusMedium))),
          child: Padding(
            padding: fieldPadding,
            child: Column(
              children: [
                verticalSpaceMedium,
                Row(
                  children: [
                    Text(
                      'chng_locale',
                      style: kSubheadingStyle,
                    ).tr(),
                    Expanded(
                      child: SizedBox(),
                    ),
                    TextButton(
                      onPressed: () =>
                          completer(SheetResponse(confirmed: false)),
                      child: Text('done').tr(),
                    )
                  ],
                ),
                verticalSpaceMedium,
                _LanguageItem(
                    title: 'English',
                    onTap: () => context.setLocale(EN),
                    isSelected: context.locale == EN),
                verticalSpaceSmall,
                _LanguageItem(
                    title: 'සිංහල',
                    onTap: () => context.setLocale(SI),
                    isSelected: context.locale == SI)
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LocaleSheetViewModel(),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const _LanguageItem(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedTileColor: kcPrimaryColor.withOpacity(0.2),
      selected: isSelected,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRadiusMedium))),
      title: Text(title),
      onTap: onTap,
      trailing: isSelected
          ? Icon(
              Icons.check_circle_outline,
              color: kcPrimaryColor,
            )
          : const SizedBox.shrink(),
    );
  }
}
