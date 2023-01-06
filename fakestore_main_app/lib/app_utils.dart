import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppUtils {
  AppUtils._();

  static AppLocalizations getLocalizationContext(BuildContext context) {
    return AppLocalizations.of(context);
  }

  static viewImages(List<Image> images) {}
}
