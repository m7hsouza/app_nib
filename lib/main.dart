import 'package:flutter/material.dart' show runApp;
import 'package:timeago/timeago.dart' as timeago;

import 'package:app_nib/src/app_widget.dart';

void main() {
  timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());
  runApp(const AppWidget());
}
