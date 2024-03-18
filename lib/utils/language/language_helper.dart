import '../constants/exports.dart';

class OLanguageHelper {
  final Locale? locale;

  OLanguageHelper({this.locale});

  static OLanguageHelper? of(BuildContext context) {
    return Localizations.of<OLanguageHelper>(context, OLanguageHelper);
  }

  late Map<String, String> _localStrings;

  static const String _path = 'assets/lang/';

  Future loadJsonFiles() async {
    String encodeString =
    await rootBundle.loadString("$_path${locale!.languageCode}.json");
    Map<String, dynamic> jsonMap = jsonDecode(encodeString);
    _localStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localStrings[key] ?? '';
  }

  static LocalizationsDelegate<OLanguageHelper> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<OLanguageHelper> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<OLanguageHelper> load(Locale locale) async {
    OLanguageHelper appLocal = OLanguageHelper(locale: locale);
    await appLocal.loadJsonFiles();
    return appLocal;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<dynamic> old) {
    return false;
  }
}

extension TranslateString on String {
  String tr(BuildContext context) {
    return OLanguageHelper.of(context)!.translate(this);
  }
}