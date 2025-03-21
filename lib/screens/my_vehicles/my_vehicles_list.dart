import 'package:batt_mobile/models/vehicle_model.dart';
import 'package:batt_mobile/screens/my_vehicles/my_vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/data_controller.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import '../my_bookings/car_brands.dart';

class MyVehiclesList extends StatefulWidget {
  const MyVehiclesList({super.key});

  @override
  State<MyVehiclesList> createState() => _MyVehiclesListState();
}

class _MyVehiclesListState extends State<MyVehiclesList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Get.find<DataController>().fetchVehicles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "My Vehicles", true),
      body: GetBuilder<DataController>(
        builder: (DataController controller) {
          return controller.dataLoader
              // ? Center(
              //     child: CircularProgressIndicator(
              //       color: secondaryColor,
              //     ),
              //   )
              ? MovingImageWidget(
                          imagePath: one,
                          width: screenWidth(context),
                        )
              : controller.myVehicleList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.myVehicleList.length,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      itemBuilder: (context, index) {
                        return VehicleCard(
                            data: controller.myVehicleList[index]);
                      },
                    )
                  : const NoDataFound(title: "No Vehicle Found");
        },
      ),
    );
  }
}

/////
/////
class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.data});

  final VehicleModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Get.to(()=>  MyVehicleScreen(vehicleData: data));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade400),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 2, child: Image.asset(car)),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        data.vehiceBrand,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data.vehicleModel,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Year",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    data.year,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Chasis No.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 35),
                Expanded(
                  child: Text(
                    data.chassisNumber,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
