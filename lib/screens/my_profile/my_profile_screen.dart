import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:batt_mobile/controllers/auth_controller.dart';
import 'package:batt_mobile/screens/my_contracts/my_contracts_screen.dart';
import 'package:batt_mobile/screens/my_vehicles/my_vehicles_list.dart';
import 'package:batt_mobile/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';
import '../my_bookings/my_bookings.dart';
import '../my_invoices/my_invoice_screen.dart';
import '../my_orders/my_orders_screen.dart';
import 'profile_detail_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  File? _selectedImage;

  Uint8List _decodeBase64() {
    String base64Str = Get.find<AuthController>().userData!.profileImage;
    print(base64Str);
    try {
      return base64Decode("data:image/png;base64,$base64Str");
    } catch (e) {
      print("Error decoding base64 string: $e");
      return Uint8List(0);
    }
  }

  List<String> myCards = [
    myProfile,
    vehicles,
    orders,
    contracts,
    myBookings,
    invoices,
    terms,
  ];

  List<Function> onTaps = [
    () {
      Get.to(() => const ProfileDetailScreen());
    },
    () {
      Get.to(() => const MyVehiclesList());
    },
    () {
      Get.to(() => const MyOrdersScreen());
    },
    () {
      Get.to(() => const MyContractsScreen());
    },
    () {
      Get.to(() => const MyBookings());
    },
    () {
      Get.to(() => const MyInvoiceScreen());
    },
    () async {
      if (!await launchUrl(
          Uri.parse("https://battmobile.ae/terms-conditions/"))) {
        throw Exception('Could not launch');
      }
    },
  ];

  Future<void> _pickImageFromGallery() async {
    try {} catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<AuthController>(
            builder: (AuthController controller) {
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Image.asset(profileBackground)),
                     controller.imageLoader 
                     ? Center(child: CircularProgressIndicator(color: primaryColor),)
                     : controller.userData != null
                          ? controller.profileImage != null
                              ? ClipOval(
                                  child: Image.memory(
                                    controller.profileImage!,
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the circle
                                  ),
                                )
                              : Image.asset(userImg, height: 110, width: 110)
                          : Image.asset(userImg, height: 110, width: 110),
                  controller.imageLoader 
                   ? const SizedBox()
                    :  Positioned(
                        bottom: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 75),
                          child: GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? pickedImage = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (pickedImage != null) {
                                controller.uploadProfileImage(pickedImage);
                                
                              } else {
                                showToast("No image selected");
                              }
                            },
                            child: Card(
                              color: primaryColor,
                              child: const Padding(
                                padding: const EdgeInsets.all(7),
                                child: Icon(Icons.camera_alt,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 55,
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              logoutDialog(context);
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 4),
                                child: Icon(Icons.logout, color: primaryColor),
                              ),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 25),
                  controller.userData != null
                      ? Center(
                          child: Text(
                            controller.userData!.fullName,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
          const SizedBox(height: 35),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 150),
                  itemCount: myCards.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onTaps[index]();
                      },
                      child: SizedBox(
                        height: 100,
                        child: Image.asset(myCards[index], fit: BoxFit.contain),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 120),
              ],
            ),
          )
        ],
      ),
    );
  }
}
