/// id : 1
/// iso : "AF"
/// name : "AFGHANISTAN"
/// nicename : "Afghanistan"
/// iso3 : "AFG"
/// numcode : 4
/// phonecode : 93

class CountriesModel {

  int? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  int? numcode;
  int? phonecode;

  CountriesModel({
    this.id,
    this.iso,
    this.name,
    this.nicename,
    this.iso3,
    this.numcode,
    this.phonecode,});

  CountriesModel.fromJson(dynamic json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    phonecode = json['phonecode'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['iso'] = iso;
    map['name'] = name;
    map['nicename'] = nicename;
    map['iso3'] = iso3;
    map['numcode'] = numcode;
    map['phonecode'] = phonecode;
    return map;
  }

  String toLowerCase() {
    return nicename!.toLowerCase();
  }

}