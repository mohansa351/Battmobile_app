import 'package:batt_mobile/models/order_model.dart';
import 'package:flutter/material.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderData});

  final OrderModel orderData;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context, "Order No. ${widget.orderData.orderNumber}", true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            Image.asset(car, width: screenWidth(context)),
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.orderData.vehicleBrand,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              " Order Details",
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
                      title: "Order Number",
                      value: widget.orderData.orderNumber),
                  const SizedBox(height: 10),
                  CustomTile(title: "Date", value: widget.orderData.date),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Vehicle Type",
                      value: widget.orderData.vehicleType),
                  const SizedBox(height: 10),
                  CustomTile(title: "Service", value: widget.orderData.service),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Status",
                      value: widget.orderData.status,
                      color: widget.orderData.status == "Completed" ||
                              widget.orderData.status == "Confirmed Order"
                          ? Colors.green
                          : Colors.red),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Amount", value: "AED ${widget.orderData.amount}"),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Payment Method",
                      value: widget.orderData.paymentMethod),
                ],
              ),
            ),
            widget.orderData.servicePackage != "No" &&
                    widget.orderData.servicePackage != "null"
                ? Column(
                    children: [
                      const SizedBox(height: 25),
                      const Text(
                        " Service Package Details",
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
                                title: "Service Package",
                                value: widget.orderData.servicePackage),
                            const SizedBox(height: 10),
                            CustomTile(
                                title: "Service Package Amount",
                                value: "AED ${widget.orderData.servicePackage}",
                                color: Colors.purple),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 25),
            const Text(
              " Address Details",
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
                  CustomTile(title: "Emirate", value: widget.orderData.emirate),
                  const SizedBox(height: 10),
                  CustomTile(title: "Area", value: widget.orderData.area),
                  const SizedBox(height: 10),
                  CustomTile(title: "Address", value: widget.orderData.address),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Additional Info",
                      value: widget.orderData.additionalInfo),
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
                      value: widget.orderData.vehicleBrand),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Vehicle Model",
                      value: widget.orderData.vehicleModel),
                  const SizedBox(height: 10),
                  CustomTile(title: "Year", value: widget.orderData.year),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Chassis Number",
                      value: widget.orderData.chassisNumber),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Cylinders Info",
                      value: widget.orderData.cylinders),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Brand Origin",
                      value: widget.orderData.brandOrigin),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

////
////
class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key,
      required this.title,
      required this.value,
      this.color,
      this.check});

  final String title;
  final String value;
  final Color? color;
  final bool? check;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 20),
        check == true
            ? value == "true"
                ? const Expanded(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.green,
                      )
                    ],
                  ))
                : Expanded(
                    child: Text(
                      "-",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color ?? Colors.black),
                      textAlign: TextAlign.end,
                    ),
                  )
            : Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: color ?? Colors.black),
                  textAlign: TextAlign.end,
                ),
              ),
      ],
    );
  }
}
