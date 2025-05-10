class WheelWinsModel {
  String? status;
  List<WinData>? data;

  WheelWinsModel({this.status, this.data});

  WheelWinsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WinData>[];
      json['data'].forEach((v) {
        data!.add(new WinData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WinData {
  int? id;
  int? userId;
  int? wheelItemId;
  bool? isClaimed;
  String? claimedAt;
  String? note;
  String? createdAt;
  String? updatedAt;
  WheelData? wheelItem;

  WinData(
      {this.id,
        this.userId,
        this.wheelItemId,
        this.isClaimed,
        this.claimedAt,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.wheelItem});

  WinData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    wheelItemId = json['wheel_item_id'];
    isClaimed = json['is_claimed'];
    claimedAt = json['claimed_at'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wheelItem = json['wheel_item'] != null
        ? new WheelData.fromJson(json['wheel_item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['wheel_item_id'] = this.wheelItemId;
    data['is_claimed'] = this.isClaimed;
    data['claimed_at'] = this.claimedAt;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.wheelItem != null) {
      data['wheel_item'] = this.wheelItem!.toJson();
    }
    return data;
  }
}

class WheelData {
  int? id;
  String? label;
  String? color;
  String? probability;
  int? position;

  WheelData({this.id, this.label, this.color, this.probability, this.position});

  WheelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    color = json['color'];
    probability = json['probability'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['color'] = this.color;
    data['probability'] = this.probability;
    data['position'] = this.position;
    return data;
  }
}
