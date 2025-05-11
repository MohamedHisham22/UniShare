import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  final String? email;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? location;
  @HiveField(4)
  final String? phoneNumber;
  @HiveField(5)
  final String? userID;
  @HiveField(6)
  final String? password;
  @HiveField(7)
  final String? type;

  UserModel({
     this.email,
     this.firstName,
     this.lastName,
     this.location,
     this.phoneNumber,
     this.userID,
     this.password,
     this.type,
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
