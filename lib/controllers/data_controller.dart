import 'dart:convert';
import 'package:batt_mobile/controllers/auth_controller.dart';
import 'package:batt_mobile/controllers/credential_controller.dart';
import 'package:batt_mobile/models/invoice_model.dart';
import 'package:batt_mobile/utils/common_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../models/bookings_model.dart';
import '../models/contracts_model.dart';
import '../models/order_model.dart';
import '../models/vehicle_model.dart';
import '../utils/api_urls.dart';
import '../utils/helper.dart';

class DataController extends GetxController {
  List<OrderModel> myOrdersList = [];
  List<ContractModel> myContractsList = [];
  List<BookingModel> myBookingsList = [];
  List<VehicleModel> myVehicleList = [];
  List<InvoiceModel> myInvoiceList = [];
  List<String> carBrands = [];
  List<String> carModels = [];
  List<String> carouselImages = [];
  bool dataLoader = false;
  bool bannerLoading = true;

  ////
  ////
  void updateLoader(bool val) {
    dataLoader = val;
    update();
  }

  String nullCheckValue(String val) {
    if (val == "null") {
      return "-";
    } else {
      return val;
    }
  }

  String nullValueCount(String mp, String rp) {
    if (mp != "null") {
      return mp;
    } else if (rp != "null") {
      return rp;
    } else {
      return "0";
    }
  }

  String pastServiceDate(
      String minorServiceOne,
      String minorServiceTwo,
      String minorServiceThree,
      String majorServiceOne,
      String majorServiceTwo) {
    if (minorServiceThree != "-") {
      return minorServiceThree;
    } else if (minorServiceTwo != "-") {
      return minorServiceTwo;
    } else if (minorServiceOne != "-") {
      return minorServiceOne;
    } else if (majorServiceOne != "-") {
      return majorServiceOne;
    } else if (majorServiceTwo != "-") {
      return majorServiceTwo;
    } else {
      return "-";
    }
  }

