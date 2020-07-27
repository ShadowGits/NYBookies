import 'package:flutter/cupertino.dart';

class MyGlobals {
  static GlobalKey _keyForReminderScreen = GlobalKey();
  static GlobalKey get reminderKey => _keyForReminderScreen;
}
