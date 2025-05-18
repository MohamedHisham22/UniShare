class GettingImage {
  final String? userId;
  final String? profileImage;

  GettingImage({ this.userId, this.profileImage});

  factory GettingImage.fromJson(Map<String, dynamic> json) {
    return GettingImage(
      userId: json['userId'] ?? '',
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'profileImage': profileImage,
    };
  }
}