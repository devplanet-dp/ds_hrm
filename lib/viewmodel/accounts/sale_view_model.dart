import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/branch.dart';
import 'package:ds_hrm/model/item.dart';
import 'package:ds_hrm/model/sale.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/utils/app_utils.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../locator.dart';

class SaleViewModel extends BaseModel {
//services
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _fireService = locator<FirestoreService>();

  final formKey = GlobalKey<FormState>();
  final saleFormKey = GlobalKey<FormState>();

  ///text controller
  final nameTEC = TextEditingController();
  final designationTEC = TextEditingController();
  final branchTEC = TextEditingController();
  final dateTEC = TextEditingController();
  final itemTEC = TextEditingController();
  final requestedAmtTEC = TextEditingController();
  final issuedAmtTEC = TextEditingController();
  final fileNoTEC = TextEditingController();
  final remarkTEC = TextEditingController();

  initForm() {
    dateTEC.text =
        getFormattedDate(Timestamp.fromDate(selectedDate), showTime: false);
    notifyListeners();
  }

  //date
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    dateTEC.text =
        getFormattedDate(Timestamp.fromDate(selectedDate), showTime: false);
    notifyListeners();
  }

  List<Branch> _branch = [];

  List<Branch> get branch => _branch;

  List<Item> _items = [];

  List<Item> get items => _items;

  Item? _selectedItem;

  Item? get selectedItem => _selectedItem;

  onItemSelected(Item i) {
    _selectedItem = i;
    notifyListeners();
  }

  Branch? _selectedBranch;

  Branch? get selectedBranch => _selectedBranch;

  onBranchSelected(Branch i) {
    _selectedBranch = i;
    notifyListeners();
  }

  //region education
  List<SaleItem> _saleItems = [];

  List<SaleItem> get saleItem => _saleItems;

  void createSale() async {
    if (saleItem.isEmpty) {
      showSnack(title: 'Sorry', message: 'Please add a item');
      return;
    }

    setBusy(true);
    Sale s = Sale(
      id: Uuid().v4(),
      name: nameTEC.text,
      designation: designationTEC.text,
      branchId: selectedBranch?.id ?? 'N/A',
      createdAt: Timestamp.fromDate(selectedDate),
      fileNo: fileNoTEC.text,
      branchName: selectedBranch?.name ?? 'N/A',
    );

    var result = await _fireService.createSale(sale: s, saleItems: saleItem);
    setBusy(false);
    if (!result.hasError) {
      _dialogService.showDialog(
          title: 'Success', description: 'Sale added successfully!');
    } else {
      _dialogService.showDialog(
          title: 'Sorry', description: result.errorMessage);
    }
  }

  void addSaleItem() {
    SaleItem e = SaleItem(
        name: selectedItem?.name ?? '',
        id: selectedItem?.id ?? '',
        issuedAmount: issuedAmtTEC.text,
        requestedAmount: requestedAmtTEC.text);

    _saleItems.add(e);
    _resetSaleFields();
    notifyListeners();
  }

  void removeSaleItem(String id) {
    _saleItems.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  bool validateItemStock() {
    if (selectedItem == null) return false;
    try {
      if (selectedItem!.amount < int.parse(issuedAmtTEC.text)) {
        showSnack(title: 'Sorry',
            message: '${selectedItem!.name} only have ${selectedItem!
                .amount} available.');

        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
    return false;
  }

  void _resetSaleFields() {
    _selectedItem = null;
    fileNoTEC.text = '';
    requestedAmtTEC.text = '';
    issuedAmtTEC.text = '';
    notifyListeners();
  }

  Future<List<Item>> fetchAvailableItems(String filter) async {
    setBusy(true);

    var result = await _fireService.getAllItems(filter);

    if (!result.hasError) {
      _items.clear();
      _items = result.data;

      ///remove already selected items
      saleItem.forEach((item) {
        _items.removeWhere((element) => element.id == item.id);
      });
    } else {
      await _dialogService.showDialog(
        title: 'Oops',
        description: 'Something went wrong!',
      );
    }

    setBusy(false);
    return _items;
  }

  Future<List<Branch>> fetchAvailableBranches(String filter) async {
    setBusy(true);

    var result = await _fireService.getAllBranches(filter);

    if (!result.hasError) {
      _branch.clear();
      _branch = result.data;
    } else {
      await _dialogService.showDialog(
        title: 'Oops',
        description: result.errorMessage,
      );
    }

    setBusy(false);
    return _branch;
  }

  addBranches() async {
    setBusy(true);
    List<Branch> br = [
      Branch(id: Uuid().v1(), name: 'Admin', query: 'admin'),
      Branch(id: Uuid().v1(), name: 'Land', query: 'land'),
      Branch(id: Uuid().v1(), name: 'Accounts', query: 'accounts'),
    ];
    br.forEach((element) {
      _fireService.createBranch(element);
    });
    setBusy(false);
  }
}
