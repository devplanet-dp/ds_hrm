import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class TaxViewModel extends BaseModel{
//services
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  final formKey = GlobalKey<FormState>();


  ///text controller
  final nameTEC = TextEditingController();
  final permitNoTEC = TextEditingController();
  final fromTEC = TextEditingController();
  final toTEC = TextEditingController();
  final installmentTEC = TextEditingController();
  final fineRateTEC = TextEditingController();
  final monthDueTEC = TextEditingController();
  final everyTEC = TextEditingController();
  final rateTEC = TextEditingController();
  final lastRevisedTEC = TextEditingController();

  goBack()=>Get.back();

  @override
  void dispose() {
    nameTEC.dispose();
    permitNoTEC.dispose();
    fromTEC.dispose();
    toTEC.dispose();
    installmentTEC.dispose();
    fineRateTEC.dispose();
    monthDueTEC.dispose();
    everyTEC.dispose();
    rateTEC.dispose();
    lastRevisedTEC.dispose();
    super.dispose();
  }
}