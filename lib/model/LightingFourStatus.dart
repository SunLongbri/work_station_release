class LightingFourStatus {
  String tid;
  String name;
  String meshId;
  String version;
  String idfVersion;
  String mdfVersion;
  int mlinkTrigger;
  int mlinkVersion;
  List<Characteristics> characteristics;
  String statusMsg;
  int statusCode;

  LightingFourStatus(
      {this.tid,
      this.name,
      this.meshId,
      this.version,
      this.idfVersion,
      this.mdfVersion,
      this.mlinkTrigger,
      this.mlinkVersion,
      this.characteristics,
      this.statusMsg,
      this.statusCode});

  LightingFourStatus.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    name = json['name'];
    meshId = json['mesh_id'];
    version = json['version'];
    idfVersion = json['idf_version'];
    mdfVersion = json['mdf_version'];
    mlinkTrigger = json['mlink_trigger'];
    mlinkVersion = json['mlink_version'];
    if (json['characteristics'] != null) {
      characteristics = new List<Characteristics>();
      json['characteristics'].forEach((v) {
        characteristics.add(new Characteristics.fromJson(v));
      });
    }
    statusMsg = json['status_msg'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['name'] = this.name;
    data['mesh_id'] = this.meshId;
    data['version'] = this.version;
    data['idf_version'] = this.idfVersion;
    data['mdf_version'] = this.mdfVersion;
    data['mlink_trigger'] = this.mlinkTrigger;
    data['mlink_version'] = this.mlinkVersion;
    if (this.characteristics != null) {
      data['characteristics'] =
          this.characteristics.map((v) => v.toJson()).toList();
    }
    data['status_msg'] = this.statusMsg;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Characteristics {
  int cid;
  String name;
  String format;
  int perms;
  int value;
  int min;
  int max;
  int step;

  Characteristics(
      {this.cid,
      this.name,
      this.format,
      this.perms,
      this.value,
      this.min,
      this.max,
      this.step});

  Characteristics.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    name = json['name'];
    format = json['format'];
    perms = json['perms'];
    value = json['value'];
    min = json['min'];
    max = json['max'];
    step = json['step'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['name'] = this.name;
    data['format'] = this.format;
    data['perms'] = this.perms;
    data['value'] = this.value;
    data['min'] = this.min;
    data['max'] = this.max;
    data['step'] = this.step;
    return data;
  }
}
