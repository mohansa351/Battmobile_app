import 'package:batt_mobile/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';

class SkipScreen extends StatefulWidget {
  const SkipScreen({super.key});

  @override
  State<SkipScreen> createState() => _SkipScreenState();
}

class _SkipScreenState extends State<SkipScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Get.find<AuthController>().fetchLoginImage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            GetBuilder<AuthController>(
              builder: (AuthController controller) {
                return controller.imageLoading
                    ? SizedBox(
                          height: 270,
                          child: Image.asset(load2)
                        )
                    : controller.loginImage != ""
                        ? SizedBox(
                            height: 270,
                            width: screenWidth(context),
                            child: Image.network(
                              controller.loginImage,
                              fit: BoxFit.fill,
                            ),
                          )
                        : const SizedBox(height: 50);
              },
            ),
            const SizedBox(height: 25),
            Center(
              child: Text(
                " Please Login",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: primaryColor),
              ),
            ),
            const SizedBox(height: 35),
            CustomButton(
                title: "Login",
                onTap: () {
                  Navigator.pop(context);
                }),
            const SizedBox(height: 35),
            Center(
              child: Text(
                " Or",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
              ),
            ),
            const SizedBox(height: 35),
            Center(
              child: Text(
                "Connect to Our Customer Support",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launchPhone();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Image.asset(callIcon, height: 20),
                        const SizedBox(width: 10),
                        Text(
                          "Call Now",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchWhatsApp();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent.shade400,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Image.asset(whatsappIcon, height: 20),
                        const SizedBox(width: 10),
                        Text(
                          "Whatsapp",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
