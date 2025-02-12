
import 'package:get/get.dart';
import '../Model/ProfileUserModel.dart';
import '../Service/ProfileUserServices.dart';


class ProfileUserController extends GetxController {
  var isLoading = true.obs;
  var profile = ProfileUserModel().obs;

  final ProfileUserService _profileService = ProfileUserService();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    try {
      isLoading(true);
      var profileData = await _profileService.fetchProfile();
      profile.value = profileData;
        } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
