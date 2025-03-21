import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:batt_mobile/controllers/credential_controller.dart';
import 'package:batt_mobile/models/user_model.dart';
import 'package:batt_mobile/screens/intro_screens/login_screen.dart';
import 'package:batt_mobile/screens/intro_screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/home/dashboard_screen.dart';
import '../screens/intro_screens/otp_screen.dart';
import '../utils/api_urls.dart';
import '../utils/common_widgets.dart';
import '../utils/helper.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationCode = "";
  bool authLoader = false;
  bool otpLoader = false;
  bool loginLoader = false;
  bool resendSMS = false;
  UserModel? userData;
  Uint8List? profileImage;
  bool imageLoading = false;
  String loginImage = "";

  String checkApiName(String jsonString) {
    try {
      // Parse the JSON string
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Check if the 'api_name' key exists and contains the word 'Mobile'
      if (jsonData['api_name']?.toString().contains('Mobile') ?? false) {
        return "Mobile number already exists!";
      } else {
        return "Email already exists!";
      }
    } catch (e) {
      // Return false if there is an error in parsing
      return "Duplicate Data!";
    }
  }

  updateLoginLoader() {
    loginLoader = false;
    update();
  }

  //// Send otp on phone number through firebase
  // Future<void> phoneAuthentication(String phone, bool resend) async {
  //   loginLoader = true;
  //   update();

  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       verificationCompleted: (PhoneAuthCredential credential) async {},
  //       verificationFailed: (FirebaseAuthException e) {
  //         loginLoader = false;
  //         update();
  //         if (e.code == 'invalid-phone-number') {
  //           showToast('The provided phone number is not valid.');
  //         }
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         verificationCode = verificationId;
  //         update();
  //         if (!resend) {
  //           countdown = 30;
  //           Get.to(() => OtpScreen(phoneNumber: phone));
  //           resendSMS = false;
  //           update();
  //         } else {
  //           resendSMS = true;
  //           loginLoader = false;
  //           update();
  //         }
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     updateLoginLoader();
  //     switch (e.code) {
  //       case 'invalid-verification-code':
  //         showToast("Incorrect OTP entered. Please try again.");
  //         break;

  //       case 'session-expired':
  //         showToast("The SMS code has expired. Please request a new one.");
  //         break;

  //       case 'quota-exceeded':
  //         showToast(
  //             "SMS quota for this project has been exceeded. Try again later.");
  //         break;

  //       case 'too-many-requests':
  //         showToast("You have made too many requests. Please try again later.");
  //         break;

  //       case 'network-request-failed':
  //         showToast(
  //             "Network error. Check your internet connection and try again.");
  //         break;

  //       default:
  //         showToast("Unknown error occurred: ${e.message}");
  //         break;
  //     }
  //   } catch (e) {
  //     updateLoginLoader();
  //     showToast(e.toString());
  //   } finally {
  //     // authLoader = false;
  //     // update();
  //   }
  // }

  ////
  ////

  String smsCode = "";
  Future<void> sendOtp(String phone, bool resend, String appSign) async {
    loginLoader = true;
    update();

    try {
      String otp = generateOTP();

      print(otp);

      final body = jsonEncode({
        "template_id": msg91TemplateId,
        "short_url": "1", // Use 1 for On, 0 for Off
        // "short_url_expiry": "60", // Optional, in seconds
        // "realTimeResponse": "1", // Optional
        "recipients": [
          {"mobiles": phone, "OTP": otp, "app_signature": appSign}
        ]
      });

      final response = await http.post(
        Uri.parse(msg91Url),
        headers: {
          'authkey': msg91AuthKey,
          'accept': 'application/json',
          'content-type': 'application/json',
        },
        body: body,
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (!resend) {
          countdown = 30;
          smsCode = otp;
          Get.to(() =>
              OtpScreen(phoneNumber: addPlusSign(phone), appSign: appSign));
          resendSMS = false;
          update();
        } else {
          resendSMS = true;
          smsCode = otp;
          loginLoader = false;
          update();
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      loginLoader = false;
      update();
    }
  }

  ////
  ////
  ////
  //// Verify otp
  Future<void> otpVerification(String otp, String phone) async {
    otpLoader = true;
    update();

    try {
      if (smsCode == otp) {
        await credentialController.storePhoneNumber(addPlusSign(phone));
        fetchUserdetails(true, false);
      } else {
        showToast("Invalid OTP");
        otpLoader = false;
        update();
      }
    }
    // on FirebaseAuthException catch (e) {
    //   otpLoader = false;
    //   update();
    //   // Handle specific Firebase Auth errors
    //   switch (e.code) {
    //     case 'invalid-verification-code':
    //       showToast("Incorrect OTP entered. Please try again.");
    //       break;

    //     case 'session-expired':
    //       showToast("The SMS code has expired. Please request a new one.");
    //       break;

    //     case 'quota-exceeded':
    //       showToast(
    //           "SMS quota for this project has been exceeded. Try again later.");
    //       break;

    //     case 'too-many-requests':
    //       showToast("You have made too many requests. Please try again later.");
    //       break;

    //     case 'network-request-failed':
    //       showToast(
    //           "Network error. Check your internet connection and try again.");
    //       break;

    //     default:
    //       showToast("Unknown error occurred: ${e.message}");
    //       break;
    //   }
    // }
    catch (e) {
      otpLoader = false;
      update();
      print("An error occurred: $e");
    } 
  }

  //// Resend Otp

  int countdown = 30;

  void startCountdownTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
        update();
      } else {
        timer.cancel();
        update();
      }
    });
  }

  ////
  ////
  //// Fetch my vehicles
  Future<void> fetchUserdetails(bool dashboard, bool splash) async {
    try {
      final NetworkHelper networkHelper = NetworkHelper(url: userUrl);

      print(credentialController.phone.toString());

      var reply = await networkHelper.postData({
        // "phone": "+971555347076"
        "phone": credentialController.phone.toString(),
      });

      List<dynamic> userValues = reply["details"]["userMessage"];

      print(reply);

      if (userValues.first.toString() != "false") {
        var user = userValues.first;

        Map<String, dynamic> jsonData = jsonDecode(user);

        userData = UserModel(
          recordId: jsonData["id"].toString(),
          fullName: jsonData["Full_Name"].toString(),
          firstName: jsonData["First_Name"].toString(),
          lastName: jsonData["Last_Name"].toString(),
          email: jsonData["Email"].toString(),
          phoneNumber: credentialController.phone,
          phoneNumber1: jsonData["Mobile_2"].toString(),
          phoneNumber2: jsonData["Mobile_3"].toString(),
          profileImage: jsonData["Record_Image"].toString(),
        );

        if (jsonData["Record_Image"].toString() != "" &&
            jsonData["Record_Image"].toString() != "null") {
          fetchProfileImage(jsonData["id"].toString());
        }

        if (dashboard) {
          Get.offAll(() => const DashboardScreen());
        } else {
          Get.back();
        }

        update();
      } else {
        if (splash) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const SignupScreen());
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
       otpLoader = false;
        update();
    }
  }

  ////
  ////
  //// Register user on zoho database
  Future<void> signupUser(
      String firstName, String lastName, String email) async {
    authLoader = true;
    update();

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: signupUrl);

      var reply = await networkHelper.postData({
        "firstName": firstName,
        "lastName": lastName,
        "fullName": "$firstName $lastName",
        "phone": credentialController.phone.toString(),
        "email": email,
      });

      print(reply);

      List<dynamic> response = reply["details"]["userMessage"];

      print(response);

      if (response[0] == null) {
        fetchUserdetails(true, false);
      } else {
        showToast(checkApiName(reply["details"]["userMessage"][2].toString()));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      authLoader = false;
      update();
    }
  }

  ////
  ////
  //// Register user on zoho database
  Future<void> editUser(
      String firstName, String lastName, String phone1, String phone2) async {
    authLoader = true;
    update();

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: editProfileUrl);

      var reply = await networkHelper.postData({
        "first_name": firstName,
        "last_name": lastName,
        "full_name": "$firstName $lastName",
        "phone": credentialController.phone.toString(),
        "phone2": phone1,
        "phone3": phone2
      });

      List<dynamic> response = reply["details"]["userMessage"];

      if (response[0].toString() != "false") {
        fetchUserdetails(false, false);
      } else {
        showToast(reply["details"]["userMessage"][1].toString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      authLoader = false;
      update();
    }
  }

  ////
  ////
  //// Generate Access token through refreshToken
  Future<String?> generateAccessTokenForImage() async {
    try {
      final NetworkHelper networkHelper =
          NetworkHelper(url: generateAccessTokenByRefreshTokenOfImageUrl);

      var reply = await networkHelper.postData({});

      return reply["access_token"];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> fetchProfileImage(String recordId) async {
    String? accessToken = await generateAccessTokenForImage();

    if (accessToken != null) {
      final url = "https://www.zohoapis.com/crm/v2/Contacts/$recordId/photo";
      final headers = {'Authorization': 'Zoho-oauthtoken $accessToken'};

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        profileImage = response.bodyBytes;
        update();
      } else {
        print('Failed to load image: ${response.statusCode}');
      }
    } else {
      print("Access token failed to generate.");
    }
  }

/////
  Future<String?> generateAccessTokenToUploadImage() async {
    try {
      final NetworkHelper networkHelper =
          NetworkHelper(url: generateAccessTokenToUploadImageUrl);

      var reply = await networkHelper.postData({});

      return reply["access_token"];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  bool imageLoader = false;

  Future<void> uploadProfileImage(XFile image) async {
    String id = userData!.recordId;
    imageLoader = true;
    update();

    try {
      String? accessToken = await generateAccessTokenToUploadImage();

      if (accessToken != null) {
        var headers = {
          'Authorization': 'Zoho-oauthtoken $accessToken',
        };

        var request = http.MultipartRequest('POST',
            Uri.parse('https://www.zohoapis.com/crm/v2/Contacts/$id/photo'));

        request.files.add(
            await http.MultipartFile.fromPath('file', image.path.toString()));
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        print(response.reasonPhrase);
        print(response.statusCode);

        if (response.statusCode == 200) {
          fetchProfileImage(id);
        } else {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      imageLoader = false;
      update();
    }
  }

  ////
  ////
  //// Fetch carousel images for home screen
  Future<void> fetchLoginImage() async {
    imageLoading = true;
    update();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('login_image')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final document = querySnapshot.docs.first;
        final data = document.data();
        if (data.isNotEmpty && data['image'] != null) {
          loginImage = data["image"];
          update();
        }
      }
    } catch (e) {
      print('Error fetching images: $e');
    } finally {
      imageLoading = false;
      update();
    }
  }
}
