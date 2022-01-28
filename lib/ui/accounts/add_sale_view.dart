import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ds_hrm/model/branch.dart';
import 'package:ds_hrm/model/item.dart';
import 'package:ds_hrm/model/sale.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/views/staff/staff_view.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/ui/widgets/text_field_widget.dart';
import 'package:ds_hrm/viewmodel/accounts/sale_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddSaleView extends StatelessWidget {
  const AddSaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SaleViewModel>.reactive(
      onModelReady: (_) {
        _.initForm();
      },
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Icon(
              Icons.supervised_user_circle_outlined,
              color: kAltBg,
            ),
            title: Text(
              'Add a sale',
              style: kHeading3Style.copyWith(
                  fontWeight: FontWeight.w800, color: kAltBg),
            ),
            centerTitle: false,
            elevation: 1,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActionChip(
                  label: Text(
                    'submit'.toUpperCase(),
                    style: kBodyStyle.copyWith(
                        color: kAltWhite, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (model.formKey.currentState!.validate()) {
                      model.createSale();
                    }
                  },
                  backgroundColor: kcPrimaryColorLight,
                ),
              )
            ],
          ),
          body: ListView(
            padding: fieldPaddingAll,
            children: [
              Form(
                key: model.formKey,
                child: FormSection(
                    index: 1,
                    sectionTitle: 'General Information',
                    input: _buildGeneralInfoInput(context, model)),
              ),
              verticalSpaceSmall,
              Form(
                key: model.saleFormKey,
                child: FormSection(
                    index: 1,
                    sectionTitle: 'Item Information',
                    input: _buildItemInput(context, model)),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SaleViewModel(),
    );
  }

  Widget _buildGeneralInfoInput(BuildContext context, SaleViewModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: ItemText(
                title: 'Name',
                controller: model.nameTEC,
              )),
              horizontalSpaceSmall,
              Expanded(
                  child: ItemText(
                title: 'Designation',
                controller: model.designationTEC,
              ))
            ],
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(child: _buildBranchSearch(model)),
              horizontalSpaceSmall,
              Expanded(
                  child: InkWell(
                onTap: () => _showDatePicker(context, model),
                child: ItemText(
                  title: 'Date',
                  controller: model.dateTEC,
                  readOnly: true,
                ),
              ))
            ],
          ),
          verticalSpaceSmall,
        ],
      );

  Widget _buildItemInput(BuildContext context, SaleViewModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildItemSearch(model),
                horizontalSpaceSmall,
                ItemText(
                  title: 'File No',
                  controller: model.fileNoTEC,
                ),
                verticalSpaceSmall,
                ItemText(
                  title: 'Requested amount',
                  controller: model.requestedAmtTEC,
                ),
                horizontalSpaceSmall,
                ItemText(
                  title: 'Issued amount',
                  controller: model.issuedAmtTEC,
                ),
                verticalSpaceSmall,
                ActionChip(
                    backgroundColor: kcPrimaryColorDark,
                    label: Text(
                      'ADD',
                      style: kBodyStyle.copyWith(
                          color: kAltWhite, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (model.saleFormKey.currentState!.validate()) {
                        if (model.validateItemStock()) {
                          model.addSaleItem();
                        }
                      }
                    }),
                verticalSpaceMedium,
              ],
            ),
          ),
          Expanded(
            child: _buildAddedSales(model),
          )
        ],
      );

  _buildBranchSearch(SaleViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Branch',
          style: kBodyStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpaceSmall,
        DropdownSearch<Branch>(
          mode: Mode.DIALOG,
          items: model.branch,
          isFilteredOnline: true,
          showClearButton: true,
          showSelectedItems: true,
          compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
          showSearchBox: true,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (u) => u == null ? "Branch field is required " : null,
          onFind: (String? filter) async {
            return await model.fetchAvailableBranches(filter ?? '');
          },
          itemAsString: (Branch? u) => u!.name,
          onChanged: (Branch? data) => model.onBranchSelected(data!),
        ),
      ],
    );
  }

  _buildItemSearch(SaleViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item',
          style: kBodyStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpaceSmall,
        DropdownSearch<Item>(
          mode: Mode.DIALOG,
          items: model.items,
          isFilteredOnline: true,
          showClearButton: true,
          showSelectedItems: true,
          compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
          showSearchBox: true,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (u) => u == null ? "Items field is required " : null,
          onFind: (String? filter) async {
            return await model.fetchAvailableItems(filter ?? '');
          },
          itemAsString: (Item? u) => '${u!.name} - ${u.amount}',
          onChanged: (Item? data) => model.onItemSelected(data!),
        ),
      ],
    );
  }

  Widget _buildAddedSales(SaleViewModel _) => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _.saleItem.length,
        itemBuilder: (__, index) {
          SaleItem e = _.saleItem[index];
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: kBorderSmall),
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundColor: kcPrimaryColorLight,
              child: Text(
                e.name![0],
                style: kCaptionStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            title: AutoSizeText(
              e.name ?? '',
              maxLines: 1,
            ),
            subtitle: AutoSizeText(
              e.requestedAmount ?? '',
              maxLines: 1,
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => _.removeSaleItem(e.id ?? ''),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            verticalSpaceSmall,
      );

  _showDatePicker(BuildContext context, SaleViewModel _) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _.selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _.selectedDate) _.setSelectedDate(picked);
  }
}

class ItemText extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isNumber;
  final bool isMandatory;
  final bool isTextArea;
  final bool readOnly;
  final bool isDark;

  const ItemText(
      {Key? key,
      required this.title,
      required this.controller,
      this.isNumber = true,
      this.isMandatory = true,
      this.isTextArea = false,
      this.readOnly = false,
      this.isDark = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kBodyStyle.copyWith(
              fontWeight: FontWeight.bold, color: isDark ? kAltWhite : kAltBg),
        ),
        verticalSpaceSmall,
        AppTextField(
          isEnabled: !readOnly,
          isTextArea: isTextArea,
          minLine: isTextArea ? 5 : 1,
          isNumber: isNumber,
          isCapitalize: false,
          borderColor:
              isDark ? kAltWhite.withOpacity(.4) : kAltBg.withOpacity(0.4),
          fillColor: Colors.transparent,
          isDark: isDark,
          controller: controller,
          hintText: 'Enter $title',
          validator: (value) {
            if (!isMandatory) {
              return null;
            }
            if (value!.isEmpty) {
              return '$title can not be empty';
            } else {
              return null;
            }
          },
        )
      ],
    );
  }
}
