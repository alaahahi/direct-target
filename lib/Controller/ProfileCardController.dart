import 'package:get/get.dart';
import '../Model/ProfileCardModel.dart';
import '../Service/ProfileCardServices.dart';


class ProfileCardController extends GetxController {
  var isLoading = true.obs;
  var cardsList = <ProfileData>[].obs;
  var selectedCardId = 0.obs;
  final Profileservices _cardService = Profileservices();
  var cardId = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCards();
  }

  void fetchCards() async {
    try {
      isLoading(true);
      var cards = await _cardService.fetchCards();
      cardsList.assignAll(cards);
      if (cardsList.isNotEmpty) {
        selectedCardId.value = cardsList[0].cardId ?? 0;
        print(selectedCardId.value);
      } else {
        print("No cards found");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
  void updateProfile(Map<String, dynamic> profileData) async {

    try {
      isLoading(true);
      bool isUpdated = await _cardService.updateProfile(profileData);
      if (isUpdated) {
        print("Profile updated successfully in the controller!");
      } else {
        print("Failed to update profile.");
      }
    } catch (e) {
      print("Error in updateProfile: $e");
    } finally {
      isLoading(false);
    }
  }


}

