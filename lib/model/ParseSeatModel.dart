//解析选座位界面回传过来的数据
class ParseSeatModel {
  String seatName;//座位名称
  int seatX;//座位横坐标
  int seatY;//座位纵坐标
  int status;//座位状态

//构造方法
  ParseSeatModel({
    this.seatName,
    this.seatX,
    this.seatY,
    this.status
  });

  //工厂模式构造方法:实例化对象不用再使用new关键字
  factory ParseSeatModel.fromJson(dynamic json) {
    return ParseSeatModel(
        seatName: json['seatName'],
        seatX: json['seatX'],
        seatY: json['seatY'],
        status: json['status']);
  }
}

//循环的listModel
class ParseSeatModelListModel {

  List<ParseSeatModel> data;
  ParseSeatModelListModel(this.data);

  factory ParseSeatModelListModel.formJson(List json) {
    return ParseSeatModelListModel(
        json.map((i) => ParseSeatModel.fromJson((i))).toList());
  }
}
