class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String location;
  final String phoneNumber;
  final String userID;
  final String password;
  final String type;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.phoneNumber,
    required this.userID,
    required this.password,
    required this.type,
  });

  factory UserModel.fromSnapshot(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      location: data['location'],
      phoneNumber: data['phone'],
      userID: data['uid'],
      password: data['password'],
      type: data['type'],
    );
  }
}
