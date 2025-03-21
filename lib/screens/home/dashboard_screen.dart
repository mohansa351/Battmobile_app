import 'package:batt_mobile/controllers/credential_controller.dart';
import 'package:batt_mobile/screens/intro_screens/skip_screen.dart';
import 'package:batt_mobile/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/data_controller.dart';
import '../../external_libraries/animated_floating_button/widgets/animated_floating_action_button.dart';
import '../../utils/constants.dart';
import '../my_profile/my_profile_screen.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  bool isExpanded = false;
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  List<Widget> dashboardScreens = [
    const HomeScreen(),
    credentialController.phone == ""
        ? const SkipScreen()
        : const MyProfileScreen(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Get.find<DataController>().fetchCarouselImages());

    // Future.microtask(() => Get.find<DataController>().fetchInvoices());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          dashboardScreens[currentIndex],
          Positioned(
            bottom: 15,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 68,
                  width: 190,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.6),
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(
                        color: primaryColor,
                        width: 3.5,
                      ),
                      right: BorderSide(
                        color: primaryColor,
                        width: 3.5,
                      ),
                      top: BorderSide(
                        color: primaryColor,
                        width: 1.0,
                      ),
                      left: BorderSide(
                        color: primaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          currentIndex = 0;
                          setState(() {});
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: currentIndex == 0
                                  ? selectColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(500),
                              border: Border.all(color: primaryColor)),
                          child: Image.asset(homeIcon),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          currentIndex = 1;
                          setState(() {});
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: currentIndex == 1
                                  ? selectColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(500),
                              border: Border.all(color: primaryColor)),
                          child: Image.asset(personIcon),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8),
                  child: AnimatedFloatingActionButton(
                      fabButtons: <Widget>[
                        GestureDetector(
                          onTap: () {
                            launchPhone();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: secondaryColor,
                            child: Image.asset(callIcon, height: 20, width: 20),
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            launchWhatsApp();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.green,
                            child: Image.asset(whatsappIcon,
                                height: 20, width: 20),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                      key: key,
                      colorStartAnimation: Colors.white,
                      colorEndAnimation: primaryColor,
                      animatedIconData:
                          AnimatedIcons.menu_close //To principal button
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
