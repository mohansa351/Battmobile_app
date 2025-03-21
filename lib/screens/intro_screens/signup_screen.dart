import 'package:batt_mobile/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: 240,
              width: screenWidth(context),
              child: Image.asset(
                homeBanner,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 35),
            CustomTextField(
                controller: _firstNameController, hintText: "First name"),
            const SizedBox(height: 10),
            CustomTextField(
                controller: _lastNameController, hintText: "Last name"),
            const SizedBox(height: 10),
            CustomTextField(controller: _emailController, hintText: "Email"),
            const SizedBox(height: 50),
            GetBuilder<AuthController>(
              builder: (AuthController controller) {
                return controller.authLoader
                ? const CustomLoader()
                : CustomButton(
                    title: "Save",
                    onTap: () {
                      if (_firstNameController.text.isNotEmpty &&
                          _lastNameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty) {
                        if (_emailController.text.isEmail) {
                          controller.signupUser(_firstNameController.text,
                              _lastNameController.text, _emailController.text);
                        } else {
                          showToast("Enter a valid email address");
                        }
                      } else {
                        showToast("All fields are mandatory");
                      }
                    });
              },
            )
          ],
        ),
      ),
    ));
  }
}