  String convertDateTime(String isoDate) {
    if (isoDate != "null") {
      DateTime parsedDate = DateTime.parse(isoDate);

      // Define the month names
      const List<String> months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ];

      // Extract the components
      String month = months[parsedDate.month - 1];
      String day = parsedDate.day.toString().padLeft(2, '0');
      String year = parsedDate.year.toString();

      // Format the date
      return "$month $day, $year";
    } else {
      return "-";
    }
  }

  String formatDateTime(String inputDate) {
    if (inputDate != "null") {
      try {
        DateTime parsedDate = DateTime.parse(inputDate);

        // Define the desired output format
        DateFormat formatter = DateFormat('MMM dd, yyyy & hh:mm a');

        // Format the parsed date
        return formatter.format(parsedDate);
      } catch (e) {
        // Handle parsing errors
        print("Error formatting date: $e");
        return "-";
      }
    } else {
      return "-";
    }
  }

  ////
  ////
  //// Fetch carousel images for home screen
  Future<void> fetchCarouselImages() async {
    bannerLoading = true;
    update();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('home_images')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final document = querySnapshot.docs.first;
        final data = document.data();
        if (data.isNotEmpty && data['images'] != null) {
          carouselImages.clear();
          for (var image in data['images']) {
            if (image != "") {
              carouselImages.add(image);
              update();
            }
          }
        }
      }
    } catch (e) {
      print('Error fetching images: $e');
    } finally {
      bannerLoading = false;
      update();
    }
  }

  ////
  ////
  //// Fetch my orders
  ///
  /// Sales order code - completed
  /// Notification count
  /// notification icon in push notify
  ///
  Future<void> fetchOrders() async {
    updateLoader(true);
    myOrdersList.clear();

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: myOrdersUrl);

      var reply = await networkHelper.postData({
        // "phone": "+971555347076",
        "phone": credentialController.phone.toString(),
      });

      List<dynamic> orderData = reply["details"]["userMessage"];

      if (orderData.first.toString() != "false") {
        for (var order in orderData) {
          Map<String, dynamic> jsonData = jsonDecode(order);

          myOrdersList.add(
            OrderModel(
              orderNumber: nullCheckValue(jsonData["Enquiry_ID"].toString()),
              date: nullCheckValue(jsonData["Date"].toString()),
              vehicleType:
                  nullCheckValue(jsonData["Car_or_Motorbike"].toString()),
              service: nullCheckValue(jsonData["Service_Required"].toString()),
              status: nullCheckValue(jsonData["Enquiry_Status"].toString()),
              amount: nullCheckValue(jsonData["Amount"].toString()),
              paymentMethod:
                  nullCheckValue(jsonData["Payment_Method"].toString()),
              servicePackage: nullCheckValue(
                  jsonData["Car_Service_Package_Sold"].toString()),
              servicePackageAmount:
                  nullCheckValue(jsonData["Service_Package_Amount"].toString()),
              emirate: nullCheckValue(jsonData["Emirate"].toString()),
              area: nullCheckValue(jsonData["Area"].toString()),
              address: nullCheckValue(jsonData["Enter_Location"].toString()),
              additionalInfo:
                  nullCheckValue(jsonData["Additional_Info"].toString()),
              vehicleBrand: jsonData["Vehice_Brand"] != null
                  ? nullCheckValue(jsonData["Vehice_Brand"]["name"].toString())
                  : "-",
              vehicleModel: jsonData["Vehicle_Model"] != null
                  ? nullCheckValue(jsonData["Vehicle_Model"]["name"].toString())
                  : "-",
              year: nullCheckValue(jsonData["Year"].toString()),
              chassisNumber: nullCheckValue(jsonData["Chasis_No"].toString()),
              cylinders: nullCheckValue(jsonData["No_of_Cylinder"].toString()),
              brandOrigin: nullCheckValue(jsonData["Car_Origin"].toString()),
            ),
          );
          update();
        }
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateLoader(false);
    }
  }

  String preprocessMultilineStrings(String rawData) {
    try {
      String singleLineData = rawData.replaceAll('\n', ' ');

      singleLineData = singleLineData.replaceAllMapped(
        RegExp(r'([a-zA-Z0-9_]+):'),
        (match) => '${match[1]}:',
      );
      return singleLineData;
    } catch (e) {
      print(e.toString());
      return rawData;
    }
  }

  ////
  ////
  //// Fetch my contracts
  Future<void> fetchContracts() async {
    updateLoader(true);
    myContractsList.clear();

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: myContractsUrl);

      var reply = await networkHelper.postData({
        // "phone": "+971555347076"
        "phone": credentialController.phone.toString(),
      });

      List<dynamic> contractData = reply["details"]["userMessage"];

      if (contractData.first.toString() != "false") {
        for (var contract in contractData) {
          Map<String, dynamic> jsonData = jsonDecode(contract);

          print(jsonData);

          myContractsList.add(
            ContractModel(
                customerName: jsonData["Contact_Name"].toString() != "null"
                    ? nullCheckValue(
                        jsonData["Contact_Name"]["name"].toString())
                    : "-",
                contractNumber:
                    nullCheckValue(jsonData["Contract_Number"].toString()),
                status: nullCheckValue(jsonData["Contract_Status"].toString()),
                contract: nullCheckValue(jsonData["Contract"].toString()),
                amount: nullCheckValue(jsonData["Price"].toString()),
                amountCollected:
                    nullCheckValue(jsonData["Actual_Amount_Paid"].toString()),
                spBooklet:
                    nullCheckValue(jsonData["SP_Booklet_provided"].toString()),
                emirate: nullCheckValue(jsonData["Emirate"].toString()),
                number: nullCheckValue(jsonData["Number"].toString()),
                code: nullCheckValue(jsonData["Contract_Number"].toString()),
                vehicleBrand: jsonData["Vehicle_Brand"].toString() != "null"
                    ? nullCheckValue(
                        jsonData["Vehicle_Brand"]["name"].toString())
                    : "-",
                vehicleModel: jsonData["Vehicle_Model"].toString() != "null"
                    ? nullCheckValue(
                        jsonData["Vehicle_Model"]["name"].toString())
                    : "-",
                year: nullCheckValue(jsonData["Vehicle_Year"].toString()),
                chassisNumber:
                    nullCheckValue(jsonData["Chassis_no_VIN"].toString()),
                cylinders:
                    nullCheckValue(jsonData["Number_of_Cylinders"].toString()),
                totalServiceCount: nullValueCount(
                    jsonData["MP_Service_Count"].toString(),
                    jsonData["RP_Service_Count_1"].toString()),
                brandOrigin: nullCheckValue(jsonData["Car_Origin"].toString()),
                pastServiceDate: pastServiceDate(
                    convertDateTime(
                        jsonData["Minor_Service_1_Date_Regular"].toString()),
                    convertDateTime(
                        jsonData["Minor_Service_2_Date_Regular"].toString()),
                    convertDateTime(
                        jsonData["Minor_Service_3_Date_Regular"].toString()),
                    convertDateTime(
                        jsonData["Major_Service_1_Date_Regular"].toString()),
                    convertDateTime(
                        jsonData["Major_Service_2_Date_Regular"].toString())),
                minorServiceOneDate: convertDateTime(
                    jsonData["Minor_Service_1_Date_Regular"].toString()),
                minorServiceOneStatus: nullCheckValue(
                    jsonData["Minor_Service_1_Checkbox_Regular"].toString()),
                minorServiceTwoDate: convertDateTime(
                    jsonData["Minor_Service_2_Date_Regular"].toString()),
                minorServiceTwoStatus: nullCheckValue(
                    jsonData["Minor_Service_2_Checkbox_Regular"].toString()),
                minorServiceThreeDate: convertDateTime(
                    jsonData["Minor_Service_3_Date_Regular"].toString()),
                minorServiceThreeStatus: nullCheckValue(
                    jsonData["Minor_Service_3_Checkbox_Regular"].toString()),
                majorServiceOneDate: convertDateTime(
                    jsonData["Major_Service_1_Date_Regular"].toString()),
                majorServiceOneStatus:
                    nullCheckValue(jsonData["Major_Service_1_Checkbox_Regular"].toString()),
                majorServiceTwoDate: convertDateTime(jsonData["Major_Service_2_Date_Regular"].toString()),
                majorServiceTwoStatus: nullCheckValue(jsonData["Major_Service_2_Checkbox_Regular"].toString())),
          );
          update();
        }
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateLoader(false);
    }
  }

  ////
  ////
  //// Fetch my bookings
  Future<void> fetchBookings() async {
    updateLoader(true);
    myBookingsList.clear();

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: myBookingsUrl);

      var reply = await networkHelper.postData({
        // "phone": "+917247388055"
        "phone": credentialController.phone.toString(),
      });

      List<dynamic> bookingsData = reply["details"]["userMessage"];

      if (bookingsData.first.toString() != "false") {
        for (var booking in bookingsData) {
          Map<String, dynamic> jsonData = jsonDecode(booking);

          myBookingsList.add(
            BookingModel(
              appointmentNumber:
                  nullCheckValue(jsonData["Appointment_ID"].toString()),
              customerRequest: preprocessMultilineStrings(
                  nullCheckValue(jsonData["Customer_Request"].toString())),
              appointmentType:
                  nullCheckValue(jsonData["Appointment_Type"].toString()),
              jobType: nullCheckValue(jsonData["Type"].toString()),
              dateTime: convertDateTime(jsonData["Date_and_Time"].toString()),
              status: nullCheckValue(jsonData["Status"].toString()),
              pickupArea: nullCheckValue(jsonData["Location_Area"].toString()),
              pickupAddress:
                  nullCheckValue(jsonData["Pick_up_Address"].toString()),
              dropAddress: nullCheckValue(jsonData["Drop_Address"].toString()),
              dropArea:
                  nullCheckValue(jsonData["Drop_Location_Area"].toString()),
              locationLink:
                  nullCheckValue(jsonData["Location_link"].toString()),
              vehiceBrand: jsonData["Car_Make"].toString() != "null"
                  ? nullCheckValue(jsonData["Car_Make"]["name"].toString())
                  : "-",
              vehicleModel: jsonData["Car_Model"].toString() != "null"
                  ? nullCheckValue(jsonData["Car_Model"]["name"].toString())
                  : "-",
            ),
          );
          update();
        }
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateLoader(false);
    }
  }

  ////
  ////
  //// Fetch my vehicles
  Future<void> fetchVehicles() async {
    updateLoader(true);
    myVehicleList.clear();

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: myVehiclesUrl);

      var reply = await networkHelper.postData({
        // "phone": "+971555347076",
        "phone": credentialController.phone.toString(),
      });

      List<dynamic> vehicleData = reply["details"]["userMessage"];

      print(vehicleData);

      if (vehicleData.first.toString() != "false") {
        for (var i = 0; i < vehicleData.length; i++) {
          var vehicle = vehicleData[i];

          Map<String, dynamic> jsonData = jsonDecode(vehicle);

          myVehicleList.add(
            VehicleModel(
              vehiceBrand: jsonData["Brand"].toString() != "null"
                  ? nullCheckValue(jsonData["Brand"]["name"].toString())
                  : "-",
              vehicleModel: jsonData["Model"].toString() != "null"
                  ? nullCheckValue(jsonData["Model"]["name"].toString())
                  : "-",
              year: nullCheckValue(jsonData["Year"].toString()),
              chassisNumber: nullCheckValue(jsonData["Chassis_No"].toString()),
              cylinders: nullCheckValue(jsonData["Cylinders"].toString()),
              color: nullCheckValue(jsonData["Color"].toString()),
              brandOrigin: nullCheckValue(jsonData["Brand_Origin"].toString()),
              fuelType: nullCheckValue(jsonData["Fuel_Type"].toString()),
              plateEmirate:
                  nullCheckValue(jsonData["Plate_Emirate"].toString()),
              plateNumber: nullCheckValue(jsonData["Plate_No"].toString()),
              plateCode: nullCheckValue(jsonData["Plate_Code"].toString()),
              registrationStart: nullCheckValue(
                  jsonData["Mulkiya_Registration_Date"].toString()),
              registrationExpiry:
                  nullCheckValue(jsonData["Mulkiya_Expiry_Date"].toString()),
              insuranceStart:
                  nullCheckValue(jsonData["Insurance_start_Date"].toString()),
              insuranceEnd:
                  nullCheckValue(jsonData["Insurance_Expiry_Date"].toString()),
            ),
          );

          update();
        }
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateLoader(false);
    }
  }

  ////
  ////
  //// Create Booking
  Future<void> createBooking(CreateBookingModel data, String iso,
      String goldCustomer, String year) async {
    updateLoader(true);

    String userName = Get.find<AuthController>().userData!.fullName;

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: createBookingUrl);

      var reply = await networkHelper.postData({
        "phone": credentialController.phone,
        "year": year,
        "request": data.customerRequest,
        "appointmentType": data.appointmentType,
        "jobType": data.jobType,
        "area": data.area,
        "address": data.address,
        "locationLink": data.locationLink,
        "spHolder": data.spHolder,
        "userName": userName,
        "carMake": data.carMake,
        "carModel": data.carModel,
        "plateNumber": data.plateNumber,
        "dateIso": iso,
        "gold_customer": goldCustomer,
        "emirate": data.emirate,
      });

      print(reply);

      List<dynamic> response = reply["details"]["userMessage"];

      if (response[0].toString() == "true") {
        showToast("Booking successful");
        Get.back();
        fetchBookings();
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateLoader(false);
    }
  }

  ////
  ////
  //// Contact us

  sendEmail(context, String email, String comment, String type) async {
    String username = 'battmobile.apptesting@gmail.com';
    String password = 'pumt immb xydq dgdu';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Battmobile App')
      ..recipients.add('battmobile.apptesting@gmail.com')
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(const Address('bccAddress@example.com'))
      ..subject = type
      ..text = comment;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<void> contactUs(
      context, String email, String comment, String type) async {
    updateLoader(true);

    String firstName = Get.find<AuthController>().userData!.firstName;
    String lastName = Get.find<AuthController>().userData!.lastName;
    String mobile = credentialController.phone;

    try {
      final NetworkHelper networkHelper = NetworkHelper(url: contactUsUrl);

      var reply = await networkHelper.postData({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "notes": comment,
        "type": type,
      });

      print(reply);

      List<dynamic> response = reply["details"]["userMessage"];

      if (response[0].toString() == "true") {
        sendEmail(context, email, comment, type);
        showSuccessDialog(context);
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateLoader(false);
    }
  }

  ////
  ////
  //// Fetch vehicle brands
  int page = 1;

  updatePage() {
    page = 1;
    update();
  }

  bool vehicleLoad = false;
  bool isLoadingMore = false;

  updateVehicleLoader(bool val, bool more) {
    if (val) {
      if (more) {
        isLoadingMore = val;
        update();
      } else {
        vehicleLoad = val;
        update();
      }
    } else {
      vehicleLoad = val;
      isLoadingMore = val;
      update();
    }
  }

  Future<void> fetchVehicleBrands(bool loadMore) async {
    updateVehicleLoader(true, loadMore);

    if (!loadMore) {
      updatePage();
    }

    try {
      final NetworkHelper networkHelper =
          NetworkHelper(url: fetchVehicleBrandsUrl);

      var reply = await networkHelper.postData({
        "page": "$page",
      });

      List<dynamic> brandsData = reply["details"]["userMessage"];

      print(page);
      print(brandsData);

      if (brandsData[0].toString() != "false") {
        if (page == 1) {
          print(page);
          carBrands = brandsData[0].split(',');
          page++;
          update();
        } else {
          print(page);
          carBrands.addAll(brandsData[0].split(','));
          page++;
          update();
        }
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateVehicleLoader(false, false);
    }
  }

  Future<void> searchVehicleBrands(String val) async {
    updateVehicleLoader(true, false);

    updatePage();

    try {
      final NetworkHelper networkHelper =
          NetworkHelper(url: searchVehicleBrandsUrl);

      var reply = await networkHelper.postData({
        "search": val,
      });

      List<dynamic> brandsData = reply["details"]["userMessage"];

      if (brandsData[0].toString() != "false") {
        carBrands = brandsData[0].split(',');
        update();
      } else {
        carBrands = [];
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateVehicleLoader(false, false);
    }
  }

  ////
  ////
  //// Fetch vehicle brands
  Future<void> fetchVehicleModels(String brandName) async {
    updateVehicleLoader(true, false);
    carModels.clear();

    try {
      final NetworkHelper networkHelper =
          NetworkHelper(url: fetchVehicleModelsUrl);

      var reply = await networkHelper.postData({
        "brand": brandName,
      });

      List<dynamic> carModelsData = reply["details"]["userMessage"];

      if (carModelsData[0].toString() != "false") {
        carModels = carModelsData[0].split(',');
        update();
      } else {
        print("No Data Found");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateVehicleLoader(false, false);
    }
  }

  Future<void> searchVehicleModels(String val) async {
    updateVehicleLoader(true, false);

    updatePage();

    try {
      final NetworkHelper networkHelper =
          NetworkHelper(url: searchVehicleModelsUrl);

      var reply = await networkHelper.postData({
        "search": val,
      });

      List<dynamic> carModelsData = reply["details"]["userMessage"];

      print(carModelsData);

      if (carModelsData[0].toString() != "false") {
        carModels = carModelsData[0].split(',');
        update();
      } else {
        carModels = [];
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateVehicleLoader(false, false);
    }
  }

  ////
  ////
  //// Generate Access token through refreshToken
  Future<String?> generateAccessToken() async {
    try {
      final NetworkHelper networkHelper =
          NetworkHelper(url: generateAccessTokenByRefreshTokenOfInvoiceUrl);

      var reply = await networkHelper.postData({});

      return reply["access_token"];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ////
  ////
  ////
  //// Fetch my invoices
  Future<void> fetchInvoices() async {
    String email = Get.find<AuthController>().userData!.email;
    // String email = "100alameri@gmail.com";
    updateLoader(true);
    myInvoiceList.clear();

    try {
      String? accessToken = await generateAccessToken();

      if (accessToken != null) {
        final NetworkHelper networkHelper = NetworkHelper(
            url:
                "https://www.zohoapis.com/books/v3/invoices?organization_id=$organizationId&email=$email");

        var reply = await networkHelper.getInvoiceData(
          accessToken,
        );

        List<dynamic> invoiceData = reply["invoices"];

        if (invoiceData.isNotEmpty) {
          for (var invoice in invoiceData) {
            myInvoiceList.add(
              InvoiceModel(
                invoiceNumber:
                    nullCheckValue(invoice["invoice_number"].toString()),
                invoiceDate: formatDateTime(invoice["created_time"].toString()),
                invoiceAmount: nullCheckValue(invoice["total"].toString()),
                vehicleName: nullCheckValue(invoice["cf_make"].toString()),
                vehicleModel: nullCheckValue(invoice["cf_model"].toString()),
                invoiceUrl: nullCheckValue(invoice["invoice_url"].toString()),
                currency: invoice["currency_code"].toString() != "null" &&
                        invoice["currency_code"].toString() != ""
                    ? invoice["currency_code"].toString()
                    : "",
              ),
            );
          }
          update();
        } else {
          print("No invoices Found");
        }
      } else {
        print("Failed to generate access token");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      updateLoader(false);
    }
  }
}
