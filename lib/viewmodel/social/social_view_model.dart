import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/donation_type.dart';
import 'package:ds_hrm/model/social_member.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../locator.dart';
import '../../model/division.dart';
import '../../model/employee.dart';
import '../../services/firestore_service.dart';

class SocialViewModel extends BaseModel{
  //services
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  final formKey = GlobalKey<FormState>();

  Division? _selectedDivision;
  DonationType? _selectedDonation;

  Future addFireValues()async{
    setBusy(true);
    await _firestoreService.addFireValues();
    setBusy(false);
  }

  final firstNameTEC = TextEditingController();
  final dobTEC = TextEditingController();
  final nicTEC = TextEditingController();
  final addressTEC = TextEditingController();
  final divisionTEC = TextEditingController();
  final donationTypeTEC = TextEditingController();
  final mobileTEC = TextEditingController();

  //region division
  List<Division> _devDivision = [];

  List<Division> get devDivision => _devDivision;

  void setDivision(Division value) {
    divisionTEC.text = value.title;
    _selectedDivision = value;
    notifyListeners();
    _navigationService.back();
  }

  Future getDevDivisions() async {
    setBusy(true);
    var result =
    await _firestoreService.getDivisions(FirestoreService.TB_GN_DIVISION);
    setBusy(false);
    if (!result.hasError) {
      _devDivision = result.data as List<Division>;
      notifyListeners();
    } else {
      _dialogService.showDialog(
          title: 'Oops', description: result.errorMessage);
    }
  }

  List<DonationType> _devDonationType = [];

  List<DonationType> get devDonationType => _devDonationType;

  void setDonation(DonationType value) {
    donationTypeTEC.text = value.title??'';
    _selectedDonation = value;
    notifyListeners();
    _navigationService.back();
  }

  Future getDonationTypes() async {
    setBusy(true);
    var result =
    await _firestoreService.getDonationTypes();
    setBusy(false);
    if (!result.hasError) {
      _devDonationType = result.data as List<DonationType>;
      notifyListeners();
    } else {
      _dialogService.showDialog(
          title: 'Oops', description: result.errorMessage);
    }
  }

//endregion

  ///region dob
  late DateTime _dob;

  DateTime get dob => _dob;

  void setDOB(DateTime? dateTime) {
    _dob = dateTime!;
    dobTEC.text = '${dateTime.year}/${dateTime.month}/${dateTime.day}';
    notifyListeners();
  }

  ///endregion

  //region gender
  Gender _gender = Gender.Male;

  Gender get selectedGender => _gender;

  bool isGenderSelected(Gender type) => selectedGender == type;

  void setGender(Gender type) {
    _gender = type;
    notifyListeners();
  }

  Future addMember() async {
    setBusy(true);
    SocialMember e = SocialMember(
        id: Uuid().v4(),
        name: firstNameTEC.text,
        nic: nicTEC.text,
        dob: Timestamp.fromDate(dob),
        address: addressTEC.text,
        createdAt: Timestamp.now(),
        mobile: mobileTEC.text,
        gnDivision: _selectedDivision,
        donationType: _selectedDonation,
        searchName: '${(firstNameTEC.text.toLowerCase().trim() +
            nicTEC.text.toLowerCase().trim()).replaceAll(' ','')}');

    var result = await _firestoreService.createSocialMember(
        member: e);
    setBusy(false);
    if (!result.hasError) {
      _dialogService.showDialog(
          title: 'Success', description: 'Member added successfully!');
      _resetView();
    } else {
      _dialogService.showDialog(
          title: 'Sorry', description: result.errorMessage);
    }
  }
//endregion
  void _resetView() {
    firstNameTEC.text = '';
    dobTEC.text = '';
    nicTEC.text = '';
    addressTEC.text = '';
    divisionTEC.text = '';
    mobileTEC.text = '';
    donationTypeTEC.text='';
    notifyListeners();
  }

  @override
  void dispose() {
    firstNameTEC.dispose();
    dobTEC.dispose();
    nicTEC.dispose();
    addressTEC.dispose();
    divisionTEC.dispose();
    donationTypeTEC.dispose();

    super.dispose();
  }
}