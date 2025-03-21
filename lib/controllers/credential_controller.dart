import 'package:batt_mobile/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/intro_screens/login_screen.dart';
import 'package:get/get.dart';


final CredentialController credentialController = CredentialController();

class CredentialController extends GetxController {
  String phone = "";
  bool acceptPrivacyPolicy = false;

  storePhoneNumber(String val) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('phone', val);
      phone = prefs.getString('phone') ?? "";
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getUserUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone') ?? "";
     acceptPrivacyPolicy = prefs.getBool('privacy_polcy') ?? false;
    update();

    if (phone != "") {
      Get.find<AuthController>().fetchUserdetails(true, true);
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  logoutUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('phone', "");
      phone = prefs.getString('phone') ?? "";
      update();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      print(e.toString());
    }
  }


    updatePrivacyPolicy(bool val) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('privacy_polcy', val);
      acceptPrivacyPolicy = prefs.getBool('privacy_polcy') ?? false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

}
