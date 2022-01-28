import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/item.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../locator.dart';

class ItemViewModel extends BaseModel {
  final _dialogService = locator<DialogService>();
  final _fireService = locator<FirestoreService>();

  final searchItemTEC = TextEditingController();
  final priceTEC = TextEditingController();
  final nameTEC = TextEditingController();
  final issuerNameTEC = TextEditingController();
  final amountTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String _searchKey = '';

  bool _isUpdate = false;

  Item? _selectedItem;

  Item? get selectedItem => _selectedItem;

  setSelectedItem(Item item) {
    _selectedItem = item;
    _setItemValues(item);
    setUpdateView(true);
    notifyListeners();
  }

  bool get isUpdate => _isUpdate;

  setUpdateView(bool value) {
    _isUpdate = value;
    if (!value) {
      _clearItemFields();
    }
    notifyListeners();
  }

  onValueChanged(String value) {
    _searchKey = value;
    notifyListeners();
  }

  Stream<List<Item>> searchItems() =>
      _fireService.searchAllItems(searchKey: _searchKey);

  Stream<List<Item>> allItemsStream() =>
      _fireService.searchAllItems(searchKey: '');

  Future createItem() async {
    var item = Item(
        id: const Uuid().v4(),
        name: nameTEC.text,
        price: priceTEC.text,
        issuerName: issuerNameTEC.text,
        query: nameTEC.text.toLowerCase(),
        amount: int.parse(amountTEC.text),
        lastUpdated: Timestamp.now(),
        createdAt: Timestamp.now());
    setBusy(true);

    var result = await _fireService.createItem(item);

    setBusy(false);

    if (result is bool) {
      nameTEC.text = '';
      priceTEC.text = '';
      amountTEC.text = '';
      notifyListeners();
      await _dialogService.showDialog(
        title: 'Success',
        description: 'Item created successfully!',
      );
    } else {
      await _dialogService.showDialog(
        title: 'Oops',
        description: 'Something went wrong!',
      );
    }
  }

  void _setItemValues(Item item) {
    nameTEC.text = item.name;
    priceTEC.text = item.price;
    amountTEC.text = item.price;
    notifyListeners();
  }

  void _clearItemFields() {
    nameTEC.text = "";
    priceTEC.text = "";
    amountTEC.text = "";
    _selectedItem = null;
    notifyListeners();
  }

  Future updateItem() async {
    if (selectedItem == null) {
      return;
    }
    var updatedItem = Item(
        id: selectedItem?.id ?? '',
        name: nameTEC.text,
        price: priceTEC.text,
        query: nameTEC.text.toLowerCase(),
        amount: int.parse(amountTEC.text),
        lastUpdated: Timestamp.now(),
        createdAt: selectedItem?.createdAt ?? Timestamp.now(),
        issuerName: issuerNameTEC.text);
    setBusy(true);

    var result = await _fireService.updateItem(updatedItem);

    setBusy(false);

    if (result is bool) {
      notifyListeners();
      await _dialogService.showDialog(
        title: 'Success',
        description: 'Item updated successfully!',
      );
    } else {
      await _dialogService.showDialog(
        title: 'Oops',
        description: 'Something went wrong!',
      );
    }
  }
}
