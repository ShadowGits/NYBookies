import 'package:flutter/material.dart';

bool checkAuthorisation() {
  //TODO : Firebase authorisation check
}

String timeTypeToStringType(TimeOfDay time, BuildContext context) {
  final MaterialLocalizations localizations = MaterialLocalizations.of(context);
  final String formattedSelectedTime = localizations.formatTimeOfDay(time);
  return formattedSelectedTime;
}
