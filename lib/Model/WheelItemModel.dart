class WheelItemModel {
  bool? success;
  List<WheelItem>? data;

  WheelItemModel({this.success, this.data});

  WheelItemModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <WheelItem>[];
      json['data'].forEach((v) {
        data!.add(new WheelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WheelItem {
  int? id;
  String? label;
  String? color;
  String? probability;
  int? position;

  WheelItem({this.id, this.label, this.color, this.probability, this.position});

  WheelItem.fromJson(Map<String, dynamic> json) {
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
