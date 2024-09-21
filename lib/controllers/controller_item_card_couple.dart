import 'package:get/get.dart';

class ContainerController extends GetxController {
  var isExpanded = false.obs;
  var selectedIndex = 0.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }

  void onAvatarTap(int index) {
    selectedIndex.value = index;
  }
}
