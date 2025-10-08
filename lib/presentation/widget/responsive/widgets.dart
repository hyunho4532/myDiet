import 'dart:io';

import 'package:flutter/foundation.dart';

class Widgets {
  int i() {
    if (kIsWeb) {
      return 3;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return 3;
    } else {
      throw Exception();
    }
  }
}