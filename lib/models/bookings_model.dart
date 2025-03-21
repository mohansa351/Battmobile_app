


class BookingModel {
  const BookingModel({
    required this.appointmentNumber,
    required this.customerRequest,
    required this.appointmentType,
    required this.jobType,
    required this.dateTime,
    required this.status,
    required this.pickupArea,
    required this.pickupAddress,
    required this.locationLink,
    required this.dropArea,
    required this.dropAddress,
    required this.vehiceBrand,
    required this.vehicleModel,
  });

  final String appointmentNumber;
  final String customerRequest;
  final String appointmentType;
  final String jobType;
  final String dateTime;
  final String status;
  final String pickupArea;
  final String pickupAddress;
  final String locationLink;
  final String dropArea;
  final String dropAddress;
  final String vehiceBrand;
  final String vehicleModel;
}




class CreateBookingModel {
  const CreateBookingModel({
    required this.bookingDate,
    required this.customerRequest,
    required this.appointmentType,
    required this.jobType,
    required this.area,
    required this.address,
    required this.spHolder,
    required this.locationLink,
    required this.carMake,
    required this.carModel,
    required this.plateNumber,
    required this.emirate,
  });

  final String bookingDate;
  final String customerRequest;
  final String appointmentType;
  final String jobType;
  final String area;
  final String address;
  final String locationLink;
  final String spHolder;
  final String carMake;
  final String carModel;
  final String plateNumber;
  final String emirate;
}


