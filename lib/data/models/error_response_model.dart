/// status : "error"
/// message : "Incorrect Email or Password"

class ErrorResponseModel {

  String? status;
  String? message;

  ErrorResponseModel({
      required this.status,
      required this.message});

  ErrorResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}