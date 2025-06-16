// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/api_consumer.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/core/errors/exception.dart';
import 'package:grd_proj/bloc/user_state.dart';
import 'package:grd_proj/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up first name
  TextEditingController signUpFirstName = TextEditingController();
  //Sign up last name
  TextEditingController signUpLastName = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  //Forgrt Password Form key
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey();
  //Forgrt Password email
  TextEditingController forgetPasswordEmail = TextEditingController();
  //otp Form key
  GlobalKey<FormState> otpFormKey = GlobalKey();
  //otp
  TextEditingController forgetPasswordOtp = TextEditingController();
  //Reset Password Form key
  GlobalKey<FormState> resetFormKey = GlobalKey();
  //New Password
  TextEditingController newPassword = TextEditingController();

  TextEditingController token = TextEditingController();

  TextEditingController refreshedToken = TextEditingController();

  SignInModel? user;
  singIn() async {
    try {
      emit(SignInLoading());
      final response = await api.post(EndPoints.login, data: {
        ApiKey.email: signInEmail.text,
        ApiKey.password: signInPassword.text,
      });
      user = SignInModel.fromJson(response);
      // final decodedToken = JwtDecoder.decode(user!.token);
      CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      CacheHelper().saveData(key: ApiKey.refreshToken, value: user!.refreshToken);
      CacheHelper().saveData(key: ApiKey.expiresIn, value: user!.expiresIn);
      CacheHelper().saveData(key: ApiKey.refreshTokenExpiration, value: user!.refreshTokenExpiration);
      CacheHelper().saveData(key: ApiKey.id, value: user!.id);
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(
          errMessage: e.errorModel.message, errors: e.errorModel.error));
    }
  }

  singUp() async {
    try {
      emit(SignUpLoading());
      // ignore: unused_local_variable
      final response = await api.post(EndPoints.register, data: {
        ApiKey.userName: signUpName.text,
        ApiKey.email: signUpEmail.text,
        ApiKey.password: signUpPassword.text,
        ApiKey.phoneNumber: signUpPhoneNumber.text,
        ApiKey.firstName: signUpFirstName.text,
        ApiKey.lastName: signUpLastName.text,
      });
      emit(SignUpSuccess());
      signUpName.clear();
      signUpEmail.clear();
      signInPassword.clear();
      signUpPhoneNumber.clear();
      signUpFirstName.clear();
      signUpLastName.clear();
    } on ServerException catch (e) {
      emit(SignUpFailure(
          errMessage: e.errorModel.message, errors: e.errorModel.error));
    }
  }

  confirmEmailResand() async {
    try {
      final response = await api.post(EndPoints.confirmEmailResand,
          data: {ApiKey.email: signUpEmail.text});
      print(response);
      emit(ConfirmEmailSuccess());
    } on ServerException catch (e) {
      emit(ConfirmEmailFailure(errMessage: e.errorModel.message));
    }
  }

  refreshToken() async {
    emit(RefreshTokenLoading());
    String currentToken = CacheHelper().getData(key: ApiKey.token) ?? '';
    String refreshToken = CacheHelper().getData(key: ApiKey.refreshToken) ?? '';
    try {
      final response = await api.post(EndPoints.refreshToken, data: {
        ApiKey.token: currentToken,
        ApiKey.refreshToken: refreshToken,
        
      });
      user = SignInModel.fromJson(response);
      CacheHelper().saveData(key: ApiKey.token, value: user!.token);
      CacheHelper().saveData(key: ApiKey.refreshToken, value: user!.refreshToken);
      final accessExpiry = DateTime.now().add(Duration(minutes: user!.expiresIn));
      CacheHelper().saveData(key: ApiKey.expiresIn, value: accessExpiry);
      CacheHelper().saveData(key: ApiKey.refreshTokenExpiration, value: user!.refreshTokenExpiration);
      print(response);
      emit(RefreshTokenSuccess());
    } on ServerException catch (e) {
      emit(RefreshTokenFailure(
          errMessage: e.errorModel.message, errors: e.errorModel.error));
    }
  }

  sendCode() async {
    try {
      final response = await api.post(EndPoints.forgetPassword,
          data: {ApiKey.email: forgetPasswordEmail.text});
      print(response);
      emit(ForgetPasswordSuccess());
    } on ServerException catch (e) {
      emit(ForgetPasswordFailure(
          errMessage: e.errorModel.message, errors: e.errorModel.error));
    }
  }

  otp() async {
    try {
      final response = await api.post(EndPoints.otp, data: {
        ApiKey.otp: forgetPasswordOtp.text,
        ApiKey.email: forgetPasswordEmail.text
      });
      print(response);
      emit(OTPSuccess());
    } on ServerException catch (e) {
      emit(OTPFailure(
          errMessage: e.errorModel.message, errors: e.errorModel.error));
    }
  }

  resetPassword() async {
    try {
      final response = await api.post(EndPoints.resetPassword, data: {
        ApiKey.email: forgetPasswordEmail.text,
        ApiKey.otp: forgetPasswordOtp.text,
        ApiKey.newPassword: newPassword.text
      });
      print(response);
      emit(ResetPasswordSuccess());
      forgetPasswordEmail.clear();
      forgetPasswordOtp.clear();
      newPassword.clear();
    } on ServerException catch (e) {
      emit(ResetPasswordFailure(
          errMessage: e.errorModel.message, errors: e.errorModel.error));
    }
  }
  void logout() async {
  CacheHelper().clearData;  
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn' , false);
  emit(SignOut()); 
  }
}
