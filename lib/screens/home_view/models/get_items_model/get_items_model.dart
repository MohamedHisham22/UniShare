import 'package:hive/hive.dart';

part 'get_items_model.g.dart';

@HiveType(typeId: 0)
class GetItemsModel extends HiveObject{
  @HiveField(0)
  String? itemId;
  @HiveField(1)
  String? itemName;
  @HiveField(2)
  String? itemDescription;
  @HiveField(3)
  int? itemPrice;
  @HiveField(4)
  int? itemYear;
  @HiveField(5)
  String? itemBrand;
  @HiveField(6)
  String? imageUrl;
  @HiveField(7)
  String? userId;
  @HiveField(8)
  dynamic imageFile;
  @HiveField(9)
  String? createdAt;
  @HiveField(10)
  List<String>? additionalImageUrls;

  GetItemsModel({
    this.itemId,
    this.itemName,
    this.itemDescription,
    this.itemPrice,
    this.itemYear,
    this.itemBrand,
    this.imageUrl,
    this.userId,
    this.imageFile,
    this.createdAt,
    this.additionalImageUrls,
  });

  factory GetItemsModel.fromjson(Map<String, dynamic> json) {
    return GetItemsModel(
      itemId: json['itemId'] as String?,
      itemName: json['itemName'] as String?,
      itemDescription: json['itemDescription'] as String?,
      itemPrice: json['itemPrice'] as int?,
      itemYear: json['itemYear'] as int?,
      itemBrand: json['itemBrand'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String?,
      imageFile: json['imageFile'] as dynamic,
      createdAt: json['createdAt'] as String,
      additionalImageUrls:
          (json['additionalImageUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemPrice': itemPrice,
      'itemYear': itemYear,
      'itemBrand': itemBrand,
      'imageUrl': imageUrl,
      'userId': userId,
      'imageFile': imageFile,
      'createdAt': createdAt,
      'AdditionalImageFiles': additionalImageUrls,
    };
  }
}
