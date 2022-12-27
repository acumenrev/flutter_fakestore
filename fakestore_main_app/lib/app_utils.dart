import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppUtils {
  static AppLocalizations getLocalizationContext(BuildContext context) {
    return AppLocalizations.of(context);
  }
}
