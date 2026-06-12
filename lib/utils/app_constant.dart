
import 'package:llb_task/data/model/response/languages_model.dart';

class AppConstant {
  static const String appName = 'llb_task';
  static const String dollarSign = '\$';

  static const String languagesCode = 'llb_task_languages';
  static const String countryCode = 'llb_task_countryCode';
  static const String token = 'token';
  static const String intro = 'intro';
  static const String currency = '₹';



  static const String appBaseUrl = 'https://dummyjson.com/';
  static const String getProductsList = 'products';



  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: '',
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      imageUrl: '',
      languageName: 'Arabic',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
  ];
}