import 'package:get/get.dart';

class AccueilController extends GetxController {
  RxString _vue = "presence".obs;

  RxString get gVue {
    return _vue;
  }

  set sVue(String v) {
    _vue.value = v;
  }
}
