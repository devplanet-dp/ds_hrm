import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/model/item.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/app_stream_list.dart';
import 'package:ds_hrm/ui/widgets/busy_button.dart';
import 'package:ds_hrm/ui/widgets/text_field_widget.dart';
import 'package:ds_hrm/ui/widgets/tile_widget.dart';
import 'package:ds_hrm/utils/app_utils.dart';
import 'package:ds_hrm/viewmodel/accounts/item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemViewModel>.reactive(
      onModelReady: (model)=>model.onValueChanged(''),
      builder: (context, model, child) => ResponsiveBuilder(
        builder: (_, size) {
          return Scaffold(
            body: Padding(
              padding: fieldPaddingAll,
              child: SingleChildScrollView(
                controller: model.scrollController,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: kAltBg,
                          borderRadius:
                          BorderRadius.all(Radius.circular(kRadiusMedium))),
                      child: Padding(
                        padding: fieldPaddingAll * 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Form(
                                key: model.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        Text(
                                          model.isUpdate
                                              ? 'Update item here'
                                              : 'Add item here',
                                          style: kHeading3Style.copyWith(
                                              color: kAltWhite,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        Visibility(
                                          visible: model.isUpdate,
                                          child: InkWell(
                                            onTap: () =>
                                                model.setUpdateView(false),
                                            child: const CircleAvatar(
                                              backgroundColor: kAltWhite,
                                              child: Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.close,
                                                  color: kAltBg,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    ItemText(
                                      title: 'Item name',
                                      controller: model.nameTEC,
                                      isDark: true,
                                    ),
                                    verticalSpaceMedium,
                                    ItemText(
                                      title: 'Issuer name',
                                      controller: model.issuerNameTEC,
                                      isDark: true,
                                    ),
                                    verticalSpaceMedium,
                                    Row(
                                      children: [
                                        Expanded(
                                            child: ItemText(
                                              title: 'Unit Price',
                                              controller: model.priceTEC,
                                              isDark: true,
                                            )),
                                        horizontalSpaceSmall,
                                        Expanded(
                                            child: ItemText(
                                              title: 'Amount',
                                              controller: model.amountTEC,
                                              isDark: true,
                                            )),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    BoxButtonWidget(
                                        buttonText: model.isUpdate
                                            ? 'Update'
                                            : 'Add Item',
                                        buttonColor: kcPrimaryColor,
                                        isLoading: model.busy,
                                        onPressed: () {
                                          if (!model.busy) {
                                            if (model.formKey.currentState!
                                                .validate()) {
                                              model.isUpdate
                                                  ? model.updateItem()
                                                  : model.createItem();
                                            }
                                          }
                                        })
                                  ],
                                ),
                              ),
                            ),
                            horizontalSpaceMedium,
                            Expanded(
                              flex: 3,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: model.isUpdate
                                    ? EmptyBox
                                    : _buildTiles(model),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    _buildStockItems(model)
                  ],
                ),
              ),
            ),
          );
        },
      ),
      viewModelBuilder: () => ItemViewModel(),
    );
  }

  Row _buildTiles(ItemViewModel model) {
    return Row(
      children: [
        Expanded(
            child: TileWidget(
              subHeader: "Total items",
              isDark: model.isDark(),
              onTap: () {},
              icon: Icons.insert_drive_file_outlined,
              primaryColor: CupertinoColors.systemBlue,
              header: _buildTotalItems(model.allItemsStream()),
            )),
        horizontalSpaceMedium,
        Expanded(
            child: TileWidget(
              subHeader: 'Sales',
              isDark: model.isDark(),
              onTap: () {},
              icon: Icons.work_outline,
              primaryColor: CupertinoColors.systemTeal,
              header: Text(
                '0',
                style: kHeading1Style.copyWith(
                    fontWeight: FontWeight.bold, color: kAltWhite),
              ),
            )),
        horizontalSpaceMedium,
        Expanded(
            child: TileWidget(
              subHeader: 'Purchase',
              isDark: model.isDark(),
              onTap: () {},
              icon: Icons.add_business_outlined,
              primaryColor: CupertinoColors.activeGreen,
              header: Text(
                '0',
                style: kHeading1Style.copyWith(
                    fontWeight: FontWeight.bold, color: kAltWhite),
              ),
            ))
      ],
    );
  }

  Widget _buildTotalItems(Stream<List<Item>> stream) =>
      StreamBuilder<List<Item>>(
          stream: stream,
          builder: (_, snapshot) => Text(
            '${snapshot.data?.length ?? 0}',
            style: kHeading1Style.copyWith(
                fontWeight: FontWeight.bold, color: kAltWhite),
          ));

  _buildStockItems(ItemViewModel model) => Column(
    children: [
      SizedBox(
        width: Get.width / 3,
        child: AppTextField(
          controller: model.searchItemTEC,
          borderColor: kBgDark.withOpacity(0.4),
          fillColor: Colors.transparent,
          hintText: 'Search items here..',
          prefixIcon: const Icon(Icons.search),
          onChanged: model.onValueChanged,
        ),
      ),
      verticalSpaceMedium,
      const _TableHeaders(),
      verticalSpaceSmall,
      AppStreamList(
          stream: model.searchItems(),
          itemBuilder: (index, emp) {
            Item u = emp as Item;
            bool _isSelected = u.id == model.selectedItem?.id;
            return InkWell(
              onTap: () => model.setSelectedItem(u),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(kRadiusMedium)),
                          color: _isSelected
                              ? kcPrimaryColorLight.withOpacity(0.2)
                              : Colors.transparent),
                      children: [
                        TableContent(value: u.name),
                        TableContent(value: u.price),
                        TableContent(value: u.issuedAmount.toString()),
                        TableContent(value: u.amount.toString()),
                        TableContent(
                            value: getFormattedDate(u.createdAt)),
                        TableContent(
                            value: getFormattedDate(u.lastUpdated)),
                      ])
                ],
              ),
            );
          },
          emptyIcon: Icons.supervised_user_circle_outlined,
          emptyText: 'No items found',
          separator: EmptyBox,
          isDark: model.isDark())
    ],
  );
}

class _TableHeaders extends StatelessWidget {
  const _TableHeaders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
      },
      children: const [
        TableRow(children: [
          TableHeader(title: 'Name'),
          TableHeader(title: 'Unit price'),
          TableHeader(title: 'Issued'),
          TableHeader(title: 'Available'),
          TableHeader(title: 'Created at'),
          TableHeader(title: 'Last updated'),
        ])
      ],
    );
  }
}

class TableHeader extends StatelessWidget {
  final String title;

  const TableHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        title,
        style: kBodyStyle.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
    );
  }
}

class TableContent extends StatelessWidget {
  final String value;
  final bool isSelected;

  const TableContent({Key? key, required this.value, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: fieldPaddingAll,
      child: AutoSizeText(
        value,
        maxLines: 1,
        textAlign: TextAlign.start,
      ),
    );
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
