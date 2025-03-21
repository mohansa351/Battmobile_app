import 'package:batt_mobile/controllers/credential_controller.dart';
import 'package:batt_mobile/screens/home/dashboard_screen.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  String countryCode = "+971";
  bool agreed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();

    Future.delayed(Duration(seconds: 2)).then(
      (value) {
        if (!credentialController.acceptPrivacyPolicy) {
          _showPrivacyDialog();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Image.asset(loginBackground, fit: BoxFit.fill),
          ),
          Positioned(
            bottom: 0,
            child: Card(
              color: backgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Container(
                width: screenWidth(context),
                padding: const EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: screenWidth(context),
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(_animation.value, 0),
                              child: child,
                            );
                          },
                          child: Image.asset(logo), // Adjust size as needed
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    const Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          padding: const EdgeInsets.only(
                              left: 10, top: 3, bottom: 3),
                          child: CountryCodePicker(
                            onChanged: (val) {
                              countryCode = val.dialCode!;
                              setState(() {});
                            },
                            initialSelection: '+971',
                            showCountryOnly: false,
                            showFlag: true,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            hideMainText: true,
                            backgroundColor: Colors.white,
                            boxDecoration:
                                const BoxDecoration(color: Colors.white),
                            showDropDownButton: false,
                            dialogTextStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Enter your number",
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            agreed = !agreed;
                            credentialController.updatePrivacyPolicy(true);
                            setState(() {});
                          },
                          child: agreed
                              ? const Icon(Icons.check_box)
                              : const Icon(Icons.check_box_outline_blank),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "I agree to the  ",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Terms and Conditions",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      print("Terms and conditions tapped");
                                      if (!await launchUrl(Uri.parse(
                                          "https://battmobile.ae/terms-conditions/"))) {
                                        throw Exception('Could not launch');
                                      }
                                    },
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    decorationColor: Colors.blue,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy policy",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (!await launchUrl(Uri.parse(
                                          "https://battmobile.ae/privacy-policy/"))) {
                                        throw Exception('Could not launch');
                                      }
                                    },
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    decorationColor: Colors.blue,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: " of the app. ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    // CustomButton(
                    //   title: "Continue",
                    //   onTap: () {
                    //    Get.to(()=> const OtpScreen());
                    //   },
                    // ),
                    GetBuilder<AuthController>(
                      builder: (AuthController controller) {
                        return controller.loginLoader
                            ? const CustomLoader()
                            : CustomButton(
                                title: "Continue",
                                onTap: () async {
                                  if (_controller.text.isNotEmpty) {
                                    if (agreed) {
                                      // Get.to(()=> const OtpScreen(phoneNumber: ""));
                                      // controller.phoneAuthentication(
                                      //     countryCode + _controller.text,
                                      //     false);

                                      String appSignature =
                                          await SmsAutoFill().getAppSignature;

                                      controller.sendOtp(
                                          removePlusSign(countryCode) +
                                              _controller.text,
                                          false,
                                          appSignature);
                                    } else {
                                      showToast(
                                          "Kindly agree to our terms and conditions.");
                                    }
                                  } else {
                                    showToast("Enter your number");
                                  }
                                },
                              );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const DashboardScreen());
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPrivacyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Privacy Policy",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text(
            "Kindly review our privacy policy before using the app.",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                credentialController.updatePrivacyPolicy(true);
              },
              child: Text(
                "Close",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                credentialController.updatePrivacyPolicy(true);
                if (!await launchUrl(
                    Uri.parse("https://battmobile.ae/privacy-policy/"))) {
                  throw Exception('Could not launch');
                }
              },
              child: Text(
                "Read Policy",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LogoAnimation extends StatefulWidget {
  @override
  _LogoAnimationState createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation> {
  double centerPosition = 0;
  double rightExitPosition = 100;
  bool showSecondLogo = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        showSecondLogo = true;
      });

      Timer(Duration(milliseconds: 500), () {
        setState(() {
          centerPosition = rightExitPosition;
        });
      });

      Timer(Duration(seconds: 1), () {
        setState(() {
          showSecondLogo = false;
          centerPosition = 0; // Reset position
        });

        Timer(Duration(milliseconds: 500), () {
          startAnimation(); // Restart animation
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showSecondLogo)
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              left:
                  MediaQuery.of(context).size.width * 0.5 - 30 + centerPosition,
              child: Image.asset(logo, height: 30),
            ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            left: showSecondLogo
                ? MediaQuery.of(context).size.width * 0.5 - 30 - 100
                : MediaQuery.of(context).size.width * 0.5 - 30,
            child: Image.asset(logo, height: 30),
          ),
        ],
      ),
    );
  }
}
