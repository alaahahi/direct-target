
import 'package:get/get.dart';

class LoaderController extends GetxController {
  var loading = false.obs;

  Future<bool> isLoading(bool load) async {
    return loading.value = load;
  }
}
