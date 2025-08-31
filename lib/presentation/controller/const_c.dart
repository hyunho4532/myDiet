import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ConstController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  var types = "TYPE_DIET".obs;

  void onSelected(String type) {
    types.value = type;
  }
}