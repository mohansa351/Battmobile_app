import 'package:batt_mobile/controllers/auth_controller.dart';
import 'package:batt_mobile/screens/my_orders/order_detail_screen.dart';
import 'package:batt_mobile/screens/my_profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, "My Profile", true),
        body: GetBuilder<AuthController>(
          builder: (AuthController controller) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    " Basic Details",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor)),
                    child: controller.userData != null
                        ? Column(
                            children: [
                              CustomTile(
                                  title: "Name",
                                  value: controller.userData!.fullName != "null"
                                      ? controller.userData!.fullName
                                      : "-"),
                              const SizedBox(height: 10),
                              CustomTile(
                                  title: "Mobile",
                                  value:
                                      controller.userData!.phoneNumber != "null"
                                          ? controller.userData!.phoneNumber
                                          : "-"),
                              const SizedBox(height: 10),
                              CustomTile(
                                  title: "Email",
                                  value: controller.userData!.email != "null"
                                      ? controller.userData!.email
                                      : "-"),
                              const SizedBox(height: 10),
                              CustomTile(
                                  title: "Alternate Mobile",
                                  value: controller.userData!.phoneNumber1 !=
                                          "null"
                                      ? controller.userData!.phoneNumber1
                                      : "-"),
                              const SizedBox(height: 10),
                              CustomTile(
                                  title: "Alternate Mobile 2",
                                  value: controller.userData!.phoneNumber2 !=
                                          "null"
                                      ? controller.userData!.phoneNumber2
                                      : "-"),
                            ],
                          )
                        : const Column(
                            children: [
                              CustomTile(title: "Name", value: "-"),
                              SizedBox(height: 10),
                              CustomTile(title: "Mobile", value: "-"),
                              SizedBox(height: 10),
                              CustomTile(title: "Email", value: "-"),
                              SizedBox(height: 10),
                              CustomTile(
                                  title: "Alternate Mobile 1", value: "-"),
                              SizedBox(height: 10),
                              CustomTile(
                                  title: "Alternate Mobile 2", value: "-"),
                            ],
                          ),
                  ),
                  const SizedBox(height: 45),
                  CustomButton(
                      title: "Edit Profile",
                      onTap: () {
                        Get.to(() => const EditProfileScreen());
                      })
                ],
              ),
            );
          },
        ));
  }
}
