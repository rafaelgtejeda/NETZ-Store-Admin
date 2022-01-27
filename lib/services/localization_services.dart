import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:netzstore/lang/en_US.dart';
import 'package:netzstore/lang/pt_br.dart';

class LocalizationService extends Translations {
  static const local = Locale('en', 'US');
  static const fallBackLocale = Locale('en', 'US');

  static final langs = ['Português brasileiro', 'Inglês'];
  static const locales = [Locale('pt', 'BR'), Locale('en', 'US')];

  @override
  Map<String, Map<String, String>> get keys => {'pt_BR': ptBR, 'en_US': enUS};

  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  Locale? getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }

    return Get.locale;
  }

  Locale? getCurrentLocale() {
    final box = GetStorage();
    Locale? defaultLocale;

    if (box.read('lng') != null) {
      final locale =
          LocalizationService().getLocaleFromLanguage(box.read('lng'));

      defaultLocale = locale;
    } else {
      defaultLocale = const Locale(
        'pt',
        'BR',
      );
    }

    return defaultLocale;
  }

  String getCurrentLang() {

     final box = GetStorage();

     if (box.read('lng') != null) {
       return box.read('lng');
     } else {
       return "Português brasileiro";
     }

  }
}
