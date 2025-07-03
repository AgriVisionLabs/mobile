// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/models/sign_in_model.dart';

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
        CacheHelper.getData(key: ApiKey.token); // your token fetch logic
    options.headers['Accept-Language'] = 'en';
    if (currentToken != null) {
      options.headers['Authorization'] = 'Bearer $currentToken';
    }
    super.onRequest(options, handler);
  }
}