
import 'package:get/get.dart';
import 'package:my_campus/Controller/controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}

class put {}