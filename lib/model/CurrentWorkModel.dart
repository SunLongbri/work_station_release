class CurrentWorkModel {
  int code;
  String msg;
  CurrentWorkModelList data;

  CurrentWorkModel({this.code, this.msg, this.data});

  CurrentWorkModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new CurrentWorkModelList.fromJson(json['data'])
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

class CurrentWorkModelList {
  List<WorkState> list;
  int size;

  CurrentWorkModelList({this.list, this.size});

  CurrentWorkModelList.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<WorkState>();
      json['list'].forEach((v) {
        list.add(new WorkState.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class WorkState {
  int id;
  String mac;
  String name;
  int status;
  String bacnet;
  int seatX;
  int seatY;

  WorkState(
      {this.id,
      this.mac,
      this.name,
      this.status,
      this.bacnet,
      this.seatX,
      this.seatY});

  WorkState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mac = json['mac'];
    name = json['name'];
    status = json['status'];
    bacnet = json['bacnet'];
    seatX = json['seatX'];
    seatY = json['seatY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mac'] = this.mac;
    data['name'] = this.name;
    data['status'] = this.status;
    data['bacnet'] = this.bacnet;
    data['seatX'] = this.seatX;
    data['seatY'] = this.seatY;
    return data;
  }
}
