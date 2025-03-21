import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/data_controller.dart';
import '../../models/order_model.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import '../my_bookings/car_brands.dart';
import 'order_detail_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Get.find<DataController>().fetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "My Orders", true),
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
              : controller.myOrdersList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.myOrdersList.length,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      itemBuilder: (context, index) {
                        return MyOrderCard(
                          vehicleName:
                              controller.myOrdersList[index].vehicleBrand,
                          vehicleType:
                              controller.myOrdersList[index].vehicleType,
                          orderNumber:
                              controller.myOrdersList[index].orderNumber,
                          service: controller.myOrdersList[index].service,
                          orderStatus: controller.myOrdersList[index].status,
                          orderModel: controller.myOrdersList[index],
                        );
                      },
                    )
                  : const NoDataFound(title: "No Orders Found");
        },
      ),
    );
  }
}

////
////
class MyOrderCard extends StatelessWidget {
  const MyOrderCard(
      {super.key,
      required this.vehicleName,
      required this.vehicleType,
      required this.orderNumber,
      required this.service,
      required this.orderStatus,
      required this.orderModel});

  final String vehicleName;
  final String vehicleType;
  final String orderNumber;
  final String service;
  final String orderStatus;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailScreen(orderData: orderModel));
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
                        vehicleName,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        vehicleType,
                        style: const TextStyle(
                            fontSize: 14,
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
                  "Order Number",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    orderNumber,
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
                  "Service    ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 55),
                Expanded(
                  child: Text(
                    service,
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
                  color: orderStatus == 'Completed' || orderStatus == 'Confirmed Order'
                      ? Colors.green.shade200
                      : Colors.red.shade200,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  child: Text(
                    orderStatus,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: orderStatus == 'Completed' || orderStatus == 'Confirmed Order'
                          ? Colors.green.shade800
                          : Colors.purple.shade800,
                    ),
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
