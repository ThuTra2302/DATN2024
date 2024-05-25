import 'package:get/get.dart';

import '../controller/intro_controller.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.put( IntroController());
  }
}
