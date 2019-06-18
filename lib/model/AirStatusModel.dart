//空调状态模型
class AirStatusModel {
  int code;
  String msg;
  AirStatusModelList data;

  AirStatusModel({this.code, this.msg, this.data});

  AirStatusModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new AirStatusModelList.fromJson(json['data'])
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

class AirStatusModelList {
  List<AirCondition> list;
  int size;

  AirStatusModelList({this.list, this.size});

  AirStatusModelList.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<AirCondition>();
      json['list'].forEach((v) {
        list.add(new AirCondition.fromJson(v));
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

class AirCondition {
  String floorName;
  String deivceId;
  String deviceDesc;
  String oNOFFControl;
  String oNOFFStatus;
  String modelStatus;
  String tempRM;
  String tempSP;

  AirCondition(
      {this.floorName,
      this.deivceId,
      this.deviceDesc,
      this.oNOFFControl,
      this.oNOFFStatus,
      this.modelStatus,
      this.tempRM,
      this.tempSP});

  AirCondition.fromJson(Map<String, dynamic> json) {
    floorName = json['floorName'];
    deivceId = json['deivceId'];
    deviceDesc = json['deviceDesc'];
    oNOFFControl = json['ON_OFFControl'];
    oNOFFStatus = json['ON_OFFStatus'];
    modelStatus = json['ModelStatus'];
    tempRM = json['Temp_RM'];
    tempSP = json['Temp_SP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floorName'] = this.floorName;
    data['deivceId'] = this.deivceId;
    data['deviceDesc'] = this.deviceDesc;
    data['ON_OFFControl'] = this.oNOFFControl;
    data['ON_OFFStatus'] = this.oNOFFStatus;
    data['ModelStatus'] = this.modelStatus;
    data['Temp_RM'] = this.tempRM;
    data['Temp_SP'] = this.tempSP;
    return data;
  }
}
