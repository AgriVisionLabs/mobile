import 'package:grd_proj/core/api/end_points.dart';

class ErrorModel {
  final int status;
  final String message;
  final dynamic error;

  ErrorModel({required this.status, required this.message, required this.error});
  factory ErrorModel.fromJson(Map<String,dynamic> jsonData){
    return ErrorModel(
      status: jsonData[ApiKey.status], 
      message: jsonData[ApiKey.errorMessage],
      error: jsonData['errors'],
      );
  }
} 


