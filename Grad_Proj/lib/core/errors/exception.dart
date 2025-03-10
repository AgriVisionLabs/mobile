import 'package:dio/dio.dart';
import 'package:grd_proj/core/errors/error_model.dart';

///Api Expection
class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handelDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:

          ///empty email or password
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
          
      
        case 401:

          ///unauthorized
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 403:

          ///forbidden
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 404:

          ///not found
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 405:

          ///forbidden operation
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 409: 
          //cofficient
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 422: 
           //  Unprocessable Entity
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 504: 
          // Server exception
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
