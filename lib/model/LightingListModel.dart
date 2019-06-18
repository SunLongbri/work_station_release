class LightingListModel {
  int meshNodeNum;
  String meshNodeMac;
  int cmdStatus;
  String statusMsg;
  int statusCode;

  LightingListModel(
      {this.meshNodeNum,
        this.meshNodeMac,
        this.cmdStatus,
        this.statusMsg,
        this.statusCode});

  LightingListModel.fromJson(Map<String, dynamic> json) {
    meshNodeNum = json['Mesh-Node-Num'];
    meshNodeMac = json['Mesh-Node-Mac'];
    cmdStatus = json['cmd_status'];
    statusMsg = json['status_msg'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Mesh-Node-Num'] = this.meshNodeNum;
    data['Mesh-Node-Mac'] = this.meshNodeMac;
    data['cmd_status'] = this.cmdStatus;
    data['status_msg'] = this.statusMsg;
    data['status_code'] = this.statusCode;
    return data;
  }
}