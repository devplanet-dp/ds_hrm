import 'package:flutter/material.dart';

import '../base_model.dart';

class LocaleSheetViewModel extends BaseModel {
  late Locale _selectedLocale;

  Locale get selectedLocale => _selectedLocale;
}
