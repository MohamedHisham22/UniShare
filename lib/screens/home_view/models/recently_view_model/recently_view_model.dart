
import 'package:hive/hive.dart';

part 'recently_view_model.g.dart';

@HiveType(typeId: 1)
class RecentlyViewModel extends HiveObject{
  @HiveField(0)
  String? itemId;
  @HiveField(1)
  String? itemName;
  @HiveField(2)
  String? imageUrl;
  @HiveField(3)
  dynamic userId;
  @HiveField(4)
  DateTime? viewedAt;

  RecentlyViewModel({
    this.itemId,
    this.itemName,
    this.imageUrl,
    this.userId,
    this.viewedAt,
  });

  factory RecentlyViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RecentlyViewModel(
      itemId: json['itemId'] as String?,
      itemName: json['itemName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as dynamic,
      viewedAt:
          json['viewedAt'] == null
              ? null
              : DateTime.parse(json['viewedAt'] as String),
    );
  }

  Map<String, dynamic>
  toJson() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'imageUrl': imageUrl,
      'userId': userId,
      'viewedAt': viewedAt?.toIso8601String(),
    };
  }
}
