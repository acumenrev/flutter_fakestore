import 'dart:ffi';

import 'package:fakestore_main_app/constants/dotenv_constants.dart';
import 'package:fakestore_main_app/extensions/string_extension.dart';
import 'package:fakestore_main_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Map<String, String> appEnv = dotenv.env;

class AppUtils {
  AppUtils._();

  static final AppUtils shared = AppUtils._();

  static AppLocalizations getLocalizationContext(BuildContext context) {
    return AppLocalizations.of(context);
  }

  static viewImages(List<Image> images) {}
}
