// import 'package:hive/hive.dart';
//
// @HiveType(typeId: 0)
// class UserModel {
//
//   @HiveField(0)
//   int id;
//
//   @HiveField(1)
//   dynamic firstName;
//
//   @HiveField(2)
//   dynamic lastName;
//
//   @HiveField(3)
//   String email;
//
//   @HiveField(4)
//   int onboardingStep;
//
//   @HiveField(5)
//   dynamic profileImage;
//
//   @HiveField(6)
//   dynamic address;
//
//   @HiveField(7)
//   dynamic addressSchool;
//
//   @HiveField(8)
//   dynamic debitCardDelivery;
//
//   @HiveField(9)
//   bool isAddressVerified;
//
//   @HiveField(10)
//   bool isCompleteOnboarding;
//
//   @HiveField(11)
//   bool isVerified;
//
//   // String verificationCode;
//
//   @HiveField(12)
//   dynamic userType;
//
//   @HiveField(13)
//   dynamic schoolLocation;
//
//   @HiveField(13)
//   dynamic schoolName;
//
//   @HiveField(14)
//   dynamic referalcode;
//
//   @HiveField(15)
//   dynamic corpServiceLocation;
//
//   @HiveField(16)
//   dynamic hasBvn;
//
//   @HiveField(17)
//   dynamic permanentAddress;
//
//   @HiveField(18)
//   dynamic currentAddress;
//
//   @HiveField(19)
//   dynamic studentIdentity;
//
//   @HiveField(20)
//   dynamic callupLetter;
//
//   @HiveField(21)
//   dynamic workId;
//
//   @HiveField(22)
//   dynamic utilityBill;
//
//   @HiveField(23)
//   dynamic dob;
//
//   @HiveField(24)
//   dynamic phone;
//
//   UserModel({
//     required this.id,
//     this.firstName,
//     this.lastName,
//     required this.email,
//     required this.onboardingStep,
//     this.profileImage,
//     this.address,
//     this.addressSchool,
//     this.debitCardDelivery,
//     required this.isAddressVerified,
//     required this.isCompleteOnboarding,
//     required this.isVerified,
//     // this.verificationCode,
//     this.userType,
//     this.schoolLocation,
//     this.schoolName,
//     this.referalcode,
//     this.corpServiceLocation,
//     this.hasBvn,
//     this.permanentAddress,
//     this.currentAddress,
//     this.studentIdentity,
//     this.callupLetter,
//     this.workId,
//     this.utilityBill,
//     this.dob,
//     this.phone,
//     // this.signedUpVia,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//     id: json["id"],
//     firstName: json["first_name"] ?? 'John',
//     lastName: json["last_name"] ?? 'Doe',
//     email: json["email"] ?? 'dummy@email.com',
//     onboardingStep: json["onboarding_step"] == null ? 0 : json['onboarding_step'],
//     profileImage: json["profile_image"] == null ? '' : json['profile_image'],
//     address: json["address"] ?? 'no address yet',
//     addressSchool: json["address_school"] ?? 'no school address yet',
//     debitCardDelivery: json["debit_card_delivery"] ?? 'debit card delivery not set',
//     isAddressVerified: json["is_address_verified"] ?? false,
//     isCompleteOnboarding: json["is_complete_onboarding"] ?? false,
//     isVerified: json["isVerified"] ?? false,
//     // verificationCode: json["verification_code"],
//     userType: json["user_type"] ?? 'no user type set',
//     schoolLocation: json["schoolLocation"] ?? 'no school address yet',
//     schoolName: json["schoolName"] ?? 'no school name provided',
//     referalcode: json["referalcode"] ?? 'no referral code yet',
//     corpServiceLocation: json["corpServiceLocation"] ?? 'no corp service location yet',
//     hasBvn: json["hasBvn"] == null ? false : json['hasBvn'],
//     permanentAddress: json["permanentAddress"] ?? 'no permanent address yet',
//     currentAddress: json["currentAddress"] ?? 'no current address yet',
//     studentIdentity: json["studentIdentity"] == null ? '' : json['studentIdentity'],
//     callupLetter: json["callupLetter"] == null ? '' : json['callupLetter'],
//     workId: json["work_id"] == null ? '' : json['work_id'],
//     utilityBill: json["utilityBill"] == null ? '' : json['utilityBill'],
//     dob: json["dob"] ?? 'no dob yet',
//     phone: json["phone"] ?? 'no phone number',
//     // signedUpVia: json["signedUp_via"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "first_name": firstName,
//     "last_name": lastName,
//     "email": email,
//     "onboarding_step": onboardingStep,
//     "profile_image": profileImage,
//     "address": address,
//     "address_school": addressSchool,
//     "debit_card_delivery": debitCardDelivery,
//     "is_address_verified": isAddressVerified,
//     "is_complete_onboarding": isCompleteOnboarding,
//     "isVerified": isVerified,
//     // "verification_code": verificationCode,
//     "user_type": userType,
//     "schoolLocation": schoolLocation,
//     "schoolName": schoolName,
//     "referalcode": referalcode,
//     "corpServiceLocation": corpServiceLocation,
//     "hasBvn": hasBvn,
//     "permanentAddress": permanentAddress,
//     "currentAddress": currentAddress,
//     "studentIdentity": studentIdentity,
//     "callupLetter": callupLetter,
//     "work_id": workId,
//     "utilityBill": utilityBill,
//     "dob": dob,
//     "phone": phone,
//     // "signedUp_via": signedUpVia,
//   };
// }

