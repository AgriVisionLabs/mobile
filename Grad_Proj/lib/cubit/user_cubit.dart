// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/api_consumer.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/core/errors/exception.dart';
import 'package:grd_proj/cubit/user_state.dart';
import 'package:grd_proj/models/sign_in_model.dart';

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
  //Sign up confirm password
  TextEditingController confirmToken = TextEditingController();
  //Confirm Form key
  GlobalKey<FormState> confirmFormKey = GlobalKey();

  
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
      CacheHelper().saveData(key: ApiKey.id, value: user!.id);
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.errorModel.message));
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
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.errorModel.message , errors: e.errorModel.error));
    }
  }

  confirmEmail() async {
    try {
      emit(ConfirmEmailLoading());
      String url = confirmToken.text;
      String token = url.substring(url.indexOf("token="));
      print(token);
      // ignore: unused_local_variable
      final response = await api
          .post(EndPoints.confirmEmail, data: {
            ApiKey.token: token});
      emit(ConfirmEmailSuccess());
    } on ServerException catch (e) {
      emit(ConfirmEmailFailure(errMessage: e.errorModel.message));
    }
  }


confirmEmailResand() async {
    try {
      final response = await api
          .post(EndPoints.confirmEmailResand, data: {
            ApiKey.email : signUpEmail.text});
      print(response);
      emit(ConfirmEmailSuccess());
    } on ServerException catch (e) {
      emit(ConfirmEmailFailure(errMessage: e.errorModel.message));
    }
  }
}
