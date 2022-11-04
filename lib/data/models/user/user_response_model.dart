/// status : "success"
/// data : {"user":{"id":37,"first_name":"User","last_name":"One","onboarding_step":5,"birthdate":"6 Apr 2022","gender":"Male","profile_image":"https://trybe-one-dev.s3.af-south-1.amazonaws.com/1649143652490app_mock_up_quote.PNG","address":"Afolabi Ayorinde Street, UniLag","address_school":null,"debit_card_delivery":"To my school address (Charges will apply)","is_address_verified":false,"is_complete_onboarding":false,"isVerified":true,"user_type":"CORPER","schoolLocation":null,"schoolName":null,"occupation":null,"organisation_name":null,"referalcode":"UO7490","refered_by":0,"corpServiceLocation":"Abia State","hasBvn":true,"permanentAddress":null,"currentAddress":null,"studentIdentity":null,"callupLetter":"https://trybe-one-dev.s3.af-south-1.amazonaws.com/1649109526429be6fb942-1525-4bc4-be5b-7461b4d3829f3483563538768439117.jpg","work_id":null,"utilityBill":null,"dob":null,"phone":"08123456789","email":"userone@gmail.com"},"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzcsImVtYWlsIjoidXNlcm9uZUBnbWFpbC5jb20iLCJpYXQiOjE2NDkzODEwNTksImV4cCI6MTY0OTQ2NzQ1OX0.bASV3tPyWurr737Y289BbZVxsOHc4qnv2on3cul6fxQ"}
/// message : "Login successful"

class UserResponseModel {
  UserResponseModel({
      this.status, 
      this.data, 
      this.message,});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  String? status;
  Data? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }

}

/// user : {"id":37,"first_name":"User","last_name":"One","onboarding_step":5,"birthdate":"6 Apr 2022","gender":"Male","profile_image":"https://trybe-one-dev.s3.af-south-1.amazonaws.com/1649143652490app_mock_up_quote.PNG","address":"Afolabi Ayorinde Street, UniLag","address_school":null,"debit_card_delivery":"To my school address (Charges will apply)","is_address_verified":false,"is_complete_onboarding":false,"isVerified":true,"user_type":"CORPER","schoolLocation":null,"schoolName":null,"occupation":null,"organisation_name":null,"referalcode":"UO7490","refered_by":0,"corpServiceLocation":"Abia State","hasBvn":true,"permanentAddress":null,"currentAddress":null,"studentIdentity":null,"callupLetter":"https://trybe-one-dev.s3.af-south-1.amazonaws.com/1649109526429be6fb942-1525-4bc4-be5b-7461b4d3829f3483563538768439117.jpg","work_id":null,"utilityBill":null,"dob":null,"phone":"08123456789","email":"userone@gmail.com"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzcsImVtYWlsIjoidXNlcm9uZUBnbWFpbC5jb20iLCJpYXQiOjE2NDkzODEwNTksImV4cCI6MTY0OTQ2NzQ1OX0.bASV3tPyWurr737Y289BbZVxsOHc4qnv2on3cul6fxQ"

