////
////
//// Order model

class OrderModel {
  const OrderModel({
    required this.orderNumber,
    required this.date,
    required this.vehicleType,
    required this.service,
    required this.status,
    required this.amount,
    required this.paymentMethod,
    required this.servicePackage,
    required this.servicePackageAmount,
    required this.emirate,
    required this.area,
    required this.address,
    required this.additionalInfo,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.year,
    required this.chassisNumber,
    required this.cylinders,
    required this.brandOrigin,
  });

  final String orderNumber;
  final String date;
  final String vehicleType;
  final String service;
  final String status;
  final String amount;
  final String paymentMethod;
  final String servicePackage;
  final String servicePackageAmount;
  final String emirate;
  final String area;
  final String address;
  final String additionalInfo;
  final String vehicleBrand;
  final String vehicleModel;
  final String year;
  final String chassisNumber;
  final String cylinders;
  final String brandOrigin;
}



// {
//   "Owner": {
//     "name": "Jelourd",
//     "id": "5516116000097441001",
//     "email": "jelourd.battmobile@gmail.com"
//   },
//   "Preferred_Dates": null,
//   "$field_states": null,
//   "Contact_Name_for_GB": "Mr Ramin",
//   "Warranty_Period": null,
//   "INV_No": null,
//   "Emirate": "Dubai",
//   "Car_Origin": null,
//   "$state": "save",
//   "Oil_Brand": null,
//   "Oil_Model": null,
//   "Appointment_Booked": false,
//   "$process_flow": false,
//   "Currency": "AED",
//   "id": "5516116000138155159",
//   "$approval": {
//     "delegate": false,
//     "takeover": false,
//     "approve": false,
//     "reject": false,
//     "resubmit": false
//   },
//   "Push_to_Sale": null,
//   "Chasis_No": null,
//   "Created_Time": "2024-12-02T11:14:10+04:00",
//   "No_of_Cylinder": null,
//   "Payment_Method": null,
//   "Satisfy_with_Service": null,
//   "Next_Follow_up_date_time": null,
//   "Incentive_amount": null,
//   "Service_Required": "Battery Change",
//   "Car_or_Motorbike": "Car",
//   "Created_By": {
//     "name": "Jelourd",
//     "id": "5516116000097441001",
//     "email": "jelourd.battmobile@gmail.com"
//   },
//   "Did_not_respond": false,
//   "Push_for_SC": null,
//   "Description": "Ramin\n0507584439\nNissan pathfinder 2015\n\nDubai\nfestival center\n\ncharge accordingly\nbattery change\nplease call and reach in 30-35 mins\n\njel",
//   "Service_Center_sub_category": null,
//   "Cars_Origin": null,
//   "Price_Category": null,
//   "$review_process": {
//     "approve": false,
//     "reject": false,
//     "resubmit": false
//   },
//   "Enquiry_ID": "150558",
//   "Invoice_Date": null,
//   "User_1": {
//     "name": "Adnan Liaqat",
//     "id": "5516116000003427001"
//   },
//   "Enquiry_Via": "Call",
//   "Send_Sale_Referral_WA": false,
//   "Service_Package_Amount": null,
//   "Pushed_for_SC": null,
//   "Up_sell": null,
//   "Call_WhatsApp_Type": null,
//   "Job_Card_No": null,
//   "Amount": null,
//   "Referred_By": null,
//   "Cross_sell_SP_CC_Agent": null,
//   "Mobile": "971507584439",
//   "Enter_Location": null,
//   "Pushed_for_SC_No_Reason": null,
//   "$orchestration": false,
//   "Contact_Name": {
//     "name": "Mr Ramin",
//     "id": "5516116000138155135"
//   },
//   "Year": "2015",
//   "Price_Category_CC": "Charge Accordingly",
//   "Locked__s": false,
//   "Tag": [],
//   "Insurance_Purchased_Date": null,
//   "Tyre_Brand": null,
//   "Enquiry_Status": "Assigned to Technician",
//   "Expiry_Date": null,
//   "Email": null,
//   "$currency_symbol": "AED",
//   "Mulkiya_Registration_Date": null,
//   "Litre": null,
//   "$followers": null,
//   "SC_Appointment": null,
//   "Name": "Battery change",
//   "Last_Activity_Time": "2024-12-02T11:15:13+04:00",
//   "Over_time": null,
//   "Void_approved_by_Manager": false,
//   "Battery_Model": null,
//   "Unsubscribed_Mode": null,
//   "Exchange_Rate": 1,
//   "SC_Comments": null,
//   "$locked_for_me": false,
//   "Service_Advisor": null,
//   "$approved": true,
//   "No_of_Cylinders": null,
//   "Battery_Brand": null,
//   "Insurance_Expiry_Date": null,
//   "Car_Service_Package_Sold": "No",
//   "$followed": false,
//   "Appointment_status": null,
//   "Cross_sell_SP_Technician": null,
//   "$editable": true,
//   "Sold_by": null,
//   "Mulkiya_Expiry_Date": null,
//   "Additional_Info": null,
//   "Area": "Discovery Gardens",
//   "Car": null,
//   "Reject_Reason": null,
//   "SC_Team_Comments": null,
//   "$zia_owner_assignment": "owner_recommendation_unavailable",
//   "Tyre_Details": null,
//   "Product_lookup": null,
//   "Reason": null,
//   "Mark_as_void": false,
//   "Jump_Start_Reason": null,
//   "Modified_By": {
//     "name": "Joel Joel@battmobile.ae",
//     "id": "5516116000096319001",
//     "email": "joel.battmobil@gmail.com"
//   },
//   "$review": null,
//   "Gallabox_Contact_Name": null,
//   "Gallabox_Contact_Phone": null,
//   "SBR": null,
//   "Modified_Time": "2024-12-02T11:15:13+04:00",
//   "Push_for_SC_No_Reason": null,
//   "Unsubscribed_Time": null,
//   "Quantity": "1",
//   "Vehicle_Model": {
//     "name": "Pathfinder",
//     "id": "5516116000000628587"
//   },
//   "Date": "2024-12-02",
//   "$in_merge": false,
//   "Enquiry_Completion_Date": null,
//   "Vehice_Brand": {
//     "name": "Nissannnn",
//     "id": "5516116000029813723"
//   },
//   "$approval_state": "approved"
// }
