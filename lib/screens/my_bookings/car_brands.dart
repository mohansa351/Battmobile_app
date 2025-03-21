import 'package:batt_mobile/controllers/data_controller.dart';
import 'package:batt_mobile/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class CarBrands extends StatefulWidget {
  const CarBrands({super.key});

  @override
  State<CarBrands> createState() => _CarBrandsState();
}

class _CarBrandsState extends State<CarBrands> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Get.find<DataController>().fetchVehicleBrands(false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            List<String> done = ["false"];
            Navigator.pop(context, done);
          },
          child: Container(
            height: 15,
            width: 15,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: secondaryColor),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 15),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Select Brand",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: primaryColor),
        ),
      ),
      body: GetBuilder<DataController>(
        builder: (DataController controller) {
          return NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent) {
                  controller.fetchVehicleBrands(true);
                }
              }
              return false;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: _searchController, hintText: "Search here"),
                    const SizedBox(height: 20),
                    CustomButton(
                        title: "Search",
                        onTap: () {
                          if (_searchController.text.isEmpty) {
                            controller.fetchVehicleBrands(false);
                          } else {
                            controller
                                .searchVehicleBrands(_searchController.text);
                          }
                        }),
                    const SizedBox(height: 20),
                    controller.vehicleLoad
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Image.asset(five, height: 150),
                            ),
                          )
                        : controller.carBrands.isNotEmpty
                            ? ListView.builder(
                                itemCount: controller.carBrands.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      List<String> car = [
                                        "true",
                                        controller.carBrands[index]
                                      ];
                                      Navigator.pop(context, car);
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text(
                                          controller.carBrands[index],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Text(
                                    "No vehicles available",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                ),
                              ),
                    controller.isLoadingMore
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CarModels extends StatefulWidget {
  const CarModels({super.key, required this.brand});

  final String brand;

  @override
  State<CarModels> createState() => _CarModelsState();
}

class _CarModelsState extends State<CarModels> {
  // final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Get.find<DataController>().fetchVehicleModels(widget.brand));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            List<String> done = ["false"];
            Navigator.pop(context, done);
          },
          child: Container(
            height: 15,
            width: 15,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: secondaryColor),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 15),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Select Model",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: primaryColor),
        ),
      ),
      body: GetBuilder<DataController>(
        builder: (DataController controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CustomTextField(
                  //     controller: _searchController, hintText: "Search here"),
                  // const SizedBox(height: 20),
                  // CustomButton(
                  //     title: "Search",
                  //     onTap: () {
                  //       if (_searchController.text.isEmpty) {
                  //         controller.fetchVehicleModels(false);
                  //       } else {
                  //         controller
                  //             .searchVehicleModels(_searchController.text);
                  //       }
                  //     }),
                  const SizedBox(height: 20),
                  // MovingImageWidget(imagePath: one)
                  controller.vehicleLoad
                      ? MovingImageWidget(
                          imagePath: one,
                          width: screenWidth(context),
                        )
                      : controller.carModels.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.carModels.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    List<String> car = [
                                      "true",
                                      controller.carModels[index]
                                    ];
                                    Navigator.pop(context, car);
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        controller.carModels[index],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Text(
                                  "No models available",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovingImageWidget extends StatefulWidget {
  final String imagePath;
  final double width;

  const MovingImageWidget(
      {super.key, required this.imagePath, required this.width});

  @override
  State<MovingImageWidget> createState() => _MovingImageWidgetState();
}

class _MovingImageWidgetState extends State<MovingImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: -200, end: widget.width).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(
        reverse: false); // It will restart from the beginning once finished
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: Opacity(
            opacity: (_animation.value < widget.width - 100) ? 1.0 : 0.0,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          child: Image.asset(widget.imagePath, width: 250), // Adjust width as needed
        ),
      ),
    );
  }
}
