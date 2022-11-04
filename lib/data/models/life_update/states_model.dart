/// id : 1
/// name : "Abuja (FCT) State"
/// alias : "abuja"

class StatesModel {
  StatesModel({
      this.id, 
      this.name, 
      this.alias,});

  StatesModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
  }
  int? id;
  String? name;
  String? alias;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['alias'] = alias;
    return map;
  }

  String toLowerCase() {
    return name!.toLowerCase();
  }

}