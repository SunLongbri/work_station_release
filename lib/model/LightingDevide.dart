import 'dart:convert' show json;

class LightingDevice {

  String request;
  List<int> addrs_list;

  LightingDevice.fromParams({this.request, this.addrs_list});

  factory LightingDevice(jsonStr) => jsonStr == null ? null : jsonStr is String ? new LightingDevice.fromJson(json.decode(jsonStr)) : new LightingDevice.fromJson(jsonStr);

  LightingDevice.fromJson(jsonRes) {
    request = jsonRes['request'];
    addrs_list = jsonRes['addrs_list'] == null ? null : [];

    for (var addrs_listItem in addrs_list == null ? [] : jsonRes['addrs_list']){
      addrs_list.add(addrs_listItem);
    }
  }

  @override
  String toString() {
    return '{"request": ${request != null?'${json.encode(request)}':'null'},"addrs_list": $addrs_list}';
  }
}

