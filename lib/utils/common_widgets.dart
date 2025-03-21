import 'dart:math';
import 'package:batt_mobile/controllers/credential_controller.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

showToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: primaryColor,
    textColor: Colors.white,
    fontSize: 15.0,
  );
}

String removePlusSign(String number) {
  if (number.startsWith('+')) {
    return number.substring(1);
  }
  return number;
}

String addPlusSign(String number) {
  if (!number.startsWith('+')) {
    return '+$number';
  }
  return number;
}

String generateOTP({int length = 4}) {
  if (length <= 0) {
    throw ArgumentError('OTP length must be greater than 0');
  }

  final Random random = Random();
  String otp = '';

  for (int i = 0; i < length; i++) {
    otp += random.nextInt(10).toString(); // Generates a number between 0 and 9
  }

  return otp;
}

/////
/////
/// Custom button for the application
class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.btnColor,
      this.txtColor,
      this.width});

  final String title;
  final Function onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: btnColor ?? primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: SizedBox(
        height: 45,
        width: width ?? screenWidth(context),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: txtColor ?? secondaryColor),
          ),
        ),
      ),
    );
  }
}

/////
/////
/// Custom loader for the application
class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.btnColor, this.loaderClr, this.width});

  final Color? btnColor;
  final Color? loaderClr;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: btnColor ?? primaryColor,
          borderRadius: BorderRadius.circular(10)),
      width: width ?? screenWidth(context),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 45),
          child: Image.asset(six),
        ),
      ),
    );
  }
}

/////
/////
/// Custom app bar for the application
AppBar customAppBar(context, String title, bool backBtn) {
  return AppBar(
    leading: backBtn
        ? GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 15,
              width: 15,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 15),
            ),
          )
        : const SizedBox(),
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: primaryColor),
    ),
  );
}

/////
/////
/// Custom text field for the application
class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.suffix,
      required this.controller,
      required this.hintText,
      this.enabled,
      this.maxLines,
      this.inputType});

  final Widget? suffix;
  final String hintText;
  final bool? enabled;
  final int? maxLines;
  final TextInputType? inputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      keyboardType: inputType ?? TextInputType.text,
      maxLines: maxLines ?? 1,
      
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
      
        hintStyle: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54),
        enabled: enabled ?? true,
        fillColor: Colors.white,
        suffixIcon: suffix ?? const SizedBox(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primaryColor)),
      ),
    );
  }
}

/////
/////
/// Custom dropdown for the application
class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    this.onChanged,
  });

  final List<DropdownMenuItem> items;
  final ValueChanged? onChanged;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.items,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        // contentPadding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        fillColor: Colors.white,
        labelText: "Select",
        labelStyle: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      dropdownColor: Colors.white,
    );
  }
}

/////
/////
/// Custom dropdown for the application

void onTextFieldTap(
    context, String title, List<SelectedListItem> items, Function onTap) {
  DropDownState(
    DropDown(
      isDismissible: true,
      bottomSheetTitle: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      data: items,
      dropDownBackgroundColor: Colors.white,
      onSelected: (List<dynamic> selectedList) {
        var item = selectedList.first;
        if (item is SelectedListItem) {
          onTap(item.name);
        }
      },
      enableMultipleSelection: false,
    ),
  ).showModal(context);
}

////
////
////
class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: secondaryColor)),
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

void showSuccessDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 250,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Green Check Icon
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 25,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              // Success Message Title
              const Text(
                "Success",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              // Success Message Body
              const Text(
                "You have submitted your message successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Close Button
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Go Back",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

logoutDialog(BuildContext context) {
  Dialogs.materialDialog(
    msg: 'Do you want to logout?',
    title: "Logout",
    color: Colors.white,
    titleStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
    msgStyle: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
    msgAlign: TextAlign.center,
    titleAlign: TextAlign.center,
    context: context,
    actionsBuilder: (context) {
      return [
        IconsButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Cancel',
          iconData: Icons.cancel,
          color: Colors.red.shade700,
          textStyle: const TextStyle(color: Colors.white, fontSize: 14),
          iconColor: Colors.white,
        ),
        IconsButton(
          onPressed: () {
            credentialController.logoutUser();
          },
          text: 'Logout',
          iconData: Icons.logout,
          color: primaryColor,
          textStyle: const TextStyle(color: Colors.white, fontSize: 14),
          iconColor: Colors.white,
        ),
      ];
    },
  );
}

Future<void> launchPhone() async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: "+97180078278",
  );
  if (!await launchUrl(launchUri)) {
    throw Exception('Could not launch phone call');
  }
}

Future<void> launchWhatsApp() async {
  String phoneNumber = "+97180078278";
  String message =
      'Hi Battmobile, I need some help with my car, please call me back as soon as possible.';

  final Uri launchUri = Uri.parse(
    'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
  );
  if (!await launchUrl(launchUri)) {
    throw Exception('Could not launch WhatsApp');
  }
}
