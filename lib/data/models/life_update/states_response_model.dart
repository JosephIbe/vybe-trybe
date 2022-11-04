import 'package:trybe_one_mobile/data/models/life_update/states_model.dart';

/// status : "success"
/// data : [{"id":1,"name":"Abuja (FCT) State","alias":"abuja"},{"id":2,"name":"Lagos State","alias":"lagos"},{"id":3,"name":"Ogun State","alias":"ogun"},{"id":4,"name":"Oyo State","alias":"oyo"},{"id":5,"name":"Rivers State","alias":"rivers"},{"id":6,"name":"Abia State","alias":"abia"},{"id":7,"name":"Adamawa State","alias":"adamawa"},{"id":8,"name":"Akwa Ibom State","alias":"akwa_ibom"},{"id":9,"name":"Anambra State","alias":"anambra"},{"id":10,"name":"Bauchi State","alias":"bauchi"},{"id":11,"name":"Bayelsa State","alias":"bayelsa"},{"id":12,"name":"Benue State","alias":"benue"},{"id":13,"name":"Borno State","alias":"borno"},{"id":14,"name":"Cross River State","alias":"cross_river"},{"id":15,"name":"Delta State","alias":"delta"},{"id":16,"name":"Ebonyi State","alias":"ebonyi"},{"id":17,"name":"Edo State","alias":"edo"},{"id":18,"name":"Ekiti State","alias":"ekiti"},{"id":19,"name":"Enugu State","alias":"enugu"},{"id":20,"name":"Gombe State","alias":"gombe"},{"id":21,"name":"Imo State","alias":"imo"},{"id":22,"name":"Jigawa State","alias":"jigawa"},{"id":23,"name":"Kaduna State","alias":"kaduna"},{"id":24,"name":"Kano State","alias":"kano"},{"id":25,"name":"Katsina State","alias":"katsina"},{"id":26,"name":"Kebbi State","alias":"kebbi"},{"id":27,"name":"Kogi State","alias":"kogi"},{"id":28,"name":"Kwara State","alias":"kwara"},{"id":29,"name":"Nasarawa State","alias":"nasarawa"},{"id":30,"name":"Niger State","alias":"niger"},{"id":31,"name":"Ondo State","alias":"ondo"},{"id":32,"name":"Osun State","alias":"osun"},{"id":33,"name":"Plateau State","alias":"plateau"},{"id":34,"name":"Sokoto State","alias":"sokoto"},{"id":35,"name":"Taraba State","alias":"taraba"},{"id":36,"name":"Yobe State","alias":"yobe"},{"id":37,"name":"Zamfara State","alias":"zamfara"}]
/// message : "States data fetched successfully"

class StatesResponseModel {
  StatesResponseModel({
      this.status, 
      this.data, 
      this.message,});

  StatesResponseModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StatesModel.fromJson(v));
      });
    }
    message = json['message'];
  }
  String? status;
  List<StatesModel>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}