class ParseDetailData {
  String orderId; //订单编号
  int startTime; //预定开始时间
  int endTime; //预定结束时间
  int status; //当前预定的状态
  String username; //预定人的账号
  String tel; //预定人的电话号码
  String fullName; //预定人的姓名
  List<dynamic> orderBookSeats; //预定座位的地理位置

  ParseDetailData(
      {this.orderId,
      this.startTime,
      this.endTime,
      this.status,
      this.username,
      this.tel,
      this.fullName,
      this.orderBookSeats});

  factory ParseDetailData.fromJson(dynamic json) {
    return ParseDetailData(
      orderId: json['orderId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      username: json['username'],
      tel: json['tel'],
      fullName: json['fullName'],
      orderBookSeats: json['orderBookSeats'],
    );
  }
}
