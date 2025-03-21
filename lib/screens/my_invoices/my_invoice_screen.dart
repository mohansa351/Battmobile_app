import 'package:batt_mobile/controllers/data_controller.dart';
import 'package:batt_mobile/models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import '../my_bookings/car_brands.dart';

class MyInvoiceScreen extends StatefulWidget {
  const MyInvoiceScreen({super.key});

  @override
  State<MyInvoiceScreen> createState() => _MyInvoiceScreenState();
}

class _MyInvoiceScreenState extends State<MyInvoiceScreen> {

   @override
  void initState() {
    super.initState();
    Future.microtask(()=> Get.find<DataController>().fetchInvoices());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "My Invoices", true),
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
                  : controller.myInvoiceList.isNotEmpty
                      ? ListView.builder(
            itemCount: controller.myInvoiceList.length,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 25),
            itemBuilder: (context, index) {
              return   MyInvoiceCard(data: controller.myInvoiceList[index]);
            },
          )
           : const NoDataFound(title: "No Invoice Found");
        },
      ),
    );
  }
}

/////
/////
class MyInvoiceCard extends StatelessWidget {
  const MyInvoiceCard({super.key, required this.data});

  final InvoiceModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (data.invoiceUrl != "-") {
          if (!await launchUrl(Uri.parse(data.invoiceUrl))) {
            throw Exception('Could not launch');
          }
        } else {
          showToast("Invoice link not found");
        }
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
                        data.vehicleName,
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
                  "Invoice Date",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    data.invoiceDate,
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
                  "Invoice No.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 35),
                Expanded(
                  child: Text(
                    data.invoiceNumber,
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
                  "Job Type    ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Text(
                    "${data.currency} ${data.invoiceAmount}",
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
