import 'package:llb_task/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalisationRepo{
  final SharedPreferences sharedPreferences;

  LocalisationRepo({

    required this.sharedPreferences,
  });


  Future<bool> initSharedData() {
    if (!sharedPreferences.containsKey(AppConstant.intro)) {
      sharedPreferences.setBool(AppConstant.intro, true);
    }
    return Future.value(true);
  }

  void disableIntro() {
    sharedPreferences.setBool(AppConstant.intro, false);
  }

  bool? showIntro() {
    return sharedPreferences.getBool(AppConstant.intro);
  }

  bool isLanguageSelected() {
    return sharedPreferences.containsKey(AppConstant.intro);
  }
}