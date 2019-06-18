import 'dart:convert' show json;

//控制灯控开关的拼接JSon模型类
class LightingSetStatus {
  String request;
  List<int> addrs_list;
  List<ControlSwith> characteristics;

  LightingSetStatus.fromParams(
      {this.request, this.addrs_list, this.characteristics});

  factory LightingSetStatus(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new LightingSetStatus.fromJson(json.decode(jsonStr))
          : new LightingSetStatus.fromJson(jsonStr);

  LightingSetStatus.fromJson(jsonRes) {
    request = jsonRes['request'];
    addrs_list = jsonRes['addrs_list'] == null ? null : [];

    for (var addrs_listItem
        in addrs_list == null ? [] : jsonRes['addrs_list']) {
      addrs_list.add(addrs_listItem);
    }

    characteristics = jsonRes['characteristics'] == null ? null : [];

    for (var characteristicsItem
        in characteristics == null ? [] : jsonRes['characteristics']) {
      characteristics.add(characteristicsItem == null
          ? null
          : new ControlSwith.fromJson(characteristicsItem));
    }
  }

  @override
  String toString() {
    return '{"request": ${request != null ? '${json.encode(request)}' : 'null'},"addrs_list": $addrs_list,"characteristics": $characteristics}';
  }
}

class ControlSwith {
  int cid;
  int value;

  ControlSwith.fromParams({this.cid, this.value});

  ControlSwith.fromJson(jsonRes) {
    cid = jsonRes['cid'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"cid": $cid,"value": $value}';
  }
}
