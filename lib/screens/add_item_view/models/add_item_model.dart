class AddItemModel {
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
  DateTime? createdAt;
  dynamic imageFile;
  List<String>? additionalImageUrls;

  AddItemModel({
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

  factory AddItemModel.fromJson(Map<String, dynamic> json) {
    return AddItemModel(
      itemId: json['itemId'] as String?,
      itemName: json['itemName'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemPrice: json['itemPrice'] as int?,
      itemYear: json['itemYear'] as int?,
      itemBrand: json['itemBrand'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String?,
      listingOption: json['listingOption'] as String?,
      itemDuration: json['itemDuration'] as String?,
      itemCondition: json['itemCondition'] as String?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      imageFile: json['imageFile'],
      additionalImageUrls:
          (json['additionalImageUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
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
      'createdAt': createdAt?.toIso8601String(),
      'imageFile': imageFile,
      'AdditionalImageFiles': additionalImageUrls,
    };
  }
}
