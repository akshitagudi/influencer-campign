import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final String validUsername = 'influencer_001';
  final String validPassword = 'influencer123';

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 1));

    if (username == validUsername && password == validPassword) {
      isLoading.value = false;
      return true;
    } else {
      isLoading.value = false;
      return false;
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
