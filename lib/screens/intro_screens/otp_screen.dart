import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {super.key, required this.phoneNumber, required this.appSign});

  final String phoneNumber;
  final String appSign;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  String otp = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() => listenForOTP());
    Future.microtask(() => Get.find<AuthController>().startCountdownTimer());
    Future.microtask(() => Get.find<AuthController>().updateLoginLoader());
  }

  @override
  void codeUpdated() {
    setState(() {
      otp = code ?? "";
    });
    Get.find<AuthController>().otpVerification(otp, widget.phoneNumber);
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  listenForOTP() async {
    try {
      SmsAutoFill().listenForCode();
      print("Listening for code....");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "OTP Verification", true),
      body: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Text(
                "We have sent a verification code to",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
              Text(
                widget.phoneNumber,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 40),
              PinFieldAutoFill(
                decoration: BoxLooseDecoration(
                  strokeColorBuilder:
                      PinListenColorBuilder(primaryColor, Colors.black26),
                  bgColorBuilder: const FixedColorBuilder(Colors.white),
                  strokeWidth: 2,
                ),
                cursor: Cursor(color: primaryColor, enabled: true, width: 1),
                currentCode: otp,
                codeLength: 4,
                onCodeChanged: (code) async {
                  otp = code.toString();
                  setState(() {});
                },
              ),
              const SizedBox(height: 35),
              GetBuilder<AuthController>(
                builder: (AuthController controller) {
                  return controller.loginLoader
                      ? const CircularProgressIndicator()
                      : Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: !controller.resendSMS
                                ? ""
                                : "SMS resent on the given number.",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: [
                              !controller.resendSMS
                                  ? controller.countdown != 0
                                      ? TextSpan(
                                          text:
                                              "Resend SMS in ${controller.countdown}s",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )
                                      : TextSpan(
                                          text: "Click here",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              controller.sendOtp(
                                                  widget.phoneNumber,
                                                  true,
                                                  widget.appSign);
                                            },
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        )
                                  : TextSpan(
                                      text: "",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                              !controller.resendSMS
                                  ? controller.countdown != 0
                                      ? TextSpan(
                                          text: "",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        )
                                      : TextSpan(
                                          text:
                                              " if you have not received the verification code.",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        )
                                  : TextSpan(
                                      text: "",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                            ],
                          ),
                        );
                },
              ),
              
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: GetBuilder<AuthController>(
                  builder: (AuthController controller) {
                    return controller.otpLoader
                        ? const CustomLoader()
                        : CustomButton(
                            title: "Verify and Proceed",
                            onTap: () {
                              controller.otpVerification(
                                  otp, widget.phoneNumber);
                            });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
