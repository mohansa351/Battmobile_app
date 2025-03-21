import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/data_controller.dart';
import '../../models/contracts_model.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';
import '../my_bookings/car_brands.dart';
import 'contract_detail_screen.dart';

class MyContractsScreen extends StatefulWidget {
  const MyContractsScreen({super.key});

  @override
  State<MyContractsScreen> createState() => _MyContractsScreenState();
}

class _MyContractsScreenState extends State<MyContractsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Get.find<DataController>().fetchContracts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Service Packages", true),
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
              : controller.myContractsList.isNotEmpty
                  ? ListView.builder(
                          itemCount: controller.myContractsList.length,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          itemBuilder: (context, index) {
                            return MyContractCard(contractModel: controller.myContractsList[index]);
                          },
                        )
                  : const NoDataFound(title: "No Package Found");
        },
      ),
    
    );
  }
}

////
////
class MyContractCard extends StatelessWidget {
  const MyContractCard(
      {super.key, required this.contractModel});


   final ContractModel contractModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ContractDetailScreen(contractData: contractModel));
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
                        contractModel.vehicleBrand,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                  
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
           Row(
              children: [
                const Text(
                  "Customer Name",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Text(
                    contractModel.customerName,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Contract Status ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 25),
                Container(
                  color: contractModel.status == "Active"
                      ? Colors.green.shade200
                      : Colors.red.shade200,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  child: Text(
                    contractModel.status,
                    style: TextStyle(
                        color: contractModel.status == "Active"
                            ? Colors.green.shade800
                            : Colors.purple.shade800,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
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
                Column(
                  children: [
                    Text(
                     contractModel.pastServiceDate,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Past Service Date",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Text(
                //       contractModel.upcomingServiceDate,
                //       style: const TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w500,
                //           color: Colors.black),
                //     ),
                //     const SizedBox(height: 5),
                //     const Text(
                //       "Upcoming Service Date",
                //       style: TextStyle(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.black54),
                //     ),
                //   ],
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
