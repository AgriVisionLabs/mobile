// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/core/api/api_consumer.dart';
import 'package:grd_proj/core/api/end_points.dart';
import 'package:grd_proj/core/errors/exception.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/models/invation_model.dart';

part 'farm_event.dart';
part 'farm_state.dart';

//each time you call the bolc it request event and state
class FarmBloc extends Bloc<FarmEvent, FarmState> {
  final ApiConsumer api;
  GlobalKey<FormState> createFarmFormKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController soilType = TextEditingController();
  GlobalKey<FormState> addMembermKey = GlobalKey();
  TextEditingController roleName = TextEditingController();
  TextEditingController recipient = TextEditingController();
  FarmModel? farm;
  List<InvitationModel>? invitations;
  // String? farmId ;
  final cacheHelper = CacheHelper();
  Map farmList = {};
  String? invitationId;
  bool isReturn = false;
// final token = cacheHelper.getData(key: 'token');

  //default value
  FarmBloc(this.api) : super(FarmInitial(const [])) {
    //get all farms FarmScreen
    on<OpenFarmEvent>((event, emit) async {
      try {
        final response = await api.get(EndPoints.allFarms);
        soilType.clear();
        name.clear();
        location.clear();
        area.clear();
        recipient.clear();
        roleName.clear();
        if (response is List && response.isNotEmpty) {
          final farms = response
              .map<FarmModel>((json) => FarmModel.fromJson(json))
              .toList();
          emit(FarmsLoaded(farms: farms));
        } else {
          emit(FarmEmpty());
        }
        print(response);
      } on ServerException catch (e) {
        emit(FarmFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteFarmEvent>((event, emit) async {
      try {
        final response =
            await api.delete('${EndPoints.farmControl}/${event.farmId}');
        print(response);
        emit(DeleteFarmSuccess());
      } on ServerException catch (e) {
        emit(DeleteFarmFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
    //Farm info Dasic Info
    on<CreateFarmEvent>((event, emit) async {
      // bloc takes stream of event and give stream of states
      try {
        final response = await api.post(EndPoints.farmsInfo, data: {
          ApiKey.name: name.text,
          ApiKey.area: area.text,
          ApiKey.location: location.text,
          ApiKey.soilType: int.tryParse(soilType.text),
        });
        //create a var to store the response
        farm = FarmModel.fromJson(response);
        // save part we will need every time we use the app to cache
        CacheHelper.saveData(key: 'farmId', value: farm!.farmId);

        print(response);
        emit(FarmInfoSuccess(farm: farm!));
      } on ServerException catch (e) {
        emit(FarmInfoFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    //Add Member Team
    on<AddMember>((event, emit) async {
      try {
        final response = await api.post(
          '${EndPoints.team}/${event.farmId}/Invitations',
          data: {
            ApiKey.recipient: recipient.text,
            ApiKey.roleName: roleName.text,
          },
        );
        print(response);
        emit(AddingMember());
      } on ServerException catch (e) {
        emit(AddingMemberFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<DeleteMember>((event, emit) async {
      try {
        final response = await api.delete(
          '${EndPoints.team}/${event.farmId}/Invitations/${event.invitationId}',
        );
        print(response);
        emit(DeletingMember());
      } on ServerException catch (e) {
        emit(DeletingMemberFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<ViewFarmDetails>((event, emit) async {
      try {
        final response =
            await api.get("${EndPoints.farmControl}/${event.farmId}");
        //create a var to store the response
        farm = FarmModel.fromJson(response);
        emit(FarmSuccess(farm: farm!));
      } on ServerException catch (e) {
        emit(FarmFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<ViewFarmMembers>((event, emit) async {
      try {
        final response = await api.get(
          '${EndPoints.team}/${event.farmId}/Invitations/pending',
        );
        if (response is List && response.isNotEmpty) {
          final invites = response
              .map<InvitationModel>((json) => InvitationModel.fromJson(json))
              .toList();
          emit(LoadingMember(invites: invites));
        } else {
          emit(NoMember());
        }
      } on ServerException catch (e) {
        emit(LoadingMemberFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });

    on<EditFarmEvent>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response =
            await api.put("${EndPoints.farmControl}/${event.farmId}", data: {
          ApiKey.name: event.farmName,
          ApiKey.area: event.area,
          ApiKey.location: event.location,
          ApiKey.soilType: event.soilType
        });
        //create a var to store the response
        emit(FarmEditSuccess());
      } on ServerException catch (e) {
        emit(FarmEditFailure(
            errMessage: e.errorModel.message, errors: e.errorModel.error));
      }
    });
  }
}
