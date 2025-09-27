import 'dart:io';

import 'package:flutter/foundation.dart';

class FormatSize {
  double width() {
    if (kIsWeb) {
      return 860;
    }
    else if (Platform.isAndroid || Platform.isIOS) {
      return 360;
    }
    else {
      throw Exception();
    }
  }
}