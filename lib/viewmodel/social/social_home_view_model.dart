import 'package:ds_hrm/model/social_member.dart';
import 'package:ds_hrm/model/social_member.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';
import '../../model/employee.dart';
import '../../services/firestore_service.dart';

class SocialHomeViewModel extends BaseModel{
  final _firestoreService = locator<FirestoreService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  final searchTEC = TextEditingController();

  String _searchKey = '';

  List<SocialMember> _member = [];

  List<SocialMember> get member => _member;

  bool get isSearch => _searchKey.isNotEmpty;

  SearchType _selectedSearchType = SearchType.nic;

  SearchType get selectedSearchType => _selectedSearchType;

  onSearchTypeSelected(SearchType type) {
    _selectedSearchType = type;
    notifyListeners();
  }

  onValueChanged(String value) {
    _searchKey = value;
    notifyListeners();
  }

  Stream<List<SocialMember>> streamMembers() =>
      _firestoreService.streamMembers(_searchKey,_selectedSearchType);

  //endregion

  @override
  void dispose() {
    searchTEC.dispose();
    super.dispose();
  }

}