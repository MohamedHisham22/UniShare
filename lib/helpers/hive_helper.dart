import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';

class HiveHelper {
  static Future<void> clearHive() async {
    var itemsBox =
        Hive.isBoxOpen('itemsBox')
            ? Hive.box<GetItemsModel>('itemsBox')
            : await Hive.openBox<GetItemsModel>('itemsBox');

    var recentlyViewedBox =
        Hive.isBoxOpen('recentlyViewItemsBox')
            ? Hive.box<RecentlyViewModel>('recentlyViewItemsBox')
            : await Hive.openBox<RecentlyViewModel>('recentlyViewItemsBox');

    print("ItemsBox length before clear: ${itemsBox.length}");
    print("RecentlyViewedBox length before clear: ${recentlyViewedBox.length}");

    await itemsBox.clear();
    await recentlyViewedBox.clear();

    print("Hive data cleared");
  }
}
