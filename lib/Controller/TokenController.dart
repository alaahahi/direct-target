import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenController extends GetxController {
  var token = ''.obs;
  var isTokenValid = false.obs;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadToken();
    ever(token, (_) {
      update();
    });
  }


  void loadToken() {
    var storedToken = storage.read('token');
    if (storedToken != null && storedToken is String && storedToken.isNotEmpty) {
      token.value = storedToken;
      isTokenValid.value = true;
    } else {
      token.value = '';
      isTokenValid.value = false;
    }
  }

  void saveToken(RxString  newToken) {
    storage.write('token', newToken);
    token.value = newToken.value;
    isTokenValid.value = true;
  }


  void logout() {
    storage.remove('token');
    token.value = '';
    isTokenValid.value = false;
  }

  String getToken() {
    return token.value;
  }
}
