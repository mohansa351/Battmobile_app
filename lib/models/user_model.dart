

class UserModel {
  const UserModel({
    required this.recordId,
  required this.fullName,
  required this.firstName,
  required this.lastName,
  required this.email,
  required this.phoneNumber,
  required this.phoneNumber1,
  required this.phoneNumber2,
  required this.profileImage
  });

 final String recordId;
  final String phoneNumber;
  final String phoneNumber1;
  final String phoneNumber2;
  final String fullName;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImage;
}
