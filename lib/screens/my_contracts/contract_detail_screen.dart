import 'package:batt_mobile/models/contracts_model.dart';
import 'package:flutter/material.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import '../my_orders/order_detail_screen.dart';

class ContractDetailScreen extends StatefulWidget {
  const ContractDetailScreen({super.key, required this.contractData});

  final ContractModel contractData;

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, widget.contractData.contractNumber, true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            Image.asset(car, width: screenWidth(context)),
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.contractData.vehicleBrand,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              " Contract Details",
              style: TextStyle(
                  fontSize: 18,
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
                      title: "Contract Number",
                      value: widget.contractData.contractNumber),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Vehicle Brand",
                      value: widget.contractData.vehicleBrand),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Vehicle Model",
                      value: widget.contractData.vehicleModel),
                  const SizedBox(height: 10),
                  CustomTile(title: "Year", value: widget.contractData.year),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Status",
                      value: widget.contractData.status,
                      color: widget.contractData.status == "Active"
                          ? Colors.green
                          : Colors.red),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Contract", value: widget.contractData.contract),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Amount",
                      value: widget.contractData.amount,
                      color: Colors.purple),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Amount Collected",
                      value: widget.contractData.amountCollected),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "SP Booklet Provided",
                      value: widget.contractData.spBooklet),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              " License Plate Details",
              style: TextStyle(
                  fontSize: 18,
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
                      value: widget.contractData.emirate),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Plate Number", value: widget.contractData.number),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Plate code", value: widget.contractData.code),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const Text(
                  " Total Service Taken",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.red.shade100,
                  radius: 15,
                  child: Text(
                    widget.contractData.totalServiceCount,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade800),
                  ),
                ),
              ],
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
                      title: "Minor 1 Status",
                      value: widget.contractData.minorServiceOneStatus,
                      check: true,
                      color: widget.contractData.minorServiceOneStatus == "true"
                          ? Colors.green
                          : Colors.red),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Minor 1 Date",
                      value: widget.contractData.minorServiceOneDate),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Minor 2 Status",
                      value: widget.contractData.minorServiceTwoStatus,
                      check: true,
                      color: widget.contractData.minorServiceTwoStatus == "true"
                          ? Colors.green
                          : Colors.red),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Minor 2",
                      value: widget.contractData.minorServiceTwoDate),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Minor 3 Status",
                      value: widget.contractData.minorServiceThreeStatus,
                      check: true,
                      color:
                          widget.contractData.minorServiceThreeStatus == "true"
                              ? Colors.green
                              : Colors.red),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Minor 3",
                      value: widget.contractData.minorServiceThreeDate),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Major 1 Status",
                      value: widget.contractData.majorServiceOneStatus,
                      check: true,
                      color: widget.contractData.majorServiceOneStatus == "true"
                          ? Colors.green
                          : Colors.red),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Major 1",
                      value: widget.contractData.majorServiceOneDate),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Major 2 Status",
                      value: widget.contractData.majorServiceTwoStatus,
                      check: true,
                      color: widget.contractData.majorServiceTwoStatus == "true"
                          ? Colors.green
                          : Colors.red),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Major 2",
                      value: widget.contractData.majorServiceTwoDate),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              " Vehicle Details",
              style: TextStyle(
                  fontSize: 18,
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
                      value: widget.contractData.vehicleBrand),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Vehicle Model",
                      value: widget.contractData.vehicleModel),
                  const SizedBox(height: 10),
                  CustomTile(title: "Year", value: widget.contractData.year),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Chassis Number",
                      value: widget.contractData.chassisNumber),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Cylinders Info",
                      value: widget.contractData.cylinders),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Brand Origin",
                      value: widget.contractData.brandOrigin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
