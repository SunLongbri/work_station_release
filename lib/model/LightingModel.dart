class LightingModel {
  int code;
  String msg;
  Extend extend;

  LightingModel({this.code, this.msg, this.extend});

  LightingModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    extend =
    json['extend'] != null ? new Extend.fromJson(json['extend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.extend != null) {
      data['extend'] = this.extend.toJson();
    }
    return data;
  }
}

class Extend {
  F4 f4;

  Extend({this.f4});

  Extend.fromJson(Map<String, dynamic> json) {
    f4 = json['F4'] != null ? new F4.fromJson(json['F4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.f4 != null) {
      data['F4'] = this.f4.toJson();
    }
    return data;
  }
}

class F4 {
  LightPoint lightPoint;
  PersonPoint personPoint;
  OtherInfo otherInfo;

  F4({this.lightPoint, this.personPoint, this.otherInfo});

  F4.fromJson(Map<String, dynamic> json) {
    lightPoint = json['lightPoint'] != null
        ? new LightPoint.fromJson(json['lightPoint'])
        : null;
    personPoint = json['personPoint'] != null
        ? new PersonPoint.fromJson(json['personPoint'])
        : null;
    otherInfo = json['otherInfo'] != null
        ? new OtherInfo.fromJson(json['otherInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lightPoint != null) {
      data['lightPoint'] = this.lightPoint.toJson();
    }
    if (this.personPoint != null) {
      data['personPoint'] = this.personPoint.toJson();
    }
    if (this.otherInfo != null) {
      data['otherInfo'] = this.otherInfo.toJson();
    }
    return data;
  }
}

class LightPoint {
  String lgt01;
  String lgt02;
  String lgt03;
  String lgt04;
  String lgt05;
  String lgt06;
  String lgt07;
  String lgt08;
  String lgt09;
  String lgt10;
  String lgt11;
  String lgt12;
  String lgt13;
  String lgt14;
  String lgt15;
  String lgt16;
  String lgt17;
  String lgt18;
  String lgt19;
  String lgt20;
  String lgt21;
  String lgt22;
  String lgt23;
  String lgt24;
  String lgt25;
  String lgt26;
  String lgt27;
  String lgt28;
  String lgt29;
  String lgt30;
  String lgt31;
  String lgt32;
  String lgt33;
  String lgt34;
  String lgt35;
  String lgt36;
  String lgt37;
  String lgt38;
  String lgt39;
  String lgt40;
  String lgt41;
  String lgt42;
  String lgt43;
  String lgt44;
  String lgt45;
  String lgt46;
  String lgt47;
  String lgt48;
  String lgt49;
  String lgt50;
  String lgt51;
  String lgt52;
  String lgt53;
  String lgt54;
  String lgt55;
  String lgt56;
  String lgt57;
  String lgt58;
  String lgt59;
  String lgt60;
  String lgt61;
  String lgt62;
  String lgt63;
  String lgt64;
  String lgt65;
  String lgt66;
  String lgt67;
  String lgt68;
  String totalLightNum;
  String lightOnRate;

  LightPoint(
      {this.lgt01,
        this.lgt02,
        this.lgt03,
        this.lgt04,
        this.lgt05,
        this.lgt06,
        this.lgt07,
        this.lgt08,
        this.lgt09,
        this.lgt10,
        this.lgt11,
        this.lgt12,
        this.lgt13,
        this.lgt14,
        this.lgt15,
        this.lgt16,
        this.lgt17,
        this.lgt18,
        this.lgt19,
        this.lgt20,
        this.lgt21,
        this.lgt22,
        this.lgt23,
        this.lgt24,
        this.lgt25,
        this.lgt26,
        this.lgt27,
        this.lgt28,
        this.lgt29,
        this.lgt30,
        this.lgt31,
        this.lgt32,
        this.lgt33,
        this.lgt34,
        this.lgt35,
        this.lgt36,
        this.lgt37,
        this.lgt38,
        this.lgt39,
        this.lgt40,
        this.lgt41,
        this.lgt42,
        this.lgt43,
        this.lgt44,
        this.lgt45,
        this.lgt46,
        this.lgt47,
        this.lgt48,
        this.lgt49,
        this.lgt50,
        this.lgt51,
        this.lgt52,
        this.lgt53,
        this.lgt54,
        this.lgt55,
        this.lgt56,
        this.lgt57,
        this.lgt58,
        this.lgt59,
        this.lgt60,
        this.lgt61,
        this.lgt62,
        this.lgt63,
        this.lgt64,
        this.lgt65,
        this.lgt66,
        this.lgt67,
        this.lgt68,
        this.totalLightNum,
        this.lightOnRate});

