import 'package:batt_mobile/screens/my_bookings/car_brands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/data_controller.dart';
import '../../models/bookings_model.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import 'booking_details_screen.dart';
import 'create_booking_screen.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Get.find<DataController>().fetchBookings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "My Bookings", true),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const CreateBookingScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: secondaryColor, width: 2)),
          ),
          child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle, color: secondaryColor),
                  const SizedBox(width: 10),
                  Text(
                    "Book Service",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor),
                  ),
                ],
              )),
        ),
      ),
      body: GetBuilder<DataController>(
        builder: (DataController controller) {
          return controller.dataLoader
          ? MovingImageWidget(imagePath: one, width: screenWidth(context))
              // ? Center(
              //     child: CircularProgressIndicator(
              //       color: secondaryColor,
              //     ),
              //   )
              : controller.myBookingsList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.myBookingsList.length,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      itemBuilder: (context, index) {
                        return MyBookingCard(bookingModel: controller.myBookingsList[index]);
                      },
                    )
                  : const NoDataFound(title: "No Bookings Found");
        },
      ),
    );
  }
}

/////
/////
class MyBookingCard extends StatelessWidget {
  const MyBookingCard({super.key, required this.bookingModel});

  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BookingDetailsScreen(bookingData: bookingModel));
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
                        bookingModel.vehiceBrand,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
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
                  "Date & Time      ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Text(
                    bookingModel.dateTime,
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
                  "Appointment No.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 15),
                Text(
                  bookingModel.appointmentNumber,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Job Type    ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 58),
                Expanded(
                  child: Text(
                    bookingModel.jobType,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: bookingModel.status == "Booked"
                            ? Colors.green.shade200
                            : Colors.red.shade100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    bookingModel.status,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: bookingModel.status == "Booked"
                            ? Colors.green.shade800
                            : Colors.red.shade800),
                  ),
                ),
                const Text(
                  "View Details",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
