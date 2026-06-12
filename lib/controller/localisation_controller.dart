import 'dart:ui';

import 'package:llb_task/data/model/response/languages_model.dart';
import 'package:llb_task/data/repo/localisation_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_constant.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final LocalisationRepo splashRepo;

  LocalizationController(
      {required this.sharedPreferences, required this.splashRepo}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstant.languages[0].languageCode!,
      AppConstant.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    saveLanguage(_locale);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(AppConstant.languagesCode) ??
            AppConstant.languages[0].languageCode!,
        sharedPreferences.getString(AppConstant.countryCode) ??
            AppConstant.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < AppConstant.languages.length; index++) {
      if (AppConstant.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstant.languages);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
        AppConstant.languagesCode, locale.languageCode);
    sharedPreferences.setString(AppConstant.countryCode, locale.countryCode!);
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = [];
      _languages = AppConstant.languages;
    } else {
      _selectedIndex = -1;
      _languages = [];
      AppConstant.languages.forEach((language) async {
        if (language.languageName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          _languages.add(language);
        }
      });
    }
    update();
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }

  bool? showIntro() {
    return splashRepo.showIntro();
  }

  bool isLanguageSelected() {
    return splashRepo.isLanguageSelected();
  }
}
