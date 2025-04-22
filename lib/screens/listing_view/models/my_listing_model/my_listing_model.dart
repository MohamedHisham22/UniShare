class MyListingModel {
  String? itemId;
  String? itemName;
  String? itemDescription;
  int? itemPrice;
  int? itemYear;
  String? itemBrand;
  String? imageUrl;
  dynamic userId;
  String? listingOption;
  dynamic itemDuration;
  String? itemCondition;
  String? createdAt;
  dynamic imageFile;

  MyListingModel({
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
  });

  factory MyListingModel.fromJson(Map<String, dynamic> json) {
    return MyListingModel(
      itemId: json['itemId'] as String?,
      itemName: json['itemName'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemPrice: json['itemPrice'] as int?,
      itemYear: json['itemYear'] as int?,
      itemBrand: json['itemBrand'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as dynamic,
      listingOption: json['listingOption'] as String?,
      itemDuration: json['itemDuration'] as dynamic,
      itemCondition: json['itemCondition'] as String?,
      createdAt: json['createdAt'] as String?,
      imageFile: json['imageFile'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemPrice': itemPrice,
      'itemYear': itemYear,
      'itemBrand': itemBrand,
      'imageUrl': imageUrl,
      'userId': userId,
      'listingOption': listingOption,
      'itemDuration': itemDuration,
      'itemCondition': itemCondition,
      'createdAt': createdAt,
      'imageFile': imageFile,
    };
  }
}
