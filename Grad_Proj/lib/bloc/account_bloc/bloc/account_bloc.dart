// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grd_proj/models/user_model.dart';
import 'package:grd_proj/service/api/api_consumer.dart';
import 'package:grd_proj/service/api/end_points.dart';
import 'package:grd_proj/service/errors/exception.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final ApiConsumer api;
  GlobalKey<FormState> editFormKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey();
  TextEditingController newPassword = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  GlobalKey<FormState> otpFormKey = GlobalKey();
  TextEditingController forgetPasswordOtp = TextEditingController();

  AccountBloc(this.api) : super(AccountInitial()) {
    on<ViewAccountDetails>((event, emit) async {
      try {
        final response = await api.get(EndPoints.account);
        final user = UserModel.fromJson(response);
        emit(ViewAccountDetailsSuccess(user: user));
      } on ServerException catch (e) {
        emit(ViewAccountDetailsFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<EditAccountDetails>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.put(EndPoints.account, data: {
          ApiKey.firstName: firstName.text,
          ApiKey.lastName: lastName.text,
          ApiKey.userName: userName.text,
          ApiKey.phoneNumber: phoneNumber.text.isEmpty ? null : phoneNumber.text
        });
        emit(EditAccountDetailsSuccess());
      } on ServerException catch (e) {
        emit(EditAccountDetailsFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<ChangedPassword>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.put(EndPoints.changePassword, data: {
          ApiKey.newPassword: newPassword.text,
          ApiKey.currentPassword: currentPassword.text,
        });
        emit(ChangePasswordSuccess());
      } on ServerException catch (e) {
        emit(ChangePasswordFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<VerifyOtp>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.post(EndPoints.otp, data: {
          ApiKey.otp: forgetPasswordOtp.text,
          ApiKey.email: email.text,
        });
        emit(VerifySuccess());
      } on ServerException catch (e) {
        emit(VerifyFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });


    on<PayForPlan>((event, emit) async {
      try {
        // 1. استدعاء API backend لإنشاء PaymentIntent
        final response = await api.post(EndPoints.webHook,);

        final json = jsonDecode(response.body);
        final clientSecret = json['clientSecret'];

        // 2. تهيئة صفحة الدفع
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Your App',
            style: ThemeMode.light,
          ),
        );

        // 3. عرض صفحة الدفع
        await Stripe.instance.presentPaymentSheet();

        // 4. تأكيد الدفع
        print('✅ Payment successful!');
      } catch (e) {
        print('❌ Payment failed: $e');
      }
    });
  }
}
