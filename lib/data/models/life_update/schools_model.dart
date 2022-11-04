/// id : 5232
/// country : "NG"
/// name : "Abia State Polytechnic"
/// url : "http://www.abiapoly.edu.ng/"

class SchoolsModel {
  SchoolsModel({
    this.id,
    this.country,
    this.name,
    this.url,});

  SchoolsModel.fromJson(dynamic json) {
    id = json['id'];
    country = json['country'];
    name = json['name'];
    url = json['url'];
  }
  int? id;
  String? country;
  String? name;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country'] = country;
    map['name'] = name;
    map['url'] = url;
    return map;
  }

  String toLowerCase() {
    return name!.toLowerCase();
  }

}