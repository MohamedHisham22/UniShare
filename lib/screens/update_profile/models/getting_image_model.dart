class GettingImage {
  String? userId;
  String? profileImage;

  GettingImage({this.userId, this.profileImage});

  GettingImage.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profileImage = json['profileImage'];
  }
}
