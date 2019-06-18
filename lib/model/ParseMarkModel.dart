class ParseMarkModel {
  int code;
  String msg;
  ParseOrderMarkModel data;

  ParseMarkModel({this.code, this.msg, this.data});

  ParseMarkModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new ParseOrderMarkModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ParseOrderMarkModel {
  int pageNum;
  int pageSize;
  int size;
  int startRow;
  int endRow;
  int total;
  int pages;
  List<ParseOrderMarkListModel> list;
  int prePage;
  int nextPage;
  bool isFirstPage;
  bool isLastPage;
  bool hasPreviousPage;
  bool hasNextPage;
  int navigatePages;

//  List<ParseOrderMarkListModel> navigatepageNums;
  int navigateFirstPage;
  int navigateLastPage;
  int firstPage;
  int lastPage;

  ParseOrderMarkModel(
      {this.pageNum,
      this.pageSize,
      this.size,
      this.startRow,
      this.endRow,
      this.total,
      this.pages,
      this.list,
      this.prePage,
      this.nextPage,
      this.isFirstPage,
      this.isLastPage,
      this.hasPreviousPage,
      this.hasNextPage,
      this.navigatePages,
//      this.navigatepageNums,
      this.navigateFirstPage,
      this.navigateLastPage,
      this.firstPage,
      this.lastPage});

  ParseOrderMarkModel.fromJson(Map<String, dynamic> json) {
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    startRow = json['startRow'];
    endRow = json['endRow'];
    total = json['total'];
    pages = json['pages'];
    if (json['list'] != null) {
      list = new List<ParseOrderMarkListModel>();
      json['list'].forEach((v) {
        list.add(new ParseOrderMarkListModel.fromJson(v));
      });
    }
    prePage = json['prePage'];
    nextPage = json['nextPage'];
    isFirstPage = json['isFirstPage'];
    isLastPage = json['isLastPage'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    navigatePages = json['navigatePages'];
//    navigatepageNums = json['navigatepageNums'].cast<int>();
    navigateFirstPage = json['navigateFirstPage'];
    navigateLastPage = json['navigateLastPage'];
    firstPage = json['firstPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    data['size'] = this.size;
    data['startRow'] = this.startRow;
    data['endRow'] = this.endRow;
    data['total'] = this.total;
    data['pages'] = this.pages;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['prePage'] = this.prePage;
    data['nextPage'] = this.nextPage;
    data['isFirstPage'] = this.isFirstPage;
    data['isLastPage'] = this.isLastPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    data['navigatePages'] = this.navigatePages;
//    data['navigatepageNums'] = this.navigatepageNums;
    data['navigateFirstPage'] = this.navigateFirstPage;
    data['navigateLastPage'] = this.navigateLastPage;
    data['firstPage'] = this.firstPage;
    data['lastPage'] = this.lastPage;
    return data;
  }
}

class ParseOrderMarkListModel {
  String orderId;
  int startTime;
  int endTime;
  int status;
  int createTime;
  String username;
  String fullName;
  List<OrderBookSeats> orderBookSeats;

  ParseOrderMarkListModel(
      {this.orderId,
      this.startTime,
      this.endTime,
      this.status,
      this.createTime,
      this.username,
      this.fullName,
      this.orderBookSeats});

  ParseOrderMarkListModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    createTime = json['createTime'];
    username = json['username'];
    fullName = json['fullName'];
    if (json['orderBookSeats'] != null) {
      orderBookSeats = new List<OrderBookSeats>();
      json['orderBookSeats'].forEach((v) {
        orderBookSeats.add(new OrderBookSeats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    if (this.orderBookSeats != null) {
      data['orderBookSeats'] =
          this.orderBookSeats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderBookSeats {
  String seatName;
  String address;

  OrderBookSeats({this.seatName, this.address});

  OrderBookSeats.fromJson(Map<String, dynamic> json) {
    seatName = json['seatName'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seatName'] = this.seatName;
    data['address'] = this.address;
    return data;
  }
}