class Data {
  Data({
      this.user, 
      this.token,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
  User? user;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

}

/// id : 37
/// first_name : "User"
/// last_name : "One"
/// onboarding_step : 5
/// birthdate : "6 Apr 2022"
/// gender : "Male"
/// profile_image : "https://trybe-one-dev.s3.af-south-1.amazonaws.com/1649143652490app_mock_up_quote.PNG"
/// address : "Afolabi Ayorinde Street, UniLag"
/// address_school : null
/// debit_card_delivery : "To my school address (Charges will apply)"
/// is_address_verified : false
/// is_complete_onboarding : false
/// isVerified : true
/// user_type : "CORPER"
/// schoolLocation : null
/// schoolName : null
/// occupation : null
/// organisation_name : null
/// referalcode : "UO7490"
/// refered_by : 0
/// corpServiceLocation : "Abia State"
/// hasBvn : true
/// permanentAddress : null
/// currentAddress : null
/// studentIdentity : null
/// callupLetter : "https://trybe-one-dev.s3.af-south-1.amazonaws.com/1649109526429be6fb942-1525-4bc4-be5b-7461b4d3829f3483563538768439117.jpg"
/// work_id : null
/// utilityBill : null
/// dob : null
/// phone : "08123456789"
/// email : "userone@gmail.com"

class User {
  User({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.onboardingStep, 
      this.birthdate, 
      this.gender, 
      this.profileImage, 
      this.address, 
      this.addressSchool, 
      this.debitCardDelivery, 
      this.isAddressVerified, 
      this.isCompleteOnboarding, 
      this.isVerified, 
      this.userType, 
      this.schoolLocation, 
      this.schoolName, 
      this.occupation, 
      this.organisationName, 
      this.referalcode, 
      this.referedBy, 
      this.corpServiceLocation, 
      this.hasBvn, 
      this.permanentAddress, 
      this.currentAddress, 
      this.studentIdentity, 
      this.callupLetter, 
      this.workId, 
      this.utilityBill, 
      this.dob, 
      this.phone, 
      this.email,});

  User.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    onboardingStep = json['onboarding_step'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    address = json['address'];
    addressSchool = json['address_school'];
    debitCardDelivery = json['debit_card_delivery'];
    isAddressVerified = json['is_address_verified'];
    isCompleteOnboarding = json['is_complete_onboarding'];
    isVerified = json['isVerified'];
    userType = json['user_type'];
    schoolLocation = json['schoolLocation'];
    schoolName = json['schoolName'];
    occupation = json['occupation'];
    organisationName = json['organisation_name'];
    referalcode = json['referalcode'];
    referedBy = json['refered_by'];
    corpServiceLocation = json['corpServiceLocation'];
    hasBvn = json['hasBvn'];
    permanentAddress = json['permanentAddress'];
    currentAddress = json['currentAddress'];
    studentIdentity = json['studentIdentity'];
    callupLetter = json['callupLetter'];
    workId = json['work_id'];
    utilityBill = json['utilityBill'];
    dob = json['dob'];
    phone = json['phone'];
    email = json['email'];
  }
  int? id;
  String? firstName;
  String? lastName;
  int? onboardingStep;
  String? birthdate;
  String? gender;
  String? profileImage;
  String? address;
  dynamic addressSchool;
  String? debitCardDelivery;
  bool? isAddressVerified;
  bool? isCompleteOnboarding;
  bool? isVerified;
  String? userType;
  dynamic schoolLocation;
  dynamic schoolName;
  dynamic occupation;
  dynamic organisationName;
  String? referalcode;
  int? referedBy;
  String? corpServiceLocation;
  bool? hasBvn;
  dynamic permanentAddress;
  dynamic currentAddress;
  dynamic studentIdentity;
  String? callupLetter;
  dynamic workId;
  dynamic utilityBill;
  dynamic dob;
  String? phone;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['onboarding_step'] = onboardingStep;
    map['birthdate'] = birthdate;
    map['gender'] = gender;
    map['profile_image'] = profileImage;
    map['address'] = address;
    map['address_school'] = addressSchool;
    map['debit_card_delivery'] = debitCardDelivery;
    map['is_address_verified'] = isAddressVerified;
    map['is_complete_onboarding'] = isCompleteOnboarding;
    map['isVerified'] = isVerified;
    map['user_type'] = userType;
    map['schoolLocation'] = schoolLocation;
    map['schoolName'] = schoolName;
    map['occupation'] = occupation;
    map['organisation_name'] = organisationName;
    map['referalcode'] = referalcode;
    map['refered_by'] = referedBy;
    map['corpServiceLocation'] = corpServiceLocation;
    map['hasBvn'] = hasBvn;
    map['permanentAddress'] = permanentAddress;
    map['currentAddress'] = currentAddress;
    map['studentIdentity'] = studentIdentity;
    map['callupLetter'] = callupLetter;
    map['work_id'] = workId;
    map['utilityBill'] = utilityBill;
    map['dob'] = dob;
    map['phone'] = phone;
    map['email'] = email;
    return map;
  }

}