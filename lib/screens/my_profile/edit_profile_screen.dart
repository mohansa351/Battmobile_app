import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/common_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

String nullCheckValue(String val) {
  if (val == "null") {
    return "";
  } else {
    return val;
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController(
      text: nullCheckValue(Get.find<AuthController>().userData!.firstName));
  final TextEditingController _lastNameController = TextEditingController(
      text: nullCheckValue(Get.find<AuthController>().userData!.lastName));
  final TextEditingController _alternatePhoneNumber1 = TextEditingController(
      text: nullCheckValue(Get.find<AuthController>().userData!.phoneNumber1));
  final TextEditingController _alternatePhoneNumber2 = TextEditingController(
      text: nullCheckValue(Get.find<AuthController>().userData!.phoneNumber2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, "My Profile", true),
        body: GetBuilder<AuthController>(
          builder: (AuthController controller) {
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _firstNameController,
                          hintText: "First name"),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: _lastNameController,
                          hintText: "Last name"),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: _alternatePhoneNumber1,
                          hintText: "Alternate phone number"),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: _alternatePhoneNumber2,
                          hintText: "Alternate phone number 2"),
                      const SizedBox(height: 50),
                      GetBuilder<AuthController>(
                        builder: (AuthController controller) {
                          return controller.authLoader
                              ? const CustomLoader()
                              : CustomButton(
                                  title: "Save",
                                  onTap: () {
                                    if (_firstNameController.text.isNotEmpty &&
                                        _lastNameController.text.isNotEmpty) {
                                      controller.editUser(
                                          _firstNameController.text,
                                          _lastNameController.text,
                                          _alternatePhoneNumber1.text,
                                          _alternatePhoneNumber2.text);
                                    } else {
                                      showToast(
                                          "Name fields can not be empty!");
                                    }
                                  });
                        },
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}