import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.onboardingStep,
    required this.birthdate,
    required this.gender,
    required this.profileImage,
    required this.address,
    required this.addressSchool,
    required this.debitCardDelivery,
    required this.isAddressVerified,
    required this.isCompleteOnboarding,
    required this.isVerified,
    required this.userType,
    required this.schoolLocation,
    required this.schoolName,
    required this.occupation,
    required this.organisationName,
    required this.referalcode,
    required this.referedBy,
    required this.corpServiceLocation,
    required this.hasBvn,
    required this.permanentAddress,
    required this.currentAddress,
    required this.studentIdentity,
    required this.callupLetter,
    required this.workId,
    required this.utilityBill,
    required this.dob,
    required this.phone,
    required this.email,
  });

  final int id;
  final String firstName;
  final String lastName;
  final int onboardingStep;
  final String birthdate;
  final String gender;
  final String profileImage;
  final String address;
  final Object? addressSchool;
  final String debitCardDelivery;
  final bool isAddressVerified;
  final bool isCompleteOnboarding;
  final bool isVerified;
  final String userType;
  final Object? schoolLocation;
  final Object? schoolName;
  final Object? occupation;
  final Object? organisationName;
  final String referalcode;
  final int referedBy;
  final String corpServiceLocation;
  final bool hasBvn;
  final Object? permanentAddress;
  final Object? currentAddress;
  final Object? studentIdentity;
  final String callupLetter;
  final Object? workId;
  final Object? utilityBill;
  final Object? dob;
  final String phone;
  final String email;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    onboardingStep: json["onboarding_step"],
    birthdate: json["birthdate"],
    gender: json["gender"],
    profileImage: json["profile_image"],
    address: json["address"],
    addressSchool: json["address_school"],
    debitCardDelivery: json["debit_card_delivery"],
    isAddressVerified: json["is_address_verified"],
    isCompleteOnboarding: json["is_complete_onboarding"],
    isVerified: json["isVerified"],
    userType: json["user_type"],
    schoolLocation: json["schoolLocation"],
    schoolName: json["schoolName"],
    occupation: json["occupation"],
    organisationName: json["organisation_name"],
    referalcode: json["referalcode"],
    referedBy: json["refered_by"],
    corpServiceLocation: json["corpServiceLocation"],
    hasBvn: json["hasBvn"],
    permanentAddress: json["permanentAddress"],
    currentAddress: json["currentAddress"],
    studentIdentity: json["studentIdentity"],
    callupLetter: json["callupLetter"],
    workId: json["work_id"],
    utilityBill: json["utilityBill"],
    dob: json["dob"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "onboarding_step": onboardingStep,
    "birthdate": birthdate,
    "gender": gender,
    "profile_image": profileImage,
    "address": address,
    "address_school": addressSchool,
    "debit_card_delivery": debitCardDelivery,
    "is_address_verified": isAddressVerified,
    "is_complete_onboarding": isCompleteOnboarding,
    "isVerified": isVerified,
    "user_type": userType,
    "schoolLocation": schoolLocation,
    "schoolName": schoolName,
    "occupation": occupation,
    "organisation_name": organisationName,
    "referalcode": referalcode,
    "refered_by": referedBy,
    "corpServiceLocation": corpServiceLocation,
    "hasBvn": hasBvn,
    "permanentAddress": permanentAddress,
    "currentAddress": currentAddress,
    "studentIdentity": studentIdentity,
    "callupLetter": callupLetter,
    "work_id": workId,
    "utilityBill": utilityBill,
    "dob": dob,
    "phone": phone,
    "email": email,
  };
}