  LightPoint.fromJson(Map<String, dynamic> json) {
    lgt01 = json['lgt01'];
    lgt02 = json['lgt02'];
    lgt03 = json['lgt03'];
    lgt04 = json['lgt04'];
    lgt05 = json['lgt05'];
    lgt06 = json['lgt06'];
    lgt07 = json['lgt07'];
    lgt08 = json['lgt08'];
    lgt09 = json['lgt09'];
    lgt10 = json['lgt10'];
    lgt11 = json['lgt11'];
    lgt12 = json['lgt12'];
    lgt13 = json['lgt13'];
    lgt14 = json['lgt14'];
    lgt15 = json['lgt15'];
    lgt16 = json['lgt16'];
    lgt17 = json['lgt17'];
    lgt18 = json['lgt18'];
    lgt19 = json['lgt19'];
    lgt20 = json['lgt20'];
    lgt21 = json['lgt21'];
    lgt22 = json['lgt22'];
    lgt23 = json['lgt23'];
    lgt24 = json['lgt24'];
    lgt25 = json['lgt25'];
    lgt26 = json['lgt26'];
    lgt27 = json['lgt27'];
    lgt28 = json['lgt28'];
    lgt29 = json['lgt29'];
    lgt30 = json['lgt30'];
    lgt31 = json['lgt31'];
    lgt32 = json['lgt32'];
    lgt33 = json['lgt33'];
    lgt34 = json['lgt34'];
    lgt35 = json['lgt35'];
    lgt36 = json['lgt36'];
    lgt37 = json['lgt37'];
    lgt38 = json['lgt38'];
    lgt39 = json['lgt39'];
    lgt40 = json['lgt40'];
    lgt41 = json['lgt41'];
    lgt42 = json['lgt42'];
    lgt43 = json['lgt43'];
    lgt44 = json['lgt44'];
    lgt45 = json['lgt45'];
    lgt46 = json['lgt46'];
    lgt47 = json['lgt47'];
    lgt48 = json['lgt48'];
    lgt49 = json['lgt49'];
    lgt50 = json['lgt50'];
    lgt51 = json['lgt51'];
    lgt52 = json['lgt52'];
    lgt53 = json['lgt53'];
    lgt54 = json['lgt54'];
    lgt55 = json['lgt55'];
    lgt56 = json['lgt56'];
    lgt57 = json['lgt57'];
    lgt58 = json['lgt58'];
    lgt59 = json['lgt59'];
    lgt60 = json['lgt60'];
    lgt61 = json['lgt61'];
    lgt62 = json['lgt62'];
    lgt63 = json['lgt63'];
    lgt64 = json['lgt64'];
    lgt65 = json['lgt65'];
    lgt66 = json['lgt66'];
    lgt67 = json['lgt67'];
    lgt68 = json['lgt68'];
    totalLightNum = json['totalLightNum'];
    lightOnRate = json['lightOnRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lgt01'] = this.lgt01;
    data['lgt02'] = this.lgt02;
    data['lgt03'] = this.lgt03;
    data['lgt04'] = this.lgt04;
    data['lgt05'] = this.lgt05;
    data['lgt06'] = this.lgt06;
    data['lgt07'] = this.lgt07;
    data['lgt08'] = this.lgt08;
    data['lgt09'] = this.lgt09;
    data['lgt10'] = this.lgt10;
    data['lgt11'] = this.lgt11;
    data['lgt12'] = this.lgt12;
    data['lgt13'] = this.lgt13;
    data['lgt14'] = this.lgt14;
    data['lgt15'] = this.lgt15;
    data['lgt16'] = this.lgt16;
    data['lgt17'] = this.lgt17;
    data['lgt18'] = this.lgt18;
    data['lgt19'] = this.lgt19;
    data['lgt20'] = this.lgt20;
    data['lgt21'] = this.lgt21;
    data['lgt22'] = this.lgt22;
    data['lgt23'] = this.lgt23;
    data['lgt24'] = this.lgt24;
    data['lgt25'] = this.lgt25;
    data['lgt26'] = this.lgt26;
    data['lgt27'] = this.lgt27;
    data['lgt28'] = this.lgt28;
    data['lgt29'] = this.lgt29;
    data['lgt30'] = this.lgt30;
    data['lgt31'] = this.lgt31;
    data['lgt32'] = this.lgt32;
    data['lgt33'] = this.lgt33;
    data['lgt34'] = this.lgt34;
    data['lgt35'] = this.lgt35;
    data['lgt36'] = this.lgt36;
    data['lgt37'] = this.lgt37;
    data['lgt38'] = this.lgt38;
    data['lgt39'] = this.lgt39;
    data['lgt40'] = this.lgt40;
    data['lgt41'] = this.lgt41;
    data['lgt42'] = this.lgt42;
    data['lgt43'] = this.lgt43;
    data['lgt44'] = this.lgt44;
    data['lgt45'] = this.lgt45;
    data['lgt46'] = this.lgt46;
    data['lgt47'] = this.lgt47;
    data['lgt48'] = this.lgt48;
    data['lgt49'] = this.lgt49;
    data['lgt50'] = this.lgt50;
    data['lgt51'] = this.lgt51;
    data['lgt52'] = this.lgt52;
    data['lgt53'] = this.lgt53;
    data['lgt54'] = this.lgt54;
    data['lgt55'] = this.lgt55;
    data['lgt56'] = this.lgt56;
    data['lgt57'] = this.lgt57;
    data['lgt58'] = this.lgt58;
    data['lgt59'] = this.lgt59;
    data['lgt60'] = this.lgt60;
    data['lgt61'] = this.lgt61;
    data['lgt62'] = this.lgt62;
    data['lgt63'] = this.lgt63;
    data['lgt64'] = this.lgt64;
    data['lgt65'] = this.lgt65;
    data['lgt66'] = this.lgt66;
    data['lgt67'] = this.lgt67;
    data['lgt68'] = this.lgt68;
    data['totalLightNum'] = this.totalLightNum;
    data['lightOnRate'] = this.lightOnRate;
    return data;
  }
}

class PersonPoint {
  String pt01;
  String pt02;
  String pt03;
  String pt04;
  String pt05;
  String pt06;
  String pt07;
  String pt08;
  String pt09;
  String pt10;
  String pt11;
  String pt12;
  String pt13;
  String pt14;
  String pt15;
  String pt16;
  String pt17;
  String pt18;
  String pt19;
  String pt20;
  String pt21;
  String totalPersonSiteNum;
  String personSiteOnRate;
  String perNumInArea1;
  String perNumInArea2;

