import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/core/api/api_consumer.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/core/errors/exception.dart';
import 'package:grd_proj/models/user_bloc.dart';

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
  AccountBloc(this.api) : super(AccountInitial()) {
    on<ViewAccountDetails>((event, emit) async {
      try {
        final response = await api.get(EndPoints.account);
        final user = UserModel.fromJson(response);
        print(
            "=======================================================================");
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
          ApiKey.phoneNumber:
              null,
        });
        emit(EditAccountDetailsSuccess());
      } on ServerException catch (e) {
        emit(EditAccountDetailsFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
  }
}
