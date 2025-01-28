import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenController extends GetxController {
  var token = ''.obs;
  var isTokenValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadToken();
    getToken();
  }
  void loadToken() {
    var storedToken = GetStorage().read('token');
    if (storedToken != null && storedToken is String) {
      token.value = storedToken;
      isTokenValid.value = token.value.isNotEmpty;
    } else {
      token.value = '';
      isTokenValid.value = false;
    }
  }

  void saveToken(String newToken) {
    GetStorage().write('token', newToken);
    token.value = newToken;
    isTokenValid.value = newToken.isNotEmpty;
  }
  String getToken() {
    return token.value;
  }
}
