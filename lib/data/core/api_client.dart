import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/data/models/error_response_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/countries_response_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/schools_response_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/states_response_model.dart';
import 'package:trybe_one_mobile/data/models/user/interests_model_response.dart';
import 'package:trybe_one_mobile/data/models/user/user_response_model.dart';

class APIClient {

  Dio dio = Dio();

  String token = '';
  var box = Hive.box(DBConstants.userBoxName);

  // dynamic postAuthData({required String pathSegment, dynamic body}) async {
  //   try {
  //     Response response = await dio.post(
  //         '${APIConstants.DEV_BASE_URL}/$pathSegment',
  //         data: body,
  //     );
  //     print('url in post $pathSegment endpoint is ${APIConstants.DEV_BASE_URL}/$pathSegment,');
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       print(response);
  //       return response;
  //     } else {
  //       throw Exception(response.data.toString());
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  dynamic postAuthData({required String pathSegment, required dynamic body}) async {
    try{
      Response response = await dio.post(
        '${APIConstants.DEV_BASE_URL}/$pathSegment',
        data: body
      );
      print('url in post auth-data end point is:\n${APIConstants.DEV_BASE_URL}/$pathSegment');
      print(response);
      if(response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return response.data.toString();
      }

    } on DioError catch(e) {
      final dioError = e;
      switch (dioError.type) {
        case DioErrorType.cancel:
          return 'Request was cancelled';
        case DioErrorType.response:
          // return ErrorResponseModel.fromJson(dioError.response!.data).message;
          return dioError.response!.data;
        case DioErrorType.connectTimeout:
          return 'Connection timed out';
        case DioErrorType.other:
          return 'Could not ascertain the cause of this error';
      }
    }
  }

  dynamic verifyPasswordResetCode({required String pathSegment, dynamic body}) async {
    try {
      Response response = await dio.post(
          '${APIConstants.DEV_BASE_URL}/$pathSegment',
          data: body
      );
      print('url in post verify pwd reset code endpoint is ${APIConstants.DEV_BASE_URL}/$pathSegment,');
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('response is:\n $response');
        // return response.data;
        return response;
      } else {
        // print('err response:\n ${response.data.toString()}');
        return response.data.toString();
        // throw Exception(response.data.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        return (e.response!.data);
        // throw Exception(e);
      } else {
        // print('No Dio Errors');
      }
    }
  }

  Future getCountriesData({required String pathSegment}) async {
    try {
      Response response = await dio.get(
          '${APIConstants.DEV_BASE_URL}/$pathSegment',
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return CountriesResponseModel.fromJson(response.data).data;
      } else {
        // print(response.statusCode);
        // print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        throw Exception(e);
      }
    }
  }

  Future getSchoolsByCountry({required String pathSegment, required String countryISO}) async {
    try {
      Response response = await dio.get(
        '${APIConstants.DEV_BASE_URL}/$pathSegment',
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return SchoolsResponseModel.fromJson(response.data).data;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        throw Exception(e);
      }
    }
  }

  Future getStates({required String pathSegment}) async {
    try {
      Response response = await dio.get(
          '${APIConstants.DEV_BASE_URL}/$pathSegment',
          options: Options(
            headers: {
              'Accept': '*/*',
              'Authorization': token,
            },
          )
      );

      print('url in get states:\n ${APIConstants.DEV_BASE_URL}/$pathSegment}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        return StatesResponseModel.fromJson(response.data).data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e);
      } else {
        print('No Dio Errors');
      }
    }
  }

  dynamic submitLifeUpdateType({required String pathSegment, required dynamic body}) async {

    token = box.get(DBConstants.JWTToken);
    print('token in life update request is $token');

    try {
      Response response = await dio.post(
        '${APIConstants.DEV_BASE_URL}/$pathSegment',
        data: body,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': token,
            'Content-Type': 'multipart/form-data',
          },
        )
      );

      print('url in post life update:\n ${APIConstants.DEV_BASE_URL}/$pathSegment}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('response:\n$response');
        // return response.data;
        return response;
      } else {
        print(response.statusCode);
        return response.data.toString();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        // throw Exception(e);
        return (e.response!.data);
      } else {
        print('No Dio Errors');
      }
    }
  }

  Future submitBioData({required String pathSegment, required dynamic body}) async {

    token = box.get(DBConstants.JWTToken);
    print('token in submit bio-data request is $token');

    try {
      Response response = await dio.post(
        '${APIConstants.DEV_BASE_URL}/$pathSegment',
        data: body,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': token,
          },
        )
      );

      print('url in submit bio data:\n ${APIConstants.DEV_BASE_URL}/$pathSegment}');

      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        // return response.data;
        return response;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        return response.data.toString();
        // throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        return (e.response!.data);
      } else {
        print('No Dio Errors');
      }
    }
  }

  dynamic uploadImageDocument({required String pathSegment, required dynamic body}) async {
    token = box.get(DBConstants.JWTToken);
    print('token in upload image request is $token');

    try {
      Response response = await dio.post(
          '${APIConstants.DEV_BASE_URL}/$pathSegment',
          data: body,
          options: Options(
            headers: {
              'Accept': '*/*',
              'Authorization': token,
              'Content-Type': 'multipart/form-data',
            },
          )
      );

      print('url in upload image:\n ${APIConstants.DEV_BASE_URL}/$pathSegment}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('response:\n$response');
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e);
      } else {
        print('No Dio Errors');
      }
    }
  }

  dynamic updateAddress({required String pathSegment, required dynamic body}) async {
    token = box.get(DBConstants.JWTToken);
    print('token in upload image request is $token');

    try {
      Response response = await dio.post(
          '${APIConstants.DEV_BASE_URL}/$pathSegment',
          data: body,
          options: Options(
            headers: {
              'Accept': '*/*',
              'Authorization': token,
            },
          )
      );

      print('url in upload profile image:\n ${APIConstants.DEV_BASE_URL}/$pathSegment}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('response:\n$response');
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e);
      }
    }
  }

  Future getUserInterests ({required String pathSegment}) async {
    // token = box.get(DBConstants.JWTToken);
    // print('token in life update request is $token');

    try {
      Response response = await dio.get(
          '${APIConstants.DEV_BASE_URL}/$pathSegment',
          options: Options(
            headers: {
              'Accept': '*/*',
              // 'Authorization': token,
              'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzcsImVtYWlsIjoidXNlcm9uZUBnbWFpbC5jb20iLCJpYXQiOjE2NDkzNDAyNzUsImV4cCI6MTY0OTQyNjY3NX0.U8seVYpprdjavIT1uqaMVItJbNePgqNUoLVACQHA3LI',
            },
          )
      );

      print('url in get user interests:\n ${APIConstants.DEV_BASE_URL}/$pathSegment}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('response:\n$response');
        return InterestsModelResponse.fromJson(response.data).data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e);
      } else {
        print('No Dio Errors');
      }
    }

  }

  Future updateUserInterests ({required String pathSegment, required dynamic body}) async {
    token = box.get(DBConstants.JWTToken);
    print('token in life update request is $token');

    try {
      Response response = await dio.post(
          '${APIConstants.DEV_BASE_URL}/$pathSegment',
          data: body,
          options: Options(
            headers: {
              'Accept': '*/*',
              'Authorization': token,
            },
          )
      );

      print('url in update user interests:\n ${APIConstants.DEV_BASE_URL}/$pathSegment}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('response:\n$response');
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e);
      } else {
        print('No Dio Errors');
      }
    }

  }

}