  PersonPoint(
      {this.pt01,
        this.pt02,
        this.pt03,
        this.pt04,
        this.pt05,
        this.pt06,
        this.pt07,
        this.pt08,
        this.pt09,
        this.pt10,
        this.pt11,
        this.pt12,
        this.pt13,
        this.pt14,
        this.pt15,
        this.pt16,
        this.pt17,
        this.pt18,
        this.pt19,
        this.pt20,
        this.pt21,
        this.totalPersonSiteNum,
        this.personSiteOnRate,
        this.perNumInArea1,
        this.perNumInArea2});

  PersonPoint.fromJson(Map<String, dynamic> json) {
    pt01 = json['pt01'];
    pt02 = json['pt02'];
    pt03 = json['pt03'];
    pt04 = json['pt04'];
    pt05 = json['pt05'];
    pt06 = json['pt06'];
    pt07 = json['pt07'];
    pt08 = json['pt08'];
    pt09 = json['pt09'];
    pt10 = json['pt10'];
    pt11 = json['pt11'];
    pt12 = json['pt12'];
    pt13 = json['pt13'];
    pt14 = json['pt14'];
    pt15 = json['pt15'];
    pt16 = json['pt16'];
    pt17 = json['pt17'];
    pt18 = json['pt18'];
    pt19 = json['pt19'];
    pt20 = json['pt20'];
    pt21 = json['pt21'];
    totalPersonSiteNum = json['totalPersonSiteNum'];
    personSiteOnRate = json['personSiteOnRate'];
    perNumInArea1 = json['perNumInArea1'];
    perNumInArea2 = json['perNumInArea2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pt01'] = this.pt01;
    data['pt02'] = this.pt02;
    data['pt03'] = this.pt03;
    data['pt04'] = this.pt04;
    data['pt05'] = this.pt05;
    data['pt06'] = this.pt06;
    data['pt07'] = this.pt07;
    data['pt08'] = this.pt08;
    data['pt09'] = this.pt09;
    data['pt10'] = this.pt10;
    data['pt11'] = this.pt11;
    data['pt12'] = this.pt12;
    data['pt13'] = this.pt13;
    data['pt14'] = this.pt14;
    data['pt15'] = this.pt15;
    data['pt16'] = this.pt16;
    data['pt17'] = this.pt17;
    data['pt18'] = this.pt18;
    data['pt19'] = this.pt19;
    data['pt20'] = this.pt20;
    data['pt21'] = this.pt21;
    data['totalPersonSiteNum'] = this.totalPersonSiteNum;
    data['personSiteOnRate'] = this.personSiteOnRate;
    data['perNumInArea1'] = this.perNumInArea1;
    data['perNumInArea2'] = this.perNumInArea2;
    return data;
  }
}

class OtherInfo {
  String chDate;
  String enDate;

  OtherInfo({this.chDate, this.enDate});

  OtherInfo.fromJson(Map<String, dynamic> json) {
    chDate = json['chDate'];
    enDate = json['enDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chDate'] = this.chDate;
    data['enDate'] = this.enDate;
    return data;
  }
}
