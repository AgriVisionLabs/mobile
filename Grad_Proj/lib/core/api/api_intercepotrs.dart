// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiIntercepotrs extends Interceptor {
  final Dio dio;
  bool? isLoggedIn;
  SignInModel? user;
  ApiIntercepotrs({
    required this.dio,
  });
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final currentToken =
        CacheHelper().getData(key: ApiKey.token); // your token fetch logic
    options.headers['Accept-Language'] = 'en';
    if (currentToken != null) {
      options.headers['Authorization'] = 'Bearer $currentToken';
    }
    super.onRequest(options, handler);
  }

  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      isLoggedIn = prefs.getBool('isLoggedIn');
      if (isLoggedIn != false) {
        //   final refreshToken = CacheHelper().getData(key: ApiKey.refreshToken);
        // final refreshExpiry =
        //     CacheHelper().getData(key: ApiKey.refreshTokenExpiration);
        if (await _refreshToken()) {
          return handler.resolve(await _retry(err.requestOptions));
        }
      }
    }
    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> _refreshToken() async {
    print('==========Success==========');
    final refreshEpx =
        CacheHelper().getData(key: ApiKey.refreshTokenExpiration);
        DateTime parsedDate = DateTime.parse(refreshEpx);
    if (DateTime.now().isBefore(parsedDate)) {
      final response = await dio.post(EndPoints.refreshToken, data: {
        ApiKey.token: CacheHelper().getData(key: ApiKey.token),
        ApiKey.refreshToken: CacheHelper().getData(key: ApiKey.refreshToken)
      });
      user = SignInModel.fromJson(response.data);
      CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      CacheHelper()
          .saveData(key: ApiKey.refreshToken, value: user!.refreshToken);
      final accessExpiry =
          DateTime.now().add(Duration(minutes: user!.expiresIn));
      CacheHelper().saveData(key: ApiKey.expiresIn, value: accessExpiry);
      CacheHelper().saveData(
          key: ApiKey.refreshTokenExpiration,
          value: user!.refreshTokenExpiration);
      print(response);
      return true;
    } else {
      return false;
    }
  }
}
