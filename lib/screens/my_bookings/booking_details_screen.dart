import 'package:batt_mobile/models/bookings_model.dart';
import 'package:flutter/material.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import '../my_orders/order_detail_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key, required this.bookingData});

  final BookingModel bookingData;

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, widget.bookingData.appointmentNumber, true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            Image.asset(car, width: screenWidth(context)),
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.bookingData.vehiceBrand,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              " Booking Details",
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
                      title: "Appointment Number",
                      value: widget.bookingData.appointmentNumber),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Customer Request",
                      value: widget.bookingData.customerRequest),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Appointment Type",
                      value: widget.bookingData.appointmentType),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Job Type", value: widget.bookingData.jobType),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Status",
                      value: widget.bookingData.status,
                      color: widget.bookingData.status == "Booked"
                          ? Colors.green
                          : Colors.red),
                ],
              ),
            ),
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
                  CustomTile(
                      title: "Pickup - Area", value: widget.bookingData.pickupArea),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Pickup - Address",
                      value: widget.bookingData.pickupAddress),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Location Link",
                      value: widget.bookingData.locationLink,
                      color: Colors.blue),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Drop - Area", value: widget.bookingData.dropArea),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Drop - Address",
                      value: widget.bookingData.dropAddress),
                  
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
                      value: widget.bookingData.vehiceBrand),
                  const SizedBox(height: 10),
                  CustomTile(
                      title: "Vehicle Model",
                      value: widget.bookingData.vehicleModel),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
