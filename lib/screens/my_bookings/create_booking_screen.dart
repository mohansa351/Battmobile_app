import 'package:batt_mobile/controllers/data_controller.dart';
import 'package:batt_mobile/models/bookings_model.dart';
import 'package:batt_mobile/screens/my_bookings/car_brands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_widgets.dart';
import '../../utils/constants.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pickupLinkController = TextEditingController();
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _carBrandController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _customerRequestController =
      TextEditingController();
  int sp_holder = 2;
  DateTime? selectedDateTime;
  String appoint_type = "";
  String job_type = "";
  String emirate_val = "";
  String car_brand = "";
  String car_model = "";
  String isoDate = "";
  String goldCustomer = "";

  /// Calender to appear before 6 pm
  Future<void> _selectPreDateTime(BuildContext context) async {
    
    DateTime initialDate = DateTime.now().add(const Duration(days: 1));

    // Ensure the initial date is not a Sunday
    while (initialDate.weekday == DateTime.sunday) {
      initialDate = initialDate.add(const Duration(days: 1));
    }


    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      selectableDayPredicate: (DateTime day) {
        return day.weekday != DateTime.sunday; // Disable Sundays
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            colorScheme: ColorScheme.light(primary: primaryColor),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (dateTime != null) {
      _dateTimeController.text =
          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      isoDate = "${dateTime.toLocal().toString().split(' ')[0]}T00:00:00+04:00";
      setState(() {});
    }
  }

  /// Calender to appear after 6 pm
  Future<void> _selectPostDateTime(BuildContext context) async {
    DateTime initialDate = DateTime.now().add(const Duration(days: 2));

    // Ensure the initial date is not a Sunday
    while (initialDate.weekday == DateTime.sunday) {
      initialDate = initialDate.add(const Duration(days: 1));
    }

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      selectableDayPredicate: (DateTime day) {
        return day.weekday != DateTime.sunday; // Disable Sundays
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            colorScheme: ColorScheme.light(primary: primaryColor),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (dateTime != null) {
      _dateTimeController.text =
          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      isoDate = "${dateTime.toLocal().toString().split(' ')[0]}T00:00:00+04:00";
      setState(() {});
    }
  }

  bool isPast6PM() {
    final now = DateTime.now();
    return now.hour >= 18; // 18 represents 6 PM in 24-hour format
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, "New Booking", true),
        body: GetBuilder<DataController>(
          builder: (DataController controller) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Date Time of appointment
                    const SizedBox(height: 20),
                    RichText(
                      text: const TextSpan(
                        text: " Date and Time",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        if (isPast6PM()) {
                          _selectPostDateTime(context);
                        } else {
                         _selectPreDateTime(context);
                        }
                      },
                      child: CustomTextField(
                          hintText: "Select",
                          enabled: false,
                          suffix: const Icon(Icons.calendar_month),
                          controller: _dateTimeController),
                    ),

                    /// Customer request of appointment
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text: " Customer Request",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Enter here",
                        controller: _customerRequestController),

                    /// Appointment type
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text: " Appointment Type",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomDropdown(
                      onChanged: (val) {
                        appoint_type = val;
                        setState(() {});
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Self Drop",
                          child: Text(
                            "Self Drop",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Need Battmobile Pickup",
                          child: Text(
                            "Need Battmobile Pickup",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),

                    /// Job Type
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text: " Job Type",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomDropdown(
                      onChanged: (val) {
                        job_type = val;
                        setState(() {});
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Service",
                          child: Text(
                            "Service",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Running Repair",
                          child: Text(
                            "Running Repair",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Tyre",
                          child: Text(
                            "Tyre",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Minor Service",
                          child: Text(
                            "Minor Service",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Major Service",
                          child: Text(
                            "Major Service",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),

                    /// Emirates
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        text: " Emirates",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          appoint_type != "Self Drop"
                              ? const TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    color: Colors.red, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const TextSpan(
                                  text: " (Optional)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        Colors.black, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomDropdown(
                      onChanged: (val) {
                        emirate_val = val;
                        setState(() {});
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Abu Dhabi",
                          child: Text(
                            "Abu Dhabi",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Dubai",
                          child: Text(
                            "Dubai",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Sharjah",
                          child: Text(
                            "Sharjah",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Ajman",
                          child: Text(
                            "Ajman",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Umm Al-Quwain",
                          child: Text(
                            "Umm Al-Quwain",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Ras Al-Khaimah",
                          child: Text(
                            "Ras Al-Khaimah",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Fujairah",
                          child: Text(
                            "Fujairah",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),

                    /// Area of the appointment
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        text: " Area",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          appoint_type != "Self Drop"
                              ? const TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    color: Colors.red, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const TextSpan(
                                  text: " (Optional)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        Colors.black, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Enter here", controller: _areaController),

                    /// Address of the appointment
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        text: " Address",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          appoint_type != "Self Drop"
                              ? const TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    color: Colors.red, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const TextSpan(
                                  text: " (Optional)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        Colors.black, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Enter here", controller: _addressController),

                    /// Pickup location link of the appointment
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        text: " Pickup Location Link",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          appoint_type != "Self Drop"
                              ? const TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                    color: Colors.red, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const TextSpan(
                                  text: " (Optional)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        Colors.black, // Make the asterisk red
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Enter here",
                        controller: _pickupLinkController),

                    /// SP Holder
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text: " SP Holder",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                sp_holder = 1;
                                setState(() {});
                              },
                              child: sp_holder == 1
                                  ? const Icon(Icons.circle)
                                  : const Icon(Icons.circle_outlined),
                            ),
                            const SizedBox(width: 7),
                            const Text(
                              " Yes",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(width: 25),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                sp_holder = 2;
                                setState(() {});
                              },
                              child: sp_holder == 2
                                  ? const Icon(Icons.circle)
                                  : const Icon(Icons.circle_outlined),
                            ),
                            const SizedBox(width: 7),
                            const Text(
                              " No",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),

                    /// Gold customer type
                    const SizedBox(height: 35),
                    RichText(
                      text: const TextSpan(
                        text: " Are you a gold customer?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomDropdown(
                      onChanged: (val) {
                        goldCustomer = val;
                        setState(() {});
                      },
                      items: [
                        DropdownMenuItem(
                            value: "Yes",
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.green.shade300),
                                const SizedBox(width: 10),
                                const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                        DropdownMenuItem(
                            value: "No",
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.red.shade400),
                                const SizedBox(width: 10),
                                const Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                      ],
                    ),

                    /// Car Brands
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        text: " Car Brand",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        List done = await Get.to(() => const CarBrands());
                        if (done[0] == "true") {
                          car_brand = done.last;
                          _carBrandController.text = done.last;
                          _carModelController.text = "";
                          car_model = "";
                          setState(() {});
                        }
                        // onTextFieldTap(
                        //     context,
                        //     "Select",
                        //     controller.carBrands.map((brand) {
                        //       return SelectedListItem(
                        //         value: brand,
                        //         name: brand,
                        //       );
                        //     }).toList(), (val) {
                        //   car_brand = val.toString();
                        //   _carBrandController.text = val.toString();
                        //   print(val);
                        //   setState(() {});
                        // });
                      },
                      child: CustomTextField(
                          controller: _carBrandController,
                          hintText: "Select",
                          enabled: false),
                    ),

                    /// Car Models
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text: " Car Model",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        if (car_brand != "") {
                          List done =
                              await Get.to(() => CarModels(brand: car_brand));
                          if (done[0] == "true") {
                            car_model = done.last;
                            _carModelController.text = done.last;
                            setState(() {});
                          }
                        } else {
                          showToast(
                              "Select a vehicle brand before choosing a model");
                        }
                        // onTextFieldTap(
                        //     context,
                        //     "Select",
                        //     controller.carModels.map((model) {
                        //       return SelectedListItem(
                        //         value: model,
                        //         name: model,
                        //       );
                        //     }).toList(), (val) {
                        //   car_model = val.toString();
                        //   _carModelController.text = val.toString();
                        //   print(val);
                        //   setState(() {});
                        // });
                      },
                      child: CustomTextField(
                          controller: _carModelController,
                          hintText: "Select",
                          enabled: false),
                    ),

                    /// Plate Number
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text: " Plate Number",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Enter here",
                        controller: _plateNumberController),

                    /// Year
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text: " Year",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                              color: Colors.red, // Make the asterisk red
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Enter here",
                        inputType: TextInputType.number,
                        controller: _yearController),

                    const SizedBox(height: 45),

                    Row(
                      children: [
                        controller.dataLoader
                            ? const CustomLoader(
                                width: 90,
                              )
                            : CustomButton(
                                title: "Create",
                                onTap: () {
                                  String bookingDate = _dateTimeController.text;
                                  String customerRequest =
                                      _customerRequestController.text;
                                  String appointmentType = appoint_type;
                                  String jobType = job_type;
                                  String area = _areaController.text;
                                  String address = _addressController.text;
                                  String spHolder =
                                      sp_holder == 1 ? "Yes" : "No";
                                  String locationLink =
                                      _pickupLinkController.text;
                                  String carMake = car_brand;
                                  String carModel = car_model;
                                  String plateNumber =
                                      _plateNumberController.text;

                                  String year = _yearController.text;

                                  if (appointmentType != "Self Drop") {
                                    if (_dateTimeController.text.isNotEmpty &&
                                        _customerRequestController
                                            .text.isNotEmpty &&
                                        appoint_type != "" &&
                                        jobType != "" &&
                                        _areaController.text.isNotEmpty &&
                                        _addressController.text.isNotEmpty &&
                                        _pickupLinkController.text.isNotEmpty &&
                                        car_brand != "" &&
                                        car_model != "" &&
                                        goldCustomer != "" &&
                                        emirate_val != "" &&
                                        _plateNumberController
                                            .text.isNotEmpty &&
                                        _yearController.text.isNotEmpty) {
                                      CreateBookingModel bookingData =
                                          CreateBookingModel(
                                              bookingDate: bookingDate,
                                              customerRequest: customerRequest,
                                              appointmentType: appointmentType,
                                              jobType: jobType,
                                              area: area,
                                              address: address,
                                              spHolder: spHolder,
                                              locationLink: locationLink,
                                              carMake: carMake,
                                              carModel: carModel,
                                              plateNumber: plateNumber,
                                              emirate: emirate_val);

                                      controller.createBooking(bookingData,
                                          isoDate, goldCustomer, year);
                                    } else {
                                      showToast("All fields are mandatory");
                                    }
                                  } else {
                                    if (_dateTimeController.text.isNotEmpty &&
                                        _customerRequestController
                                            .text.isNotEmpty &&
                                        appoint_type != "" &&
                                        jobType != "" &&
                                        car_brand != "" &&
                                        car_model != "" &&
                                        goldCustomer != "" &&
                                        _plateNumberController
                                            .text.isNotEmpty &&
                                        _yearController.text.isNotEmpty) {
                                      CreateBookingModel bookingData =
                                          CreateBookingModel(
                                              bookingDate: bookingDate,
                                              customerRequest: customerRequest,
                                              appointmentType: appointmentType,
                                              jobType: jobType,
                                              area: area,
                                              address: address,
                                              spHolder: spHolder,
                                              locationLink: locationLink,
                                              carMake: carMake,
                                              carModel: carModel,
                                              plateNumber: plateNumber,
                                              emirate: emirate_val);

                                      controller.createBooking(bookingData,
                                          isoDate, goldCustomer, year);
                                    } else {
                                      showToast("All fields are mandatory");
                                    }
                                  }
                                },
                                width: 90,
                                txtColor: Colors.white),
                        const SizedBox(width: 20),
                        CustomButton(
                            title: "Cancel",
                            onTap: () {
                              Navigator.pop(context);
                            },
                            width: 90,
                            btnColor: Colors.white,
                            txtColor: primaryColor),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
