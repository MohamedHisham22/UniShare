import 'dart:io';

class ItemDetailesModel {
  String? itemId;
  String? itemName;
  String? itemDescription;
  int? itemPrice;
  int? itemYear;
  String? itemBrand;
  String? imageUrl;
  String? userId;
  String? listingOption;
  String? itemDuration;
  String? itemCondition;
  String? createdAt;
  File? imageFile;
  List<String>? additionalImageUrls;

  ItemDetailesModel({
    this.itemId,
    this.itemName,
    this.itemDescription,
    this.itemPrice,
    this.itemYear,
    this.itemBrand,
    this.imageUrl,
    this.userId,
    this.listingOption,
    this.itemDuration,
    this.itemCondition,
    this.createdAt,
    this.imageFile,
    this.additionalImageUrls,
  });

  ItemDetailesModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    itemPrice = json['itemPrice'];
    itemYear = json['itemYear'];
    itemBrand = json['itemBrand'];
    imageUrl = json['imageUrl'];
    userId = json['userId'];
    listingOption = json['listingOption'];
    itemDuration = json['itemDuration'];
    itemCondition = json['itemCondition'];
    createdAt = json['createdAt'];
    imageFile = json['imageFile'];
    additionalImageUrls =
        (json['additionalImageUrls'] as List?)
            ?.map((e) => e.toString())
            .toList();
  }
}
