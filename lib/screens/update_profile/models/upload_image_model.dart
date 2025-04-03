class UploadImage {
  String? message;
  User? user;

  UploadImage({this.message, this.user});

  UploadImage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  String? userId;
  String? profileImage;

  User({this.userId, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profileImage = json['profileImage'];
  }
}
