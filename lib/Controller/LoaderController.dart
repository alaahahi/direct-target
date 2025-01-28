
import 'package:get/get.dart';

class LoaderController extends GetxController {
  var loading = false.obs;

  Future<bool> isLoding(bool load) async {
    return loading.value = load;
  }
}
