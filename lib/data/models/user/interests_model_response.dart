import 'package:trybe_one_mobile/data/models/user/interests_model.dart';

/// status : "success"
/// data : [{"id":1,"name":"gadgets"},{"id":2,"name":"fashion"},{"id":3,"name":"anime"},{"id":4,"name":"history"},{"id":5,"name":"photography"},{"id":6,"name":"puzzles"},{"id":7,"name":"vehicles"},{"id":8,"name":"soccer"},{"id":9,"name":"biology"},{"id":10,"name":"NFT"},{"id":11,"name":"men fashion"},{"id":12,"name":"UI/UX"},{"id":13,"name":"minimalism"}]
/// message : ""

class InterestsModelResponse {
  InterestsModelResponse({
      this.status, 
      this.data, 
      this.message,});

  InterestsModelResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InterestsModel.fromJson(v));
      });
    }
    message = json['message'];
  }
  String? status;
  List<InterestsModel>? data;
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