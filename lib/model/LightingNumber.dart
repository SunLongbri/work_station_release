import 'dart:convert' show json;

class LightingNumber {

  String request;
  List<int> addrs_list;

  LightingNumber.fromParams({this.request, this.addrs_list});

  factory LightingNumber(jsonStr) => jsonStr == null ? null : jsonStr is String ? new LightingNumber.fromJson(json.decode(jsonStr)) : new LightingNumber.fromJson(jsonStr);

  LightingNumber.fromJson(jsonRes) {
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