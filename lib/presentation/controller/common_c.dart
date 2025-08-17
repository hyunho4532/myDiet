import 'package:get/get.dart';
import 'package:mydiet/data/repository/common_r.dart';
import 'package:mydiet/domain/common_code.dart';

// Controller: ViewModel 대체
class CommonCodeController extends GetxController {
  var commons = <CommonCode>[].obs;

  Future<void> fetchCommon(String groupKey) {
    return CommonRepository().fetchCommon(groupKey, (data) {
      commons.value = data.map((e) => CommonCode.fromJson(e)).toList();
    });
  }
}