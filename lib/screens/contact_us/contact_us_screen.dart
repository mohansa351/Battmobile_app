import 'package:batt_mobile/controllers/auth_controller.dart';
import 'package:batt_mobile/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _firstNameController = TextEditingController(
      text: Get.find<AuthController>().userData!.firstName);
  final TextEditingController _lastNameController = TextEditingController(
      text: Get.find<AuthController>().userData!.lastName);
  final TextEditingController _phoneController = TextEditingController(
      text: Get.find<AuthController>().userData!.phoneNumber);
  final TextEditingController _emailController = TextEditingController(
      text: Get.find<AuthController>().userData!.email == "null"
          ? ""
          : Get.find<AuthController>().userData!.email);
  final TextEditingController _noteController = TextEditingController();

  String type = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Contact Us", true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Name of customer
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: " First Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: Colors.red, // Make the asterisk red
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              CustomTextField(
                  hintText: "Enter Here",
                  enabled: false,
                  controller: _firstNameController),

              /// Name of customer
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: " Last Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: Colors.red, // Make the asterisk red
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  hintText: "Enter Here",
                  enabled: false,
                  controller: _lastNameController),

              /// Phone Number of Customer
              const SizedBox(height: 25),
              RichText(
                text: const TextSpan(
                  text: " Phone Number",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: Colors.red, // Make the asterisk red
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  hintText: "Enter here",
                  enabled: false,
                  inputType: TextInputType.number,
                  controller: _phoneController),

              /// Email id of customer
              const SizedBox(height: 25),
              RichText(
                text: const TextSpan(
                  text: " Email Address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: Colors.red, // Make the asterisk red
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  enabled: Get.find<AuthController>().userData!.email == "" ||
                          Get.find<AuthController>().userData!.email == "null"
                      ? true
                      : false,
                  hintText: "Enter here",
                  controller: _emailController),

              /// Type
              const SizedBox(height: 25),
              RichText(
                text: const TextSpan(
                  text: " Type",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: Colors.red, // Make the asterisk red
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                onChanged: (val) {
                  type = val;
                  setState(() {});
                },
                items: const [
                  DropdownMenuItem(
                    value: "General Reason",
                    child: Text(
                      "General Reason",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Sales Enquiry",
                    child: Text(
                      "Sales Enquiry",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Partnership",
                    child: Text(
                      "Partnership",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Jobs",
                    child: Text(
                      "Jobs",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Complaints & Suggestions",
                    child: Text(
                      "Complaints & Suggestions",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Account Delete",
                    child: Text(
                      "Account Delete",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              CustomTextField(
                  hintText: "Enter here",
                  controller: _noteController,
                  maxLines: 4),

              const SizedBox(height: 35),

              GetBuilder<DataController>(
                builder: (DataController controller) {
                  return controller.dataLoader
                      ? const CustomLoader()
                      : CustomButton(
                          title: "Send Now",
                          onTap: () async {
                            if (_emailController.text.isNotEmpty &&
                                _noteController.text.isNotEmpty &&
                                type != "") {
                              if (_emailController.text.isEmail) {
                                controller.contactUs(
                                    context,
                                    _emailController.text,
                                    _noteController.text,
                                    type);
                              } else {
                                showToast("Kindly enter a valid email address");
                              }
                            } else {
                              showToast("All fields are mandatory");
                            }
                          });
                },
              ),

              const SizedBox(height: 35),

              Container(
                color: Colors.blue.shade200,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(Icons.location_on, color: primaryColor),
                    title: Text(
                      "SERVICE CENTER",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                    subtitle: Text(
                      "Plot 61, 318th Street, Next to Designsmith, AL Quoz Industrial Area 2",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.blue.shade200,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(Icons.corporate_fare, color: primaryColor),
                    title: Text(
                      "CORPORATE OFFICE",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                    subtitle: Text(
                      "Plot 61, 318th Street, Next to Designsmith, AL Quoz Industrial Area 2",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.blue.shade200,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: primaryColor),
                          const SizedBox(height: 5),
                          Image.asset(whatsappIcon, height: 20)
                        ],
                      ),
                      title: Text(
                        "24/7 SUPPORT",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: primaryColor),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          "Call/Whatsapp: 800-78278",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.blue.shade200,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(Icons.mail, color: primaryColor),
                    title: Text(
                      "EMAIL US",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                    subtitle: Text(
                      "help@battmobile.ae",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.blue.shade200,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(Icons.language, color: primaryColor),
                    title: Text(
                      "WEBSITE",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                    subtitle: Text(
                      "www.battmobile.ae",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
