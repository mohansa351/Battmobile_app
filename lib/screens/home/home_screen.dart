import 'package:batt_mobile/controllers/credential_controller.dart';
import 'package:batt_mobile/controllers/data_controller.dart';
import 'package:batt_mobile/screens/intro_screens/skip_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';
import '../contact_us/contact_us_screen.dart';
import '../my_bookings/create_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  List<String> serviceIcons = [
    carRepair,
    oilChange,
    tyreChange,
    bikeBattery,
    carBattery,
    acRepair,
    carRecovery,
    brakePads,
    carInspection,
    jumpStart,
    carWash,
    carDetailing,
    commercialBattery,
    sellCar
  ];

  List<String> serviceUrls = [
    "https://battmobile.ae/services/car-repair/",
    "https://battmobile.ae/services/oil-change-car-service/",
    "https://battmobile.ae/services/tyre-change-dubai/",
    "https://battmobile.ae/services/bike-battery-replacement/",
    "https://battmobile.ae/services/battery-replacement/",
    "https://battmobile.ae/services/car-ac-repair/",
    "https://battmobile.ae/services/car-recovery/",
    "https://battmobile.ae/services/brake-pads-replacement/",
    "https://battmobile.ae/services/car-inspection/",
    "https://battmobile.ae/services/jumpstart-service/",
    "https://battmobile.ae/services/car-wash/",
    "https://battmobile.ae/services/car-detailing-services/",
    "https://battmobile.ae/services/commercial-battery-supply/",
    "https://battmobile.ae/services/sell-car-dubai/",
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.microtask(
            () => Get.find<DataController>().fetchCarouselImages()),
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 35),
              GetBuilder<DataController>(
                builder: (DataController controller) {
                  return controller.bannerLoading
                      ? SizedBox(
                          height: 270,
                          child: Image.asset(load2)
                        )
                      : controller.carouselImages.isNotEmpty
                          ? CarouselSlider.builder(
                              carouselController: _controller,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 5),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                height: 270,
                                aspectRatio: 1.0,
                                viewportFraction: 1.0,
                              ),
                              itemCount: controller.carouselImages.length,
                              itemBuilder: (BuildContext context, int index,
                                      int pageViewIndex) =>
                                  SizedBox(
                                      height: 270,
                                      width: screenWidth(context),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            controller.carouselImages[index],
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                SizedBox(
                                          height: 270,
                                          child: Image.asset(load2)
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )),
                            )
                          : const SizedBox();
                },
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      if (credentialController.phone != "") {
                        Get.to(() => const CreateBookingScreen());
                      } else {
                        Get.to(() => const SkipScreen());
                      }
                    },
                    child: Image.asset(createBooking, height: 70),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      if (credentialController.phone != "") {
                        Get.to(() => const ContactUsScreen());
                      } else {
                        Get.to(() => const SkipScreen());
                      }
                    },
                    child: Image.asset(contactUs, height: 70),
                  )
                ],
              ),
              const SizedBox(height: 35),
              Text(
                "  Product & Services",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: secondaryColor),
              ),
              const SizedBox(height: 25),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 35,
                    mainAxisExtent: 70),
                itemCount: serviceIcons.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(serviceUrls[index]))) {
                        throw Exception('Could not launch');
                      }
                    },
                    child: Image.asset(serviceIcons[index]),
                  );
                },
              ),
              const SizedBox(height: 120)
            ],
          ),
        ));
  }
}
