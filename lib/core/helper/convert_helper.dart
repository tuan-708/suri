import 'package:suri_checking_event_app/core/base_widgets/drop_down_button_base.dart';

class ConvertHelper {
  static List<Item> convertDataToDropDown(dynamic data) {
    List<Item> list = [];

    for (var element in data) {
      Item item = Item(key: element.name.toString(), value: element?.name);
      list.add(item);
    }

    return list;
  }

  static List<Item> convertBankDataToDropDown(dynamic data) {
    List<Item> list = [];

    for (var element in data) {
      Item item =
          Item(key: element.id.toString(), value: element.name.toString());
      list.add(item);
    }

    return list;
  }
}
