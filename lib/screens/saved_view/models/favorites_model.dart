class FavoritesModel {
  String? userId;
  String? itemId;
  String? itemName;
  String? itemImageUrl;

  FavoritesModel({this.userId, this.itemId, this.itemName, this.itemImageUrl});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemImageUrl = json['itemImageUrl'];
  }
}
