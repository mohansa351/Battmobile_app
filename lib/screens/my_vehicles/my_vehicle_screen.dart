import 'package:batt_mobile/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/data_controller.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import '../my_orders/order_detail_screen.dart';

class MyVehicleScreen extends StatefulWidget {
  const MyVehicleScreen({super.key, required this.vehicleData});

  final VehicleModel vehicleData;

  @override
  State<MyVehicleScreen> createState() => _MyVehicleScreenState();
}

class _MyVehicleScreenState extends State<MyVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, widget.vehicleData.vehiceBrand, true),
      body: GetBuilder<DataController>(
        builder: (DataController controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Image.asset(car, width: screenWidth(context)),
                  const SizedBox(height: 20),
                  const SizedBox(height: 25),
                  const Text(
                    " Vehicle Details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        CustomTile(
                            title: "Vehicle Brand",
                            value: widget.vehicleData.vehiceBrand),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Vehicle Model",
                            value: widget.vehicleData.vehicleModel),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Year", value: widget.vehicleData.year),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Chassis Number",
                            value: widget.vehicleData.chassisNumber),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Cylinders Info",
                            value: widget.vehicleData.cylinders),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Color", value: widget.vehicleData.color),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Brand Origin",
                            value: widget.vehicleData.brandOrigin),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Fuel Type",
                            value: widget.vehicleData.fuelType),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    " License Plate Details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        CustomTile(
                            title: "Plate Emirate",
                            value: widget.vehicleData.plateEmirate),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Plate Number",
                            value: widget.vehicleData.plateNumber),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Plate code",
                            value: widget.vehicleData.plateCode),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    " Registration & Insurance Details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        CustomTile(
                            title: "Registration Start",
                            value: widget.vehicleData.registrationStart),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Registration Expire",
                            value: widget.vehicleData.registrationExpiry),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Insurance Start",
                            value: widget.vehicleData.insuranceStart),
                        const SizedBox(height: 10),
                        CustomTile(
                            title: "Insurance Expire",
                            value: widget.vehicleData.insuranceEnd),
                      ],
